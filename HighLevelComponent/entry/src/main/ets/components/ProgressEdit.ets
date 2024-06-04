
@Entry
@Component export
struct ProgressEdit {

  @Prop progress: number = 10 //因为需要把progress回传给上级,实际应该用 Link
  @State mode: SliderChangeMode = SliderChangeMode.Begin
  //点击取消
  onCancel?: () => void
  //点击确认
  onConfirm?: (progress: number) => void

  build() {
    Column() {
      Row({ space: 10}) {
        Slider({
          value: this.progress, //进度
          step: 1, //步长
          style: SliderStyle.InSet //滑块在轨道内
        })
          .width('80%')
          .onChange((value, mode) => {
            this.progress = Math.trunc(value)
            this.mode = mode
          })

        Text(`${this.progress}%`)
          .fontColor($r('sys.color.ohos_id_text_color_active'))
          .fontSize($r('sys.float.ohos_id_text_size_button1'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        TextButton({ title: '取消'})
          .onClick(() => {
            this.onCancel && this.onCancel()
          })

        TextButton({title: '确认'})
          .onClick(() => {
            this.onConfirm && this.onConfirm(this.progress)
          })
      }
      .margin({top:20})
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
  }
}




// @Entry
@Component
struct TextButton {
  @State bgColor: Resource = $r('sys.color.ohos_id_color_button_normal')
  @Prop title: ResourceStr


  build() {
    Text(this.title)
      .backgroundColor(this.bgColor)
      .fontSize($r('sys.float.ohos_id_text_size_button1')) //系统1号按钮大小
      .fontColor($r('sys.color.ohos_id_text_color_active')) //活跃文字颜色
      .width(96)
      .textAlign(TextAlign.Center)
      .onTouch((e) => {
        if (e.type === TouchType.Down) {
          this.bgColor = $r('sys.color.ohos_id_picker_press_color')
        } else if (e.type === TouchType.Up) {
          this.bgColor = $r('sys.color.ohos_id_color_button_normal')
        }
      })
      .padding(5)
      .borderRadius(10)
  }
}