class unit_details_update {
  String? startDatetime;
  String? purpose;
  String? startUnit;
  String? startLat;
  String? startLong;
  String? regularVehicleNo;
  String? replaceVehicleNo;

  unit_details_update(
      {this.startDatetime,
      this.purpose,
      this.startUnit,
      this.startLat,
      this.startLong,
      this.regularVehicleNo,
      this.replaceVehicleNo});

  unit_details_update.fromJson(Map<String, dynamic> json) {
    startDatetime = json['StartDatetime'];
    purpose = json['Purpose'];
    startUnit = json['StartUnit'];
    startLat = json['StartLat'];
    startLong = json['StartLong'];
    regularVehicleNo = json['RegularVehicleNo'];
    replaceVehicleNo = json['ReplaceVehicleNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StartDatetime'] = this.startDatetime;
    data['Purpose'] = this.purpose;
    data['StartUnit'] = this.startUnit;
    data['StartLat'] = this.startLat;
    data['StartLong'] = this.startLong;
    data['RegularVehicleNo'] = this.regularVehicleNo;
    data['ReplaceVehicleNo'] = this.replaceVehicleNo;
    return data;
  }
}
