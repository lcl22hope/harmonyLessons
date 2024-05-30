import viewModel from '../viewmodel/HomeViewModel'
import SwiperDataSource from '../utils/swiperDataSource'
import ItemData from '../viewmodel/ItemData'
@Entry
@Component
export default struct HomePage {

  build() {
    Scroll() {
      Column({space: 10}) {
        Text('首页')
          .fontSize(30)
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 20 })

        Swiper() {
          LazyForEach(new SwiperDataSource(), (item: ResourceStr) => {
            Image(item)
              .borderRadius(16)
              .width('100%')
          })
        }
        .autoPlay(true)

        Grid() {
          ForEach(viewModel.getMiddleGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.image)
                  .width(24)
                  .height(24)
                Text(item.title)
                  .fontSize(12)
                  .margin({ top:4 })
              }
              .width('100%')
              .height('100%')
            }
          }, (item: ItemData) => JSON.stringify(item))
        }
        .rowsTemplate('1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .padding({ top: 12, bottom: 12 })
        .columnsGap(8)
        .height(124)
        .backgroundColor(Color.White)
        .borderRadius(24)

        Text('列表')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Grid() {
          ForEach(viewModel.getBotomGridData(), (item: ItemData) => {
            GridItem(){
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.White)
                Text(item.others)
                  .margin({ top: 4 })
                  .fontSize(12)
                  .fontColor(Color.White)
              }
              .padding(12)
              .alignItems(HorizontalAlign.Start)
              .backgroundImage(item.image)
              .backgroundImageSize(ImageSize.Cover)
              .borderRadius(12)
              .width('100%')
              .height('100%')
            }
          }, (item: ItemData) => JSON.stringify(item))
        }
        .rowsTemplate('1fr 1fr')
        .columnsTemplate('1fr 1fr')
        .rowsGap(8)
        .columnsGap(8)
        .height(260)
      }
      .backgroundColor('#F1F3F5')
      .padding(12)
    }
  }
}