import { currentTime } from '../utils/DateLocal'
import Task from '../models/Task'
import { CommonConstants } from '../constant/CommonConstant'
import { ProgressEdit } from './ProgressEdit'
import myTasks from '../models/Tasks'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
export default struct TaskItem {
  // 当前的任务；给一个默认值，方便调试
  @Prop task: Task //= new Task('task 1', currentTime(), 10)
  // 当前任务的序号
  index = 0
  // 总进度是否发生变化
  @Consume totalProgressChanged: boolean // = false
  //选中的任务组，来自上级，如果更新需要回传（@link）为了方便调试，暂用@State
  @Link selectedTasks: boolean[]
  //是否开启了编辑模式，由上级组件决定
  @Prop isEditMode: boolean = true
  //展开进度面板
  @State isExpanded: boolean = true
  //进度面板滑动模式，避免点击时和滑块点击冲突
  @State mode: SliderChangeMode = CommonConstants.DEFAULT_SLIDER_MODE

  @Consume totalCheckedChanged: boolean

  // 点击的任务，保存其序号并回传（@link）为了调试方便，暂用@State
  // 并且监听点击，@Watch 处理函数changeIndex
  @State @Watch('onClickIndex') clickIndex: number = 0

  // 索引点击监听器：如果点击的不是当前的任务，则折叠进度编辑面板
  onClickIndex() {
    console.log('index=====' + this.clickIndex, this.index)
    if (this.clickIndex !== this.index) {
      this.isExpanded = false
    } else {
      this.isExpanded = true
    }
  }

  // 最新进度
  @State latestProgress: number = 0
  // 更新日期
  @State updateDate?: string = ''

  //页面即将显示
  aboutToAppear(): void {
    this.latestProgress = this.task.progress
    this.updateDate = this.task.updateTime
  }

  //任务信息栏
  @Builder TaskInfo() { //任务信息文字栏
    Row(){
      Text(this.task.name) //任务名
        .fontSize($r('app.float.button_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r('app.color.title_black_color'))
        .width(CommonConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(CommonConstants.MAX_LINES)
      Blank()
      Column() { //进度信息
        Text(`${!this.latestProgress ? 0 : this.latestProgress}%`) //任务进度
        Row(){
          Text($r('app.string.latest_updateTime')).opacityTextStyle()
          Text(this.updateDate).opacityTextStyle()
        }.margin({top: $r('app.float.text_margin')})
      }.alignItems(HorizontalAlign.End) //列内容居右排列
    }
    // .padding(20)
    .width(CommonConstants.FULL_WIDTH)
  }


  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Column() {
        // Text('开启/关闭编辑模式')
        //   .opacityTextStyle()
        //   .onClick(() => {
        //     this.isEditMode = !this.isEditMode
        //   })
        this.TaskInfo()
        if (this.isExpanded) {
          Blank()
          ProgressEdit({
            progress: this.latestProgress, // 最新进度
            mode: this.mode, // 滑动模式
            onCancel: () => this.isExpanded = false, //取消事件：折叠面板
            onConfirm:(value: number) => { // 确认更新进度后
              this.latestProgress = value // 把最新进度设置为滑动后的值
              this.updateDate = currentTime() // 使用最新的系统日期更新
              console.log('latestProgress === ', this.latestProgress)
              // 如果更新指定索引的任务成功
              if (myTasks.updateTo(this.index, this.latestProgress, this.updateDate)) {
                this.totalProgressChanged = !this.totalProgressChanged // 整体进度发生变化
              }
              this.isExpanded = false // 更新进度折叠面板
            }
          }) // 进度面板
            .transition({ //折叠动画
              scale: { //尺寸缩放： 收缩成一条线消失
                x: CommonConstants.TRANSITION_ANIMATION_X, // x轴方向为原来1倍
                y: CommonConstants.TRANSITION_ANIMATION_Y  // y轴方向为原来0倍
              }
            })
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(this.isExpanded ? $r('app.float.expanded_item_height') : $r('app.float.edit_panel_height'))
      .opacity(// 如果进度拉满（100），则整个容器变成半透明状态。否则不透明状态
        this.latestProgress ===  CommonConstants.SLIDER_MAX_VALUE && !this.isEditMode ? CommonConstants.OPACITY : CommonConstants.NO_OPACITY
      )
      .borderRadius(CommonConstants.LIST_RADIUS) // 单个任务列表
      .animation({ duration: CommonConstants.DURATION }) // 属性动画：
      .backgroundColor(this.selectedTasks[this.index] ? $r('app.color.edit_blue') : Color.White) //背景色：当前任务蓝色
      .onClick(() => { //点击事件处理
        console.log('mode ===' + '' + this.mode);
        if (this.mode === CommonConstants.CLICK_SLIDER_MODE) { // 如果点击的是滑块
          this.mode = CommonConstants.DEFAULT_SLIDER_MODE // 滑块事件归位
          return //返回。不继续处理 任务本身容器的点击事件
        }
        console.log('isEditMode ===' + '' + this.isEditMode);

        if (this.isEditMode) { //非编辑状态下
          // 显示动画：折叠、展开效果
          animateTo({ duration: CommonConstants.DURATION }, () => {
            this.isExpanded = !this.isExpanded
          })

          this.clickIndex = this.index // 点击索引赋值
        } else {
          promptAction.showToast({
            message: $r('app.string.only_expand_under_edit_mode'),
            duration: CommonConstants.TOAST_TIME,
            bottom: CommonConstants.TOAST_MARGIN_BOTTOM
          })
        }
      })
      .padding({
        top: $r('app.float.list_padding_top'),
        bottom: $r('app.float.list_padding_bottom'),
        left: $r('app.float.list_padding'),
        right: this.isEditMode ? $r('app.float.list_edit_padding') : $r('app.float.list_padding') //编辑模式，右边距加大
      })
      // 此处是编辑模式的勾选框
      if (this.isEditMode) {
        Column() {
          Checkbox() //单选框
            .margin({ right: $r('app.float.list_padding')})
            .width(CommonConstants.CHECKBOX_WIDTH)
            .selectedColor($r('app.color.main_blue'))
            .onChange((isChecked: boolean) => { // 点击后，给任务选择状态赋值
              this.selectedTasks[this.index] = isChecked
              this.totalCheckedChanged = !this.totalCheckedChanged
            })
            // 选中状态，与点击绑定
            .select(this.selectedTasks[this.index])
        }
        .height(CommonConstants.FULL_HEIGHT)
        .justifyContent(FlexAlign.Center)
      }
    }
    .height(this.isExpanded ? $r('app.float.expanded_item_height') : $r('app.float.edit_panel_height'))
  }

}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}