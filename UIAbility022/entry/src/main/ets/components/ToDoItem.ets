@Component
export default struct ToDoItem {
  private content?: string
  @State isComplete: boolean = false
  @State private xPosition: number = 0
  @State private yPosition: number = 0
  @State private xOffset: number = 0
  @State private yOffset: number = 0

  @Builder
  labelIcon(icon: ResourceStr) {
    Image(icon)
      .objectFit(ImageFit.Fill)
      .width(28)
      .height(28)
      .margin(20)
  }

  build() {
    Row() {
      if (this.isComplete) {
        this.labelIcon($r('app.media.ic_ok'))
      } else {
        this.labelIcon($r('app.media.ic_default'))
      }

      Text(this.content)
        .fontSize(20)
        .fontWeight(500)
        .opacity(this.isComplete ? 0.4 : 1)
        .decoration({
          type: this.isComplete
            ? TextDecorationType.LineThrough
            : TextDecorationType.Underline
        })
    }
    .borderRadius(24)
    .backgroundColor(Color.White)
    .width("90%")
    .height(64)
    .onClick(() => {
      this.isComplete = !this.isComplete
    })
    .translate({x: this.xOffset})
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent | undefined) => {
          console.info("Pan start")
        })
        .onActionUpdate((event: GestureEvent | undefined) => {
          if(event) {
            this.xOffset += event.offsetX
          }
        })
    )
  }
}