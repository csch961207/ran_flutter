import 'package:dignite_dangjian_flutter_app/partyMember/page/add_partyMember_page.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/page/edit_partyMember_page.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/page/partyMember_details_page.dart';
import 'package:dignite_dangjian_flutter_app/partyMember/page/partyMember_page.dart';
import 'package:fluro/fluro.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';

class PartyMemberRouter implements IRouterProvider {
  static String partyMemberPage = "/partyMember";
  static String addPartyMemberPage = "/addPartyMemberPage";
  static String partyMemberDetailsPage = "/partyMemberDetailsPage";
  static String editPartyMemberPage = "/EditPartyMemberPage";

  @override
  void initRouter(FluroRouter router) {
    router.define(partyMemberPage,
        handler: Handler(handlerFunc: (_, params) => PartyMemberPage()));
    router.define(addPartyMemberPage,
        handler: Handler(handlerFunc: (_, params) => AddPartyMemberPage()));
    router.define(partyMemberDetailsPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return PartyMemberDetailsPage(id: id);
    }));
    router.define(editPartyMemberPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id']?.first;
      return EditPartyMemberPage(id: id);
    }));
  }
}
