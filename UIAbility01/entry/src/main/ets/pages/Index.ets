import { Person } from './Person'

@Entry
@Component
struct Index {
  @State name: string = "看第一位用户姓名"
  @State detail1: string = "看第二位用户的描述"
  @State detail2: string = '看第三位用户的描述'

  build() {
    Column() {
      Text(this.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          let p1 = new Person("Tommy", 22, true)
          this.name = p1.name
        })

      Text(this.detail1)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          let p1 = new Person("Alice", 18, true)
          this.detail1 = p1.detail()
        })

      Text(this.detail2)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          let p1 = new Person("极客大侠", 38, true)
          p1.address = "北京朝阳"
          this.detail2 = p1.detail()
        })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .height('100%')
    .width('100%')
  }
}