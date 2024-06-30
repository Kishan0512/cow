import 'package:hive/hive.dart';

part 'Master_userFeatureAccessDetail.g.dart';

@HiveType(typeId: 28)
class Master_userFeatureAccessDetail extends HiveObject {
  @HiveField(0)
  int user;
  @HiveField(1)
  int feature;
  @HiveField(2)
  bool canCreate;
  @HiveField(3)
  bool canView;
  @HiveField(4)
  bool canEdit;
  @HiveField(5)
  bool canDelete;
  @HiveField(6)
  int combinedPermissionValue;
  @HiveField(7)
  int id;

  Master_userFeatureAccessDetail(
      {required this.user,
      required this.feature,
      required this.canCreate,
      required this.canView,
      required this.canEdit,
      required this.canDelete,
      required this.combinedPermissionValue,
      required this.id});

  Master_userFeatureAccessDetail.fromJson(Map<String, dynamic> json)
      : user = json['user'] ?? 0,
        feature = json['feature'] ?? 0,
        canCreate = json['CanCreate'] ?? false,
        canView = json['CanView'] ?? false,
        canEdit = json['CanEdit'] ?? false,
        canDelete = json['CanDelete'] ?? false,
        combinedPermissionValue = json['CombinedPermissionValue'] ?? 0,
        id = json['id'] ?? 0;

  Map<String, dynamic> toJson(Master_userFeatureAccessDetail h) {
    return {
      'user': h.user,
      'feature': h.feature,
      'CanCreate': h.canCreate,
      'CanView': h.canView,
      'CanEdit': h.canEdit,
      'CanDelete': h.canDelete,
      'CombinedPermissionValue': h.combinedPermissionValue,
      'id': h.id
    };
  }
}
