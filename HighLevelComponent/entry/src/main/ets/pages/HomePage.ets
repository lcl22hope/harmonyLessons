import { CommonConstants } from '../constant/CommonConstant'
import Task from '../models/Task'
import myTasks from '../models/Tasks'
import { currentTime } from '../utils/DateLocal'
import { promptAction } from '@kit.ArkUI'
import AddTask from '../components/AddTask'
import TaskOverview from '../components/TaksOverview'
import TaskList from '../components/TaskList'

@Entry
@Component
export default struct HomePage {
  @State tasks: Task[] = myTasks.allData //任务组
  @State total: number = 0 //任务数
  @State finish: number = 0 //完成数
  // 最新更新
  @State latestUpdate: string = CommonConstants.DEFAULT_PROGRESS_VALUE
  // 总进度
  @Provide @Watch('onProgressChanged') totalProgressChanged: boolean = false

  listScroller: Scroller = new Scroller()


  //新增任务对话框控制器
  dialogController = new CustomDialogController({
    builder: AddTask({
      //确认按钮的回调： 将输入框的值，保存为新任务
      onConfirm: (value): void => {
        this.saveTask(value)
      }
    }),
    alignment: DialogAlignment.Bottom, //显示在底部
    offset: {
      dx: CommonConstants.DIALOG_OFFSET_X,
      dy: $r('app.float.dialog_offset_y')
    },
    customStyle: true, //自定义样式
    autoCancel: false //自动取消：否
  })

  //当总进度发生变化时
  onProgressChanged() {
    this.total = this.tasks.length // 更新总任务数
    const finishTasks = this.tasks.filter((task: Task) => {
      return task.progress == CommonConstants.SLIDER_MAX_VALUE
    }) // 筛选任务组中进度为最大值（100）的数目
    this.finish = finishTasks.length
    this.latestUpdate = currentTime() //使用当前时间
  }

  //保存新增的任务
  saveTask(name: string) {
    if (name === '') { // 如果任务名为空
      promptAction.showToast({ // 弹出提示提醒用户
        message: $r('app.string.cannot_input_empty'),
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      })
      return //退出保存
    }

    myTasks.add(new Task(name, currentTime(), 0)) //增加一条任务
    this.tasks = myTasks.allData //再获取任务组
    //总进度变化
    this.totalProgressChanged = !this.totalProgressChanged
    //关闭对话框
    this.dialogController.close()
    //滑动到最后一个元素
    this.listScroller.scrollToIndex(this.tasks.length - 1)
  }

  @Builder titleBar() { //标题栏，写在Build方法外
    Text($r('app.string.title'))
      .width(CommonConstants.TITLE_WIDTH)
      .height($r('app.float.title_height'))
      .fontSize($r('app.float.title_font'))
      .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
      .textAlign(TextAlign.Start)
      .margin({
        top: $r('app.float.title_margin'),
        bottom: $r('app.float.title_margin')
      })
  }

  build() {
    Column() {
      this.titleBar()
      TaskOverview({ //任务概览
        latestUpdate: this.latestUpdate,
        total: this.total,
        finish: this.finish
      }).padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding_right')
      })
      TaskList({
        tasks: $tasks,
        onAddClick: ():void => this.dialogController.open(),
        listScroller: this.listScroller
      })
        .margin({top: $r('app.float.list_margin_top')})
        .height('40%')

    }
    .backgroundColor($r('app.color.index_background'))
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
  }
}