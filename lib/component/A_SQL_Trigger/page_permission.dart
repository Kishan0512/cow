import 'dart:convert';

class api_page_permission {
  String page;
  String userId;
  int active;

  api_page_permission({
    required this.page,
    required this.userId,
    required this.active,
  });

  api_page_permission.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        userId = json['userId'] ?? "",
        active = json['active'] ?? 0;

  static Map<String, dynamic> toJson(api_page_permission fav) => {
        'page': fav.page,
        'userId': fav.userId,
        'active': fav.active,
      };

  static String encode(List<api_page_permission> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => api_page_permission.toJson(music))
            .toList(),
      );

  static List<api_page_permission> decode(String musics) => (json.decode(musics)
          as List<dynamic>)
      .map<api_page_permission>((item) => api_page_permission.fromJson(item))
      .toList();

  Map<String, dynamic> toJson1() {
    return {"page": page, "userId": userId, "active": active};
  }

  static GetPagePermission() async {
  }
}
