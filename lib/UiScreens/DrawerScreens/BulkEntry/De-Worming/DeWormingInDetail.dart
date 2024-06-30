import 'package:flutter/material.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Color.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../../component/DataBaseHelper/Con_List.dart';
import '../../../../component/DataBaseHelper/Sync_Json.dart';
import '../../../../component/Gobal_Widgets/Constants.dart';
import '../BulkEntry.dart';
import 'De-Worming.dart';
import 'Deworming.dart';

class DeWormingInDetail extends StatefulWidget {
  List<String> Animal_ids = [];
  DeWormingInDetail(this.Animal_ids);

  @override
  State<DeWormingInDetail> createState() => _DeWormingInDetailState();
}

class _DeWormingInDetailState extends State<DeWormingInDetail> {
  List _selecteCategorys = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (Con_List.M_inseminator.isEmpty ||
        Con_List.M_status.isEmpty ||
        Con_List.M_medicineLedger.isEmpty ||
        Con_List.M_dewormingType.isEmpty ||
        Con_List.id_Animal_Details.isEmpty) {
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_staff);
      Sync_Json.Get_Master_Data(Constants.Tbl_Common_status);
      Sync_Json.Get_Master_Data(Constants.Tbl_Account_medicineLedger);
      Sync_Json.Get_Master_Data(Constants.Tbl_Master_dewormingType);
      Sync_Json.Get_Master_Data(Constants.Tbl_Animal_details);
    }
  }

  _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return BulkEntryScreen();
              },
            ));
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: Con_Wid.appBar(
          title: "De-Worming",
          Actions: [],
          onBackTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DeWorming();
              },
            ));
          },
        ),
        body: Con_Wid.backgroundContainer(
          child: Con_Wid.fullContainer(
              child: Column(
            children: [
              Con_Wid.showTypesDetailContainer(
                  "Total Records :- ${widget.Animal_ids.length}", context),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: CheckboxListTile(
                            value: _selecteCategorys
                                .contains(widget.Animal_ids[index]),
                            onChanged: (value) {
                              _onCategorySelected(
                                  value!, widget.Animal_ids[index]);
                            },
                            title: Text('${widget.Animal_ids[index]}'),
                            activeColor: Conclrfontmain,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: widget.Animal_ids.length)),
              Con_Wid.MainButton(
                  width: 170,
                  height: 51,
                  fontSize: 16,
                  pStrBtnName: 'Next',
                  OnTap: () {
                    if (_selecteCategorys.isEmpty) {
                      Con_Wid.Con_Show_Toast(context, "Select Tag id");
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Deworming(_selecteCategorys);
                        },
                      ));
                    }
                  })
            ],
          )),
        ),
      ),
    );
  }
}
