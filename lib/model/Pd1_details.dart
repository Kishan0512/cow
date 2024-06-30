class pd1_details {
  String? tagId;
  String? pDDate;
  int? aIT;
  int? eNTRY;
  int? result;
  String? lat;
  String? long;
  String? createdAt;
  String? updatedAt;
  int? ceatedbyuser;
  int? lastUpdatedByUser;
  int? herd;
  int? lot;
  int? farmer;

  pd1_details(
      {this.tagId,
      this.pDDate,
      this.aIT,
      this.eNTRY,
      this.result,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt,
      this.ceatedbyuser,
      this.lastUpdatedByUser,
      this.herd,
      this.lot,
      this.farmer});

  pd1_details.fromJson(Map<String, dynamic> json) {
    tagId = json['TagId'];
    pDDate = json['PDDate'];
    aIT = json['AIT'];
    eNTRY = json['ENTRY'];
    result = json['Result'];
    lat = json['Lat'];
    long = json['Long'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ceatedbyuser = json['ceatedbyuser'];
    lastUpdatedByUser = json['lastUpdatedByUser'];
    herd = json['herd'];
    lot = json['lot'];
    farmer = json['farmer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TagId'] = this.tagId;
    data['PDDate'] = this.pDDate;
    data['AIT'] = this.aIT;
    data['ENTRY'] = this.eNTRY;
    data['Result'] = this.result;
    data['Lat'] = this.lat;
    data['Long'] = this.long;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['ceatedbyuser'] = this.ceatedbyuser;
    data['lastUpdatedByUser'] = this.lastUpdatedByUser;
    data['herd'] = this.herd;
    data['lot'] = this.lot;
    data['farmer'] = this.farmer;
    return data;
  }
}
