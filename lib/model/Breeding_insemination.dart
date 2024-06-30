class Breeding_insemination {
  var id;
  var TagId;
  var HeatDate;
  var InseminationTicketNumber;
  var OrderNumber;
  var ENTRY;
  var details;
  var AIT;
  var sire;
  var service;
  var createdAt;
  var updatedAt;
  var StrawImage;
  var BatchNo;
  var Reproduction;
  var lastUpdatedByUser;
  var createdByUser;
  var herd;
  var lot;
  var SortedSemon;
  var farmer;
  var AICost;
  var TotalAIDose;
  var OTP;
  var Long;
  var Lat;
  var Parity;
  var HeatSeq;

  Breeding_insemination({
    required this.id,
    required this.TagId,
    required this.HeatDate,
    required this.InseminationTicketNumber,
    required this.OrderNumber,
    required this.ENTRY,
    required this.details,
    required this.AIT,
    required this.sire,
    required this.service,
    required this.createdAt,
    required this.updatedAt,
    required this.StrawImage,
    required this.BatchNo,
    required this.Reproduction,
    required this.lastUpdatedByUser,
    required this.createdByUser,
    required this.herd,
    required this.lot,
    required this.farmer,
    required this.SortedSemon,
    required this.AICost,
    required this.TotalAIDose,
    required this.OTP,
    required this.Long,
    required this.Lat,
    required this.Parity,
    required this.HeatSeq,
  });

  Breeding_insemination.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        TagId = json['TagId'] ?? "",
        HeatDate = json['HeatDate'] ?? "",
        InseminationTicketNumber = json['InseminationTicketNumber'] ?? "",
        OrderNumber = json['OrderNumber'] ?? "",
        ENTRY = json['ENTRY'] ?? "",
        details = json['details'] ?? "",
        AIT = json['AIT'] ?? "",
        sire = json['sire'] ?? "",
        service = json['service'] ?? "",
        createdAt = json['createdAt'] ?? "",
        updatedAt = json['updatedAt'] ?? "",
        StrawImage = json['StrawImage'] ?? "",
        BatchNo = json['BatchNo'] ?? "",
        Reproduction = json['Reproduction'] ?? "",
        lastUpdatedByUser = json['lastUpdatedByUser'] ?? "",
        createdByUser = json['createdByUser'] ?? "",
        herd = json['herd'] ?? "",
        lot = json['lot'] ?? "",
        farmer = json['farmer'] ?? "",
        SortedSemon = json['SortedSemon'] ?? false,
        AICost = json['AICost'] ?? "",
        TotalAIDose = json['TotalAIDose'] ?? 0,
        OTP = json['OTP'] ?? 0,
        Long = json['Long'] ?? 0,
        Lat = json['Lat'] ?? 0,
        Parity = json['Parity'] ?? 0,
        HeatSeq = json['HeatSeq'] ?? 0;

  static Map<String, dynamic> toJson(Breeding_insemination h) {
    return {
      'id': h.id,
      'TagId': h.TagId,
      'HeatDate': h.HeatDate,
      'InseminationTicketNumber': h.InseminationTicketNumber,
      'OrderNumber': h.OrderNumber,
      'ENTRY': h.ENTRY,
      'details': h.details,
      'AIT': h.AIT,
      'sire': h.sire,
      'service': h.service,
      'createdAt': h.createdAt,
      'updatedAt': h.updatedAt,
      'StrawImage': h.StrawImage,
      'BatchNo': h.BatchNo,
      'Reproduction': h.Reproduction,
      'lastUpdatedByUser': h.lastUpdatedByUser,
      'createdByUser': h.createdByUser,
      'herd': h.herd,
      'lot': h.lot,
      'farmer': h.farmer,
      'SortedSemon': h.SortedSemon,
      'AICost': h.AICost,
      'TotalAIDose': h.TotalAIDose,
      'OTP': h.OTP,
      'Long': h.Long,
      'Lat': h.Lat,
      'Parity': h.Parity,
      'HeatSeq': h.HeatSeq,
    };
  }
}
