import HomePage from '../pages/HomePage'
import MyPage from '../pages/MyPage'

@Entry
@Component
export default struct TabController {
  @State currentIdx: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder TabBuilder(title: string, index: number, selectImg: ResourceStr, normalImg: ResourceStr) {
    Column() {
      Image(this.currentIdx === index ? selectImg : normalImg)
        .width(25)
        .height(25)
      Text(title)
        .margin({ top: 4 })
        .fontSize(10)
        .fontColor(this.currentIdx === index ? '#1698CE' : '6B6B6B')
    }
    .justifyContent(FlexAlign.Center)
    .height(56)
    .width('100%')
    .onClick(() => {
      this.currentIdx = index;
      this.tabsController.changeIndex(this.currentIdx);
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        HomePage()
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('首页', 0,
        $r('app.media.ic_home_selected'), $r('app.media.ic_home')))

      TabContent() {
        MyPage()
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('我的', 1,
        $r('app.media.ic_mine_selected'), $r('app.media.ic_mine')))
    }
    .width('100%')
    .backgroundColor(Color.White)
    .barHeight(56)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIdx = index;
    })
  }
}