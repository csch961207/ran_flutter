import 'package:dignite_dangjian_flutter_app/meeting/page/add_meetingMinutes_page.dart';
import 'package:dignite_dangjian_flutter_app/meeting/page/meeting_details_page.dart';
import 'package:dignite_dangjian_flutter_app/meeting/page/meeting_page.dart';
import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

import 'page/add_meeting_page.dart';
import 'page/edit_meetingMinutes_page.dart';
import 'page/edit_meetingUsers_page.dart';
import 'page/edit_meeting_page.dart';
import 'page/meetingPictures_page.dart';
import 'page/meetingUsers_page.dart';

class MeetingRouter implements IRouterProvider {
  static String meetingPage = "/meeting";
  static String meetingDetailsPage = "/meetingDetailsPage";
  static String addMeetingPage = "/addMeetingPage";
  static String addMeetingMinutesPage = "/addMeetingMinutesPage";
  static String editMeetingPage = "/editMeetingPage";
  static String editMeetingMinutesPage = "/editMeetingMinutesPage";
  static String meetingUsersPage = "/meetingUsersPage";
  static String meetingPicturesPage = "/meetingPicturesPage";
  static String editMeetingUsersPage = "/editMeetingUsersPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(meetingPage,
        handler: Handler(handlerFunc: (_, params) => MeetingPage()));
    router.define(addMeetingPage,
        handler: Handler(handlerFunc: (_, params) => AddMeetingPage()));
    router.define(meetingDetailsPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return MeetingDetailsPage(id: id);
    }));
    router.define(addMeetingMinutesPage, handler: Handler(handlerFunc: (_, params) {
      String meetingId = params['meetingId']?.first;
      return AddMeetingMinutesPage(meetingId: meetingId);
    }));
    router.define(editMeetingPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return EditMeetingPage(id: id);
    }));
    router.define(editMeetingMinutesPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return EditMeetingMinutesPage(id: id);
    }));
    router.define(meetingUsersPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return MeetingUsersPage(id: id);
    }));
    router.define(meetingPicturesPage, handler: Handler(handlerFunc: (_, params) {
      String meetingId = params['meetingId']?.first;
      return MeetingPicturesPage(meetingId: meetingId);
    }));
    router.define(editMeetingUsersPage, handler: Handler(handlerFunc: (_, params) {
      String meetingId = params['meetingId']?.first;
      return EditMeetingUsersPage(meetingId: meetingId);
    }));
  }
}
