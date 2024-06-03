import Parent from '../components/Parent'
import AddTask from '../components/AddTask'
import Logger from '../utils/Logger'

@Entry
@Component
struct Index {
  @State message: string = '添加任务';

  dialogController = new CustomDialogController({
    builder: AddTask({
      onConfirm: (value) => {
        Logger.debug('首页', value)
        this.dialogController.close()
      }
    }),
    alignment:DialogAlignment.Center,
    customStyle: true,
    autoCancel: true,
    offset: { dx: 0, dy: 0}
  })

  build() {
    Column() {
      Parent({ aParentProperty: 666 })
        .onClick(() => {
          this.dialogController.open()
        })
    }
    .height('100%')
    .width('100%')
  }
}