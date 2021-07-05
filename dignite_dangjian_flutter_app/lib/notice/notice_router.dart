import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'page/notice_details_page.dart';
import 'page/notice_page.dart';

class NoticeRouter implements IRouterProvider {
  static String noticePage = "/notice";
  static String noticeDetailsPage = "/noticeDetailsPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(noticePage,
        handler: Handler(handlerFunc: (_, params) => NoticePage()));
    router.define(noticeDetailsPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return NoticeDetailsPage(id: id);
    }));
  }
}
