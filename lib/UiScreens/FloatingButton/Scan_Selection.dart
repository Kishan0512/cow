import 'package:flutter/material.dart';

import '../../component/DataBaseHelper/Con_List.dart';
import '../../component/DataBaseHelper/Sync_Json.dart';
import '../../component/Gobal_Widgets/Constants.dart';

class Scan_Selection extends StatefulWidget {
  const Scan_Selection({Key? key}) : super(key: key);

  @override
  State<Scan_Selection> createState() => _Scan_SelectionState();
}

class _Scan_SelectionState extends State<Scan_Selection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_feature.isEmpty ||
        Con_List.M_userFeatureAccessDetail.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_RoleAuthAndLogs_feature);
      Sync_Json.Get_Master_Data(
          Constants.Tbl_RoleAuthAndLogs_featureuseraccesstxn);
    }
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
