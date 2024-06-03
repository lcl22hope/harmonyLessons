import { hilog } from '@kit.PerformanceAnalysisKit'

class Logger {
  private prefix = "Yuzhao"
  private domain = 0xFF00 //log服务专属域的值，16进制，从0x0~0xFFFF之间
  private format = '%{public}s, %{public}s'//具体日志内容字符串的格式，2个字符串

  debug(...args: string[]) {
    hilog.debug(this.domain, this.prefix, this.format, args)
  }

  error(...args: string[]) {
    hilog.error(this.domain, this.prefix, this.format, args)
  }
}

export default new Logger()