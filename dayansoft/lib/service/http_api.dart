class HttpApi {
  /// 请求地址
  static const String basicsApi = 'http://audi.salespromot.com:11020/';

  /// 登录
  static const String login = 'faw/app/login';

  /// 活动列表接口
  static const String findAllEvents = 'faw/events/findAllEvents';

  /// 获取服务器时间
  static const String getNowTime = 'faw/fileuploader/getNowTime';

  /// 获取指定活动附件数量接口
  static const String countFilesByEventId = 'faw/images/countFilesByEventId';

  /// 上传文件
  static const String uploader = 'faw/fileuploader/uploader';
}
