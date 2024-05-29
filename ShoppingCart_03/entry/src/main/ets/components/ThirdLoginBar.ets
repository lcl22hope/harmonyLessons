import { LoginType} from '../utils/consts'

@Component
export default struct ThirdLoginBar {

  handleClick(event: ClickEvent, type: LoginType):void {
    const args = arguments;
    console.log('args ===== ', args);
    switch (type) {
      case LoginType.Huawei:
        console.log('login with Huawei account')
        break;
      case LoginType.Wechat:
        console.log('login with Wechat account')
        break;
      case LoginType.Weibo:
        console.log('login with Weibo account')
        break;
      default:
        console.log('not support this login type!')
        break
    }
  }

  build() {
    Column() {
      Text('其他登录方式')
        .fontColor(Color.Gray)
        .fontSize(14)
        .margin({bottom: 10})
      Row() {
        Image($r('app.media.huawei'))
          .width(60)
          .height(60)
          .onClick((event) => this.handleClick(event, LoginType.Huawei))
        Image($r('app.media.wechat'))
          .width(60)
          .height(60)
          .onClick((event) => this.handleClick(event, LoginType.Wechat))
        Image($r('app.media.weibo'))
          .width(60)
          .height(60)
          .onClick((event) => this.handleClick(event, LoginType.Weibo))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .align(Alignment.Center)
    .width('100%')
    .backgroundColor(Color.Transparent)
  }
}