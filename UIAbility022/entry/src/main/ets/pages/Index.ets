
import ToDoItem from '../components/ToDoItem'

@Entry
@Component
struct Index {
  @State message: string = 'ToDoListPage';
  @State todoTasks: Array<string> = [
    "睡觉",
    "coding",
    "焦虑",
    "陪娃",
    "读书",
    "刷小🍠"
  ]

  build() {
    Column({space: 16}) {
      Text("待办")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .lineHeight(33)
        .margin({
          top: 24,
          bottom: 12
        })
        .textAlign(TextAlign.Start)

      ForEach(this.todoTasks, (item: string) => {
        ToDoItem({ content: item })
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#F1F3F5")

  }
}