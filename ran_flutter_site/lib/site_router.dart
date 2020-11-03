import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_site/page/entity_page.dart';
import 'package:ran_flutter_site/page/site_page.dart';

class SiteRouter implements IRouterProvider {
  static String sitePage = "/site";
  static String entityPage = "/site/entity";

  @override
  void initRouter(FluroRouter router) {
    router.define(sitePage,
        handler: Handler(handlerFunc: (_, params) => SitePage()));
    router.define(entityPage,
        handler: Handler(handlerFunc: (_, params) {
          String id = params['id']?.first;
          return EntityPage(id: id);
        }));
  }
}