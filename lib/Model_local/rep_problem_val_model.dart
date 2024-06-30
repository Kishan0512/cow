

class rep_problem_val_model {
  String? TagId;
  String? Date;
  String? Comments;
  int? details;
  int? reproductiveProblem;
  int? reproduction;
  int? id;
  String? createdAt;
  String? updatedAt;
  int? lastUpdatedByUser;
  int? createdByUser;

  rep_problem_val_model(
      { this.TagId,
        this.Date,
        this.Comments,
        this.details,
        this.reproductiveProblem,
        this.reproduction,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.lastUpdatedByUser,
        this.createdByUser});

  factory rep_problem_val_model.fromJson(Map<String, dynamic> json) {
    // factory Logins.fromJson(Map<String, dynamic> json) {
    return rep_problem_val_model(
        TagId: json['TagId'],
        Date: json['Date'],
        Comments: json['Comments'],
        details: json['details'],
        reproductiveProblem: json['reproductiveProblem'],
        reproduction: json['reproduction'],
        id: json['id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        lastUpdatedByUser: json['lastUpdatedByUser'],
        createdByUser: json['createdByUser']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['TagId'] = TagId.toString();
    map['Date'] = Date.toString();
    map['Comments'] = Comments.toString();
    map['details'] = details.toString();
    map['reproductiveProblem'] = reproductiveProblem.toString();
    map['reproduction'] = reproduction.toString();
    map['id'] = id.toString();
    map['createdAt'] = createdAt.toString();
    map['updatedAt'] = updatedAt.toString();
    map['lastUpdatedByUser'] = lastUpdatedByUser.toString();
    map['createdByUser'] = createdByUser.toString();

    return map;
  }

  Map toMap1() {
    var map = new Map<String, dynamic>();
    map['TagId'] = TagId.toString();
    map['Date'] = Date.toString();
    map['Comments'] = Comments.toString();
    map['details'] = details;
    map['reproductiveProblem'] = reproductiveProblem;
    map['reproduction'] = reproduction;
    map['id'] = id;
    map['createdAt'] = createdAt.toString();
    map['updatedAt'] = updatedAt.toString();
    map['lastUpdatedByUser'] = lastUpdatedByUser;
    map['createdByUser'] = createdByUser;

    return map;
  }
}
