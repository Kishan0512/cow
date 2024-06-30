class Timeline {
  int id;
  int count;
  String heading_text;
  String center_text;
  String date_text;
  String status_text;
  String tagno;
  String actual_date;
  String PregDays;
  String LastDays;

  Timeline(
      {required this.id,
      required this.count,
      required this.heading_text,
      required this.center_text,
      required this.date_text,
      required this.status_text,
      required this.tagno,
      required this.actual_date,
      required this.PregDays,
      required this.LastDays});

  Map<String, dynamic> toMap(Timeline h) {
    return {
      'id': h.id,
      'count': h.count,
      'heading_text': h.heading_text,
      'center_text': h.center_text,
      'date_text': h.date_text,
      'status_text': h.status_text,
      'tagno': h.tagno,
      'actual_date': h.actual_date,
      'PregDays': h.PregDays,
      'LastDays': h.LastDays
    };
  }

  Timeline.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        count = map['count'],
        heading_text = map['heading_text'],
        center_text = map['center_text'],
        date_text = map['date_text'],
        status_text = map['status_text'],
        tagno = map['tagno'],
        actual_date = map['actual_date'],
        PregDays = map['PregDays'],
        LastDays = map['LastDays'];

  static List<Timeline> listFromJson(List<dynamic> list) {
    return list.map((e) => Timeline.fromJson(e)).toList();
  }
}
