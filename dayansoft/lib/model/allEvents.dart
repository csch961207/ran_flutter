class AllEvents {
  int code;
  int pAGECURRENT;
  List<DATALIST> dATALIST;
  int pAGESIZE;
  int tOTALPAGE;
  int tOTALNUM;

  AllEvents(
      {this.code,
        this.pAGECURRENT,
        this.dATALIST,
        this.pAGESIZE,
        this.tOTALPAGE,
        this.tOTALNUM});

  AllEvents.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pAGECURRENT = json['PAGECURRENT'];
    if (json['DATALIST'] != null) {
      dATALIST = new List<DATALIST>();
      json['DATALIST'].forEach((v) {
        dATALIST.add(new DATALIST.fromJson(v));
      });
    }
    pAGESIZE = json['PAGESIZE'];
    tOTALPAGE = json['TOTALPAGE'];
    tOTALNUM = json['TOTALNUM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['PAGECURRENT'] = this.pAGECURRENT;
    if (this.dATALIST != null) {
      data['DATALIST'] = this.dATALIST.map((v) => v.toJson()).toList();
    }
    data['PAGESIZE'] = this.pAGESIZE;
    data['TOTALPAGE'] = this.tOTALPAGE;
    data['TOTALNUM'] = this.tOTALNUM;
    return data;
  }
}

class DATALIST {
  int amount;
  int amountCount;
  int budgetCount;
  int eventform;
  String eventformDescr;
  int eventlevel;
  String eventlevelDescr;
  int id;
  String name;
  int noTaxAmount;
  int noTaxAmountCount;
  int onmonth;
  int sumAmountCount;

  DATALIST(
      {this.amount,
        this.amountCount,
        this.budgetCount,
        this.eventform,
        this.eventformDescr,
        this.eventlevel,
        this.eventlevelDescr,
        this.id,
        this.name,
        this.noTaxAmount,
        this.noTaxAmountCount,
        this.onmonth,
        this.sumAmountCount});

  DATALIST.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountCount = json['amountCount'];
    budgetCount = json['budgetCount'];
    eventform = json['eventform'];
    eventformDescr = json['eventformDescr'];
    eventlevel = json['eventlevel'];
    eventlevelDescr = json['eventlevelDescr'];
    id = json['id'];
    name = json['name'];
    noTaxAmount = json['noTaxAmount'];
    noTaxAmountCount = json['noTaxAmountCount'];
    onmonth = json['onmonth'];
    sumAmountCount = json['sumAmountCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['amountCount'] = this.amountCount;
    data['budgetCount'] = this.budgetCount;
    data['eventform'] = this.eventform;
    data['eventformDescr'] = this.eventformDescr;
    data['eventlevel'] = this.eventlevel;
    data['eventlevelDescr'] = this.eventlevelDescr;
    data['id'] = this.id;
    data['name'] = this.name;
    data['noTaxAmount'] = this.noTaxAmount;
    data['noTaxAmountCount'] = this.noTaxAmountCount;
    data['onmonth'] = this.onmonth;
    data['sumAmountCount'] = this.sumAmountCount;
    return data;
  }
}