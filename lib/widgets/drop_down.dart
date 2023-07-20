import 'package:cariera/models/taxonomy_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {Key? key,
      this.list,
      this.model,
      this.value,
      this.hint,
      this.icon,
      this.type})
      : super(key: key);
  List<TaxonomyModel>? list;
  dynamic model;
  int? value;
  String? hint, type;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          color: onPrimary, //background color of dropdown button
          border: Border.all(
              color: onPrimary, width: 3), //border of dropdown button
          borderRadius: BorderRadius.circular(
              defualtRadius), //border raiuds of dropdown button
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  color: Colors.black54,
                )),
            Expanded(
                flex: 5,
                child: DropdownButton(
                  hint: Text(hint ?? '').translate(),
                  value: value,
                  items: list!.map((items) {
                    return DropdownMenuItem(
                      value: items.id,
                      child: Text(items.name ?? '').translate(),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    model.selectDropDownValue(value, type);
                  },

                  icon: const Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_drop_down)),
                  iconEnabledColor: Colors.black54, //Icon color
                  style: const TextStyle(
                      //te
                      color: Colors.black54, //Font color
                      fontSize: fs18 //font size on dropdown button
                      ),

                  dropdownColor: onPrimary, //dropdown background color
                  underline: Container(), //remove underline
                  isExpanded: true, //make true to make width 100%
                )),
          ],
        ));
  }
}
