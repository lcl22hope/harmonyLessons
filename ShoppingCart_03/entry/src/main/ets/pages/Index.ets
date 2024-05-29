import ThirdLoginBar from '../components/ThirdLoginBar'

@Entry
@Component
struct Index {
  @State acount: string = '';
  @State password: string = '';

  @State Password_ON: Resource = $r('app.media.pass_on');
  @State Password_OFF: Resource = $r('app.media.pass_off');

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width(100)
        .height(100)
        .backgroundColor(Color.White)
        .objectFit(ImageFit.Contain)
        .margin({ top: 80, bottom: 8})
        .borderRadius(20)
      Text('登录界面')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8})
      Text('登录账号以使用更多服务')
        .fontSize(14)
        .fontColor(Color.Gray)

      Row() {
        Text('账号：')
        TextInput({ text: this.acount, placeholder: '请输入用户账号' })
          .placeholderColor(Color.Gray)
          .placeholderFont({size: 14, weight: 400})
          .backgroundColor(Color.Transparent)
          .maxLength(8)
          // .type(InputType.Email | InputType.PhoneNumber)
          .onChange((value: string) => {
            this.acount = value;
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({right: 50})
      .margin({ top: 40 })

      Line({ width: '100%'}).height(1).backgroundColor('#E4E4E4')

      Row() {
        Text('密码：')
        TextInput({ text: this.password, placeholder: '请输入密码' })
          .maxLength(8)
          .placeholderColor(Color.Gray)
          .placeholderFont({size: 14, weight: 400})
          .backgroundColor(Color.Transparent)
          .type(InputType.Password)
          .passwordIcon({
            onIconSrc: this.Password_ON,
            offIconSrc: this.Password_OFF
          })
          .onChange((value: string) => {
            this.password = value;
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({right: 50})
      .margin({ top: 20 })

      Line({ width: '100%'}).height(1).backgroundColor('#E4E4E4')

      Row(){
        Text('短信验证码登录')
          .fontSize(14)
          .fontWeight(400)
          .fontColor(Color.Orange)
          .onClick((event) => {
            AlertDialog.show({
              title: '短信验证码登录',
              message: '提示短信验证码登录',
              confirm: {
                value: '朕已阅',
                action: () => {
                  console.log("短信验证码登录 button clicked")
                }
              }
            })
          })
        Text('忘记密码')
          .fontSize(14)
          .fontWeight(400)
          .fontColor(Color.Orange)
          .onClick((event) => {
            AlertDialog.show({
              title: '忘记密码',
              message: '提示忘记密码',
              confirm: {
                value: '朕已阅',
                action: () => {
                  console.log("忘记密码 button clicked")
                }
              }
            })
          })
      }
      .margin({ top: 5})
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Button('登录')
        .margin({ top: 80 })
        .width('80%')
        .backgroundColor(Color.Orange)

      Text('注册账号')
        .margin({top: 10})
        .fontColor(Color.Orange)
        .fontSize(14)

      ThirdLoginBar()
        .position({ y: '85%'})


    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .alignItems(HorizontalAlign.Center)
    .padding(12)
  }
}