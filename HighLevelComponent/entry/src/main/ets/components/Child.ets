
@Component

export default struct Child {
  @Prop aChildProperty: number;

  build() {
    Text(`${this.aChildProperty}`)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Black)
      .height(20)
      .width('100%')
  }
}