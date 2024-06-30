import 'package:flutter/material.dart';

import '../../../component/DataBaseHelper/Con_List.dart';
import '../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../component/Gobal_Widgets/Constants.dart';

class Feed_request extends StatefulWidget {
  const Feed_request({Key? key}) : super(key: key);

  @override
  State<Feed_request> createState() => _Feed_requestState();
}

class _Feed_requestState extends State<Feed_request> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_medicineLedger.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineLedger);
    }
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
