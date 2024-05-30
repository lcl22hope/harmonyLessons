export default class ItemData {
  title: ResourceStr
  image: ResourceStr
  others?: ResourceStr

  constructor(title: ResourceStr, image: ResourceStr, others?: ResourceStr) {
    this.title = title
    this.image = image
    this.others = others
  }
}