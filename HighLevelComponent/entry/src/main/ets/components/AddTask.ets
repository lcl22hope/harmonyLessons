@Entry
@Component
@CustomDialog
export default struct AddTask {
  @State taskName: string = ''
  private ctrl?: CustomDialogController
  private onConfirm?:(value:string) => void

  build() {
    Column() {
      Text('添加任务')
        .font({ size: 24, weight: FontWeight.Bold })
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 20 })

      TextInput({
        text: this.taskName,
        placeholder: '请输入名称',
      }).onChange((value: string) => {
        this.taskName = value
      })


      Row() {
        Button('取消')
          .onClick(()=> {
            this.ctrl?.close()
          })

        Button('确定')
          .onClick(() => {
            this.onConfirm && this.onConfirm(this.taskName)
          })
      }
      .margin({top: 12})
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
    }
    .margin({left: 20, right: 20})
    .padding(20)
    .borderRadius(24)
    .backgroundColor(Color.White)
  }

}