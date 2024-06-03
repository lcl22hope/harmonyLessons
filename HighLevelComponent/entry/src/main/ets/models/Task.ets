export default class Task {

  constructor(name: string, updateTime: string, progress: number) {
    this.name = name
    this.updateTime = updateTime
    this.progress = progress
  }

  name: string
  updateTime: string
  progress: number
}