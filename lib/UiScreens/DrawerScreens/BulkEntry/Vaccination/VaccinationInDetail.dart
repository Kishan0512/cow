import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/BulkEntry/Vaccination/vaccination_Add.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../../../component/Gobal_Widgets/Con_Color.dart';
import '../BulkEntry.dart';
import 'Vaccination.dart';

class VaccinationInDetail extends StatefulWidget {
  List<String> animal_data = [];
  VaccinationInDetail(this.animal_data);

  @override
  State<VaccinationInDetail> createState() => _VaccinationInDetailState();
}

class _VaccinationInDetailState extends State<VaccinationInDetail> {
  List<String> _selecteCategorys = [];
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

  @override
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
            title: "Vaccination",
            Actions: [],
            onBackTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Vaccination();
                },
              ));
            },
          ),
          body: Con_Wid.backgroundContainer(
            child: Con_Wid.fullContainer(
                child: Column(
              children: [
                Con_Wid.showTypesDetailContainer(
                    "Total Records :- ${widget.animal_data.length}", context),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: CheckboxListTile(
                              value: _selecteCategorys
                                  .contains(widget.animal_data[index]),
                              onChanged: (value) {
                                _onCategorySelected(
                                    value!, widget.animal_data[index]);
                              },
                              title: Text('${widget.animal_data[index]}'),
                              activeColor: con_clr.ConClr2
                                  ? Conclrfontmain
                                  : ConClrDialog,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: widget.animal_data.length)),
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
                            return Vaccination_Add(_selecteCategorys);
                          },
                        ));
                      }
                    })
              ],
            )),
          )),
    );
  }
}
