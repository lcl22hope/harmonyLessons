export class Person {
  name: string
  age: number
  isMale: boolean
  address?: string

  constructor(name: string, age: number, isMale: boolean) {
    this.name = name
    this.age = age
    this.isMale = isMale
  }

  detail() {
    let suffix = ''
    if (this.isMale) {
      suffix = (this.age <= 18 ? '活力男生' : '男士')
    } else {
      suffix = (this.age <= 18 ? '可爱女生' : '女士')
    }
    return `${this.name}是一位${this.age}岁的${suffix}。${this.address ?? ''}`
  }
}