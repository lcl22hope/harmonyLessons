import viewModel from '../viewmodel/HomeViewModel'
import ItemData from '../viewmodel/ItemData'
@Entry
@Component
export default struct MyPage {
  @State userName: string = '玉先生';
  @State userEmail: string = 'test@gmail.com';

  @State message: string = 'Hello World';

  build() {
    Column({space: 12}) {
      Text('我的')
        .fontSize(30)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 20 })

      Row(){
        Image($r('app.media.account'))
          .width(60)
          .height(60)
        Column() {
          Text(this.userName)
            .fontSize(24)
          Text(this.userEmail)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: 20})
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(12)
      
      List(){
        ForEach(viewModel.getSettingList(), (item: ItemData) => {
          ListItem() {
            Row() {
              Row() {
                Image(item.image)
                  .width(28)
                  .height(28)
                  .margin({ right: 20 })
                Text(item.title)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
              }
              if (!item.others) {
                Image($r('app.media.right_grey'))
                  .width(20)
                  .height(20)
              } else {
                Toggle({ type: ToggleType.Switch, isOn: false})
              }

            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              left: 10,
              right: 10
            })
          }
          .height(64)
          .width('100%')
        }, (item: ItemData)=> JSON.stringify(item))
      }
      .divider({
        strokeWidth: 1,
        color: Color.Gray,
        startMargin: 50,
        endMargin: 10
      })
      .backgroundColor(Color.White)
      .borderRadius(12)

      Button('退出')
        .fontColor(Color.Red)
        .fontWeight(FontWeight.Bold)
        .fontSize(20)
        .width('80%')
        .height(40)
        .borderWidth(1)
        .backgroundColor('#F1F3FF')
        .margin({top: 40})
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
    .padding(12)
  }
}