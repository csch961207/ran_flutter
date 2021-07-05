import 'package:ran_flutter_core/config/net/http.dart';
import 'model/add_meetingMinutes_model.dart';
import 'model/add_meeting_model.dart';
import 'model/meetingMinutes_model.dart';
import 'model/meeting_item_model.dart';
import 'model/meeting_list_model.dart';

class MeetingRepository {
  ///会议

  /// 获取会议详情
  static Future<MeetingItem> getMeeting(String id) async {
    var response = await http.get(
      '/api/Dangjian/Meeting/${id}',
    );
    return MeetingItem.fromJson(response.data);
  }

  /// 获取会议列表
  static Future<MeetingList> getMeetingList({String organizationId, String titleKeyword, int year, int month,
      int maxResultCount, int skipCount}) async {
    Map<String, String> params = Map();
    params["OrganizationId"] = organizationId;
    if(titleKeyword != null){
      params["TitleKeyword"] = titleKeyword;
    }
    if(year != null){
      params["Year"] = year.toString();
    }
    if(month != null){
      params["Month"] = month.toString();
    }
    if(maxResultCount != null){
      params["MaxResultCount"] = maxResultCount.toString();
    }
    if(skipCount != null){
      params["SkipCount"] = skipCount.toString();
    }
    var response = await http.get('/api/Dangjian/Meeting',
        queryParameters: params);
    return MeetingList.fromJson(response.data);
  }

  /// 删除会议
  static Future<String> deleteMeeting(String id) async {
    Map<String, String> params = Map();
    params["id"] = id;
    var response = await http.delete('/api/Dangjian/Meeting',queryParameters: params);
    return response.statusCode.toString();
  }

  /// 添加会议
  static Future<String> postMeeting(AddMeeting addMeetingData) async {
    var response =
    await http.post('/api/Dangjian/Meeting', data: addMeetingData);
    return response.statusCode.toString();
  }

  /// 编辑会议
  static Future<String> putMeeting(String id,AddMeetingItem updateMeetingData) async {
    var response =
    await http.put('/api/Dangjian/Meeting', data: updateMeetingData,queryParameters: {"id": id});
    return response.statusCode.toString();
  }

  /// 会议纪要

  /// 获取会议纪要详情
  static Future<MeetingMinutes> getMeetingMinutes(String id) async {
    var response = await http.get(
      '/api/Dangjian/MeetingMinutes/${id}',
    );
    return MeetingMinutes.fromJson(response.data);
  }

  /// 添加会议纪要
  static Future<String> postMeetingMinutes(AddMeetingMinutes addMeetingMinutesData) async {
    var response =
    await http.post('/api/Dangjian/MeetingMinutes', data: addMeetingMinutesData);
    return response.statusCode.toString();
  }

  /// 编辑会议纪要
  static Future<String> putMeetingMinutes(String id, AddMeetingMinutes addMeetingMinutesData) async {
    Map<String, String> params = Map();
    params["id"] = id;
    var response =
    await http.put('/api/Dangjian/Meeting', data: addMeetingMinutesData,queryParameters: params);
    return response.statusCode.toString();
  }

  /// 删除文件
  static Future<String> deleteMeetingMinutes(String id) async {
    Map<String, String> params = Map();
    params["id"] = id;
    var response = await http.delete('/api/Dangjian/MeetingMinutes',queryParameters: params);
    return response.statusCode.toString();
  }

  /// 参会人

  /// 编辑会议参会人
  static Future<String> putMeetingUser(String meetingId, AddMeetingUsers addMeetingUsersData) async {
    Map<String, String> params = Map();
    params["meetingId"] = meetingId;
    var response =
    await http.put('/api/Dangjian/MeetingUser', data: addMeetingUsersData,queryParameters: params);
    return response.statusCode.toString();
  }

  /// 调用自动签到
  static Future<String> putAutoSignIn(String meetingId, String blobName) async {
    Map<String, String> params = Map();
    params["meetingId"] = meetingId;
    params["blobName"] = blobName;
  var response =
    await http.put('/api/Dangjian/MeetingUser/AutoSignIn', queryParameters: params);
    return response.statusCode.toString();
  }

  /// 手动签到
  static Future<String> putSignIn(String id,bool isSignIn, String blobName) async {
    Map<String, String> params = Map();
    params["id"] = id;
    params["isSignIn"] = isSignIn.toString();
    params["blobName"] = blobName;
    var response =
    await http.put('/api/Dangjian/MeetingUser/SignIn', queryParameters: params);
    return response.statusCode.toString();
  }

}
