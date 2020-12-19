//
//class User {
//
//  bool admin;
//  List<Object> chapterTops;
//  List<Object> collectIds;
//  String email;
//  String icon;
//  int id;
//  String nickname;
//  String password;
//  String token;
//  int type;
//  String username;
//
//	User.fromJsonMap(Map<String, dynamic> map):
//		admin = map["admin"],
//		chapterTops = map["chapterTops"],
//		collectIds = map["collectIds"],
//		email = map["email"],
//		icon = map["icon"],
//		id = map["id"],
//		nickname = map["nickname"],
//		password = map["password"],
//		token = map["token"],
//		type = map["type"],
//		username = map["username"];
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['admin'] = admin;
//		data['chapterTops'] = chapterTops;
//		data['collectIds'] = collectIds;
//		data['email'] = email;
//		data['icon'] = icon;
//		data['id'] = id;
//		data['nickname'] = nickname;
//		data['password'] = password;
//		data['token'] = token;
//		data['type'] = type;
//		data['username'] = username;
//		return data;
//	}
//}


class User {

	String email;
	String name;
	String userName;
	String surname;
	String phoneNumber;

	User.fromJsonMap(Map<String, dynamic> map):
				email = map["email"],
				name = map["name"],
				userName = map["userName"],
				surname = map["surname"],
				phoneNumber = map["phoneNumber"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['email'] = email;
		data['name'] = name;
		data['userName'] = userName;
		data['surname'] = surname;
		data['phoneNumber'] = phoneNumber;
		return data;
	}
}

// ignore: camel_case_types
class LoginRes {

// ignore: non_constant_identifier_names
	String access_token;
	// ignore: non_constant_identifier_names
	int expires_in;
	// ignore: non_constant_identifier_names
	String token_type;
	String scope;

	LoginRes.fromJsonMap(Map<String, dynamic> map):
				access_token = map["access_token"],
				expires_in = map["expires_in"],
				token_type = map["userName"],
				scope = map["scope"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['access_token'] = access_token;
		data['expires_in'] = expires_in;
		data['token_type'] = token_type;
		data['scope'] = scope;
		return data;
	}
}
