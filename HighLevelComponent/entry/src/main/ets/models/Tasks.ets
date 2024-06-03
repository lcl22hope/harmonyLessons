import Task from './Task'

class Tasks {
  private _allData:Task[] = []

  public get allData():Task[] {
    return this._allData
  }

  add(task: Task) {
    this._allData.push(task)
  }
  //删除选中的1个或多个任务, selected 为选中的状态组，长度与任务数一致
  del(selected: boolean[]) {
    for (let i = 0; i < selected.length; i++) {
      if (selected[i]) { //如果元素选中
        this._allData.splice(i, 1) //删除选中的元素
      }
    }

    // 方法2
    // 对任务组进行筛选，只取index序号
    // this._allData = this._allData.filter((_, index) => {
    //   // 如果某一项的序号，在选中任务组中存在，则排除掉
    //   return !selected.includes(selected[index])
    // })
  }
  //获取最新一条任务的进度：因为是新任务是添加到数组最后的（add方法），所以取数组最后的元素
  getLatestProgress() {
    if (this._allData.length == 0) {
      return 0;
    }
    //return this._allData.splice(-1)[0].progress
    return this._allData[this._allData.length - 1].progress
  }

  //更新指定任务的进度和日期
  updateTo(index: number, progress: number, updateTime: string): boolean {
    if (this._allData[index]) { //如果是有效任务（即索引可以访问）
      this._allData[index].progress = progress
      this._allData[index].updateTime = updateTime
      return true
    }
    return false
  }
}

export default new Tasks()