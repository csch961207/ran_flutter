class ApplicationConfiguration {
  Localization localization;
  Auth auth;
  Setting setting;
  CurrentUser currentUser;
  Setting features;
  MultiTenancy multiTenancy;
  CurrentTenant currentTenant;
  Timing timing;
  Clock clock;
  ObjectExtensions objectExtensions;

  ApplicationConfiguration(
      {this.localization,
      this.auth,
      this.setting,
      this.currentUser,
      this.features,
      this.multiTenancy,
      this.currentTenant,
      this.timing,
      this.clock,
      this.objectExtensions});

  ApplicationConfiguration.fromJson(Map<String, dynamic> json) {
    localization = json['localization'] != null
        ? new Localization.fromJson(json['localization'])
        : null;
    auth = json['auth'] != null ? new Auth.fromJson(json['auth']) : null;
    setting =
        json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
    currentUser = json['currentUser'] != null
        ? new CurrentUser.fromJson(json['currentUser'])
        : null;
    features = json['features'] != null
        ? new Setting.fromJson(json['features'])
        : null;
    multiTenancy = json['multiTenancy'] != null
        ? new MultiTenancy.fromJson(json['multiTenancy'])
        : null;
    currentTenant = json['currentTenant'] != null
        ? new CurrentTenant.fromJson(json['currentTenant'])
        : null;
    timing =
        json['timing'] != null ? new Timing.fromJson(json['timing']) : null;
    clock = json['clock'] != null ? new Clock.fromJson(json['clock']) : null;
    objectExtensions = json['objectExtensions'] != null
        ? new ObjectExtensions.fromJson(json['objectExtensions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localization != null) {
      data['localization'] = this.localization.toJson();
    }
    if (this.auth != null) {
      data['auth'] = this.auth.toJson();
    }
    if (this.setting != null) {
      data['setting'] = this.setting.toJson();
    }
    if (this.currentUser != null) {
      data['currentUser'] = this.currentUser.toJson();
    }
    if (this.features != null) {
      data['features'] = this.features.toJson();
    }
    if (this.multiTenancy != null) {
      data['multiTenancy'] = this.multiTenancy.toJson();
    }
    if (this.currentTenant != null) {
      data['currentTenant'] = this.currentTenant.toJson();
    }
    if (this.timing != null) {
      data['timing'] = this.timing.toJson();
    }
    if (this.clock != null) {
      data['clock'] = this.clock.toJson();
    }
    if (this.objectExtensions != null) {
      data['objectExtensions'] = this.objectExtensions.toJson();
    }
    return data;
  }
}

class Localization {
  Map<String, Object> values;
  List<Languages> languages;
  CurrentCulture currentCulture;
  String defaultResourceName;

  Localization(
      {this.values,
      this.languages,
      this.currentCulture,
      this.defaultResourceName});

  Localization.fromJson(Map<String, dynamic> json) {
    values = json['values'];
    if (json['languages'] != null) {
      languages = new List<Languages>();
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
    currentCulture = json['currentCulture'] != null
        ? new CurrentCulture.fromJson(json['currentCulture'])
        : null;
    defaultResourceName = json['defaultResourceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['values'] = this.values;
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    if (this.currentCulture != null) {
      data['currentCulture'] = this.currentCulture.toJson();
    }
    data['defaultResourceName'] = this.defaultResourceName;
    return data;
  }
}

class Languages {
  String cultureName;
  String uiCultureName;
  String displayName;
  String flagIcon;

  Languages(
      {this.cultureName, this.uiCultureName, this.displayName, this.flagIcon});

  Languages.fromJson(Map<String, dynamic> json) {
    cultureName = json['cultureName'];
    uiCultureName = json['uiCultureName'];
    displayName = json['displayName'];
    flagIcon = json['flagIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cultureName'] = this.cultureName;
    data['uiCultureName'] = this.uiCultureName;
    data['displayName'] = this.displayName;
    data['flagIcon'] = this.flagIcon;
    return data;
  }
}

class CurrentCulture {
  String displayName;
  String englishName;
  String threeLetterIsoLanguageName;
  String twoLetterIsoLanguageName;
  bool isRightToLeft;
  String cultureName;
  String name;
  String nativeName;
  DateTimeFormat dateTimeFormat;

  CurrentCulture(
      {this.displayName,
      this.englishName,
      this.threeLetterIsoLanguageName,
      this.twoLetterIsoLanguageName,
      this.isRightToLeft,
      this.cultureName,
      this.name,
      this.nativeName,
      this.dateTimeFormat});

  CurrentCulture.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    englishName = json['englishName'];
    threeLetterIsoLanguageName = json['threeLetterIsoLanguageName'];
    twoLetterIsoLanguageName = json['twoLetterIsoLanguageName'];
    isRightToLeft = json['isRightToLeft'];
    cultureName = json['cultureName'];
    name = json['name'];
    nativeName = json['nativeName'];
    dateTimeFormat = json['dateTimeFormat'] != null
        ? new DateTimeFormat.fromJson(json['dateTimeFormat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['englishName'] = this.englishName;
    data['threeLetterIsoLanguageName'] = this.threeLetterIsoLanguageName;
    data['twoLetterIsoLanguageName'] = this.twoLetterIsoLanguageName;
    data['isRightToLeft'] = this.isRightToLeft;
    data['cultureName'] = this.cultureName;
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    if (this.dateTimeFormat != null) {
      data['dateTimeFormat'] = this.dateTimeFormat.toJson();
    }
    return data;
  }
}

class DateTimeFormat {
  String calendarAlgorithmType;
  String dateTimeFormatLong;
  String shortDatePattern;
  String fullDateTimePattern;
  String dateSeparator;
  String shortTimePattern;
  String longTimePattern;

  DateTimeFormat(
      {this.calendarAlgorithmType,
      this.dateTimeFormatLong,
      this.shortDatePattern,
      this.fullDateTimePattern,
      this.dateSeparator,
      this.shortTimePattern,
      this.longTimePattern});

  DateTimeFormat.fromJson(Map<String, dynamic> json) {
    calendarAlgorithmType = json['calendarAlgorithmType'];
    dateTimeFormatLong = json['dateTimeFormatLong'];
    shortDatePattern = json['shortDatePattern'];
    fullDateTimePattern = json['fullDateTimePattern'];
    dateSeparator = json['dateSeparator'];
    shortTimePattern = json['shortTimePattern'];
    longTimePattern = json['longTimePattern'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calendarAlgorithmType'] = this.calendarAlgorithmType;
    data['dateTimeFormatLong'] = this.dateTimeFormatLong;
    data['shortDatePattern'] = this.shortDatePattern;
    data['fullDateTimePattern'] = this.fullDateTimePattern;
    data['dateSeparator'] = this.dateSeparator;
    data['shortTimePattern'] = this.shortTimePattern;
    data['longTimePattern'] = this.longTimePattern;
    return data;
  }
}

class Auth {
  Map<String, Object> policies;
  Map<String, Object> grantedPolicies;

  Auth({this.policies, this.grantedPolicies});

  Auth.fromJson(Map<String, dynamic> json) {
    policies = json['policies'];
    grantedPolicies = json['grantedPolicies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['policies'] = this.policies;
    data['grantedPolicies'] = this.grantedPolicies;
    return data;
  }
}

class Setting {
  Map<String, Object> values;

  Setting({this.values});

  Setting.fromJson(Map<String, dynamic> json) {
    values = json['values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['values'] = this.values;
    return data;
  }
}

class CurrentUser {
  bool isAuthenticated;
  String id;
  String tenantId;
  String userName;
  String email;

  CurrentUser(
      {this.isAuthenticated,
      this.id,
      this.tenantId,
      this.userName,
      this.email});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    isAuthenticated = json['isAuthenticated'];
    id = json['id'];
    tenantId = json['tenantId'];
    userName = json['userName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAuthenticated'] = this.isAuthenticated;
    data['id'] = this.id;
    data['tenantId'] = this.tenantId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}

class MultiTenancy {
  bool isEnabled;

  MultiTenancy({this.isEnabled});

  MultiTenancy.fromJson(Map<String, dynamic> json) {
    isEnabled = json['isEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEnabled'] = this.isEnabled;
    return data;
  }
}

class CurrentTenant {
  String id;
  String name;
  bool isAvailable;

  CurrentTenant({this.id, this.name, this.isAvailable});

  CurrentTenant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}

class Timing {
  TimeZone timeZone;

  Timing({this.timeZone});

  Timing.fromJson(Map<String, dynamic> json) {
    timeZone = json['timeZone'] != null
        ? new TimeZone.fromJson(json['timeZone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeZone != null) {
      data['timeZone'] = this.timeZone.toJson();
    }
    return data;
  }
}

class TimeZone {
  Iana iana;
  Windows windows;

  TimeZone({this.iana, this.windows});

  TimeZone.fromJson(Map<String, dynamic> json) {
    iana = json['iana'] != null ? new Iana.fromJson(json['iana']) : null;
    windows =
        json['windows'] != null ? new Windows.fromJson(json['windows']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iana != null) {
      data['iana'] = this.iana.toJson();
    }
    if (this.windows != null) {
      data['windows'] = this.windows.toJson();
    }
    return data;
  }
}

class Iana {
  String timeZoneName;

  Iana({this.timeZoneName});

  Iana.fromJson(Map<String, dynamic> json) {
    timeZoneName = json['timeZoneName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeZoneName'] = this.timeZoneName;
    return data;
  }
}

class Windows {
  String timeZoneId;

  Windows({this.timeZoneId});

  Windows.fromJson(Map<String, dynamic> json) {
    timeZoneId = json['timeZoneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeZoneId'] = this.timeZoneId;
    return data;
  }
}

class Clock {
  String kind;

  Clock({this.kind});

  Clock.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    return data;
  }
}

class ObjectExtensions {
  Map<String, Object> modules;
  Map<String, Object> enums;

  ObjectExtensions({this.modules, this.enums});

  ObjectExtensions.fromJson(Map<String, dynamic> json) {
    modules = json['modules'];
    enums = json['enums'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modules'] = this.modules;
    data['enums'] = this.enums;
    return data;
  }
}
