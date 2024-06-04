import { CommonConstants } from '../constant/CommonConstant'
import Task from '../models/Task'
import TaskItem from './TaskItem'
import myTasks from '../models/Tasks'

// @Entry
@Component
export default struct TaskList {
  // 总进度是否发生变化。 预览用State，实际：Consume，因为子组件可以变更它
  @Consume totalProgressChanged: boolean // = false
  // 是否开启编辑模式
  @State isEditMode: boolean = false
  // 选中的任务组
  @State selectedTasks: boolean[] = []
  // 点击的任务，默认没选中任何任务
  @State selectAll: boolean = false //全选
  @Link tasks: Task[]
  //   = [
  //   new Task('task 1999', '16:12', 20),
  //   new Task('task 202', '20.55', 35),
  //   new Task('task xx', '07:37', 90),
  //   new Task('task 1999', '16:12', 20),
  //   new Task('task 202', '20.55', 35),
  // ] //任务数据，此处3条演示数据；实际应该使用Link，预览用State

  // 点击的任务，默认没选中任何任务
  @State clickIndex: number = CommonConstants.DEFAULT_CLICK_INDEX

  onAddClick?: () => void //点击新任务按钮的事件（回调）

  listScroller?: Scroller

  @Provide @Watch('onCheckedChanged') totalCheckedChanged: boolean = false

  onCheckedChanged() {
    console.log(`onCheckedChanged selectedTasks ==== ${this.selectedTasks.length}`)
    console.log(`onCheckedChanged tasks ==== ${this.tasks.length}`)
    if (this.selectedTasks.filter((v:boolean) => v).length === this.tasks.length) {
      this.selectAll = true
    } else {
      this.selectAll = false
    }
  }


  @Builder TasksHeader() {
    Row() {
      Text($r('app.string.sub_goals'))
        .fontSize($r('app.float.secondary_title'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
      Blank() //中间空白
      if (this.tasks.length > 0) { //如果有任务，才可以编辑
        // 此处是编辑状态代码
        if (this.isEditMode) { // 如果处于可编辑状态，有取消、全选
          Text($r('app.string.cancel_button')) // 取消按钮
            .operateTextStyle($r('app.color.main_blue'))
            .margin({ left: $r('app.float.operate_button_margin')})
            .onClick(() => {
              this.isEditMode = false //取消场景下为非编辑模式
              this.selectAll = false //全选设置否
              //根据任务数组，映射一个全部是false的数组
              this.selectedTasks = this.tasks.map(() => false)
              console.log('取消： ' + JSON.stringify(this.selectedTasks))
            })

          Text($r('app.string.select_all_button'))
            .operateTextStyle($r('app.color.main_blue'))
            .margin({ left: $r('app.float.operate_button_margin')})
          Checkbox() //选择框
            .select(this.selectAll)
            .selectedColor($r('app.color.main_blue')) //选中色
            .width(CommonConstants.CHECKBOX_WIDTH)
            .onClick(() => {
              this.selectAll = !this.selectAll //全选状态反转
              //根据任务数组，映射一个全选状态的数组，全部是true或者false
              this.selectedTasks = this.tasks.map(() => this.selectAll)
              console.log('全选： ' +this.selectAll +  JSON.stringify(this.selectedTasks))
            })
        } else { //不在编辑模式时，显示编辑文字按钮
          Text($r('app.string.edit_button'))
            .operateTextStyle($r('app.color.main_blue'))
            .onClick(() => {
              this.isEditMode = true // 启动编辑模式
            })
        }
      }
    }
    .width(CommonConstants.FULL_WIDTH)
    .height($r('app.float.history_line_height'))
    .padding({
      left: $r('app.float.list_padding'),
      right: $r('app.float.list_padding_right')
    })
  }

  isAnyTaskSelected() {
    return this.selectedTasks.filter(selected => selected).length > 0
  }

  delSelected() { // 删除选中任务，并重置选中状态
    myTasks.del(this.selectedTasks) // 删除选中的任务
    this.tasks = myTasks.allData // 重新获取全部任务
    // 总进度状态发生变化
    this.totalProgressChanged = !this.totalProgressChanged
    this.isEditMode = false // 删除后退出编辑模式
    // 选中任务全部清空（重置）
    this.selectedTasks = this.tasks.map(() => false)
    this.selectAll = false //取消全部选中
  }


  build() {
      Column() {
        this.TasksHeader()
        List({ space: CommonConstants.LIST_SPACE, scroller: this.listScroller }) {
          ForEach(this.tasks, (item: Task, index: number) => {
            ListItem() {
              TaskItem({
                task: item,
                index: index,
                isEditMode: this.isEditMode,
                selectedTasks: this.selectedTasks, //被选中的任务（双向）
                clickIndex: this.clickIndex //被选中的任务序号（双向）
              })
            }.padding(10)
          })
        }
        .edgeEffect(EdgeEffect.Spring)
        .margin({ top: $r('app.float.list_margin_top') })
        .width(CommonConstants.FULL_WIDTH)
        Blank()
        Row() {
          if(this.isEditMode) {
            Button($r('app.string.delete_button'))
              //如果有选中的任务，则显示为非透明，否则透明
              .opacity(this.isAnyTaskSelected() ? CommonConstants.NO_OPACITY : CommonConstants.OPACITY)
                //如果有选中的任务，按钮有效，否则无效 （不可交互）
              .enabled(this.isAnyTaskSelected())
                //删除时敏感操作，红色样式
              .operateButtonStyle($r('app.color.main_red'))
              .onClick(()=> {
                this.delSelected()
              })
          } else {
            // 新增任务的按钮
            Button($r('app.string.add_task'))
              .operateButtonStyle($r('app.color.main_blue'))
              .onClick(() => {
                if (this.onAddClick) {
                  this.onAddClick()
                }
              })
          }
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20, bottom: this.tasks.length > 0 ? 10 : 20 })
      }
      .width(CommonConstants.FULL_WIDTH)
    }

}


// "可互动"文字样式
@Extend(Text) function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.text_button_font'))
  .fontColor(color)
  .lineHeight($r('app.float.text_line_height'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
}
// "可互动"按钮样式
@Extend(Button) function operateButtonStyle(color: Resource) {
  .fontSize($r('app.float.button_font'))
  .fontColor(color)
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .backgroundColor($r('app.color.button_background'))
}