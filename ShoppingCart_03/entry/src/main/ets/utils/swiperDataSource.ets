import viewModel from '../viewmodel/HomeViewModel'

export default class SwiperDataSource implements IDataSource {
  private list: ResourceStr[] = viewModel.getSwiperImages();

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): ResourceStr {
    if (index < this.list.length) {
      return this.list[index];
    } else {
      throw new Error("index out of list's boundary");
    }
  }

  registerDataChangeListener(listener: DataChangeListener): void {

  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
  }

}

