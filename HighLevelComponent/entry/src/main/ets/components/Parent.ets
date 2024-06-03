import Child from '../components/Child'

@Component
export default struct Parent {
  @State aParentProperty:number = 1;


  build() {
    Column() {
      Child({ aChildProperty: this.aParentProperty})
    }
    .width('100%')
    .height('100%')
  }
}