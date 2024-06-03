import AllTasks from '../models/Tasks'

@Entry
@Component
struct TaksOverviewPage {
  // 接收来上一级的时间信息，Prop 可以有默认值
  @Prop latestUpdate: string = '2024-06-02 16:41:55'

  @Prop finish: number = 1
  @Prop total: number = 3

  @Builder TotalProgress() {
    Row() {
      Column() {
        Text('总进度')
          .titleTextStyle()
        Text(`最近更新：${this.latestUpdate}`)
          .subTextStyle()
      }.alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Row() {
          Text(this.finish.toString())
            .fontSize($r('sys.float.ohos_id_text_size_sub_title3'))
          Text(`/${this.total.toString()}`)
            .fontSize($r('sys.float.ohos_id_text_size_sub_title3'))
        }
        Progress({
          value: this.finish,
          total: this.total,
          type: ProgressType.Ring
        }).width(50)
      }.padding(20)
    }
    .width('100%')
    .padding(20)

  }

  @Builder Header() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(96)
        .height(96)
        .objectFit(ImageFit.Fill)

      Column() {
        Text('2024开发任务')
          .titleTextStyle()
        Text('高质量完成交付')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
          .fontWeight(FontWeight.Normal)
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 20 })
    }
    .width('100%')
    .padding(20)
  }

  build() {
    Column() {
      this.Header()
      this.TotalProgress()
    }
    .height('100%')
    .width('100%')
  }
}

@Extend(Text)
function titleTextStyle() {
  .fontSize($r('sys.float.ohos_id_text_size_dialog_tittle'))
  .fontWeight(FontWeight.Bolder)
}

@Extend(Text)
function subTextStyle() {
  .fontSize($r('sys.float.ohos_id_text_size_sub_title3'))
  .fontColor($r('sys.color.ohos_id_color_text_secondary'))
}