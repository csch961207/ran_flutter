import 'package:dayansoft/event/camera.dart';
import 'package:dayansoft/event/event_material_upload.dart';
import 'package:dayansoft/event/shoot_page.dart';
import 'package:fluro/fluro.dart';

import '../config/routers/router_init.dart';

class EventRouter implements IRouterProvider {
  static String eventMaterialUploadPage = "/event/eventMaterialUploadPage";
  static String cameraApp = "/event/cameraApp";

  @override
  void initRouter(FluroRouter router) {
    router.define(eventMaterialUploadPage,
        handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return EventMaterialUploadPage(
        id: id,
      );
    }));
    router.define(cameraApp,
        handler: Handler(handlerFunc: (_, params) => CameraApp()));
  }
}
