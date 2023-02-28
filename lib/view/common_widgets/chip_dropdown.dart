import 'package:flutter/material.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';

import '../../const/const_value.dart';

class ChipDropdown extends StatefulWidget {
  const ChipDropdown({super.key, required this.options, required this.size});

  final List<String> options;
  final double size; //Screen width

  @override
  State<ChipDropdown> createState() => _ChipDropdownState();
}

class _ChipDropdownState extends State<ChipDropdown> {
  List<String> selectedList = [];

  @override
  void initState() {
    for (var element in widget.options) {
      if (element != widget.options.last) {
        selectedList.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LimitedBox(
                maxHeight: widget.size,
                maxWidth: widget.size,
                child: Wrap(
                  children: selectedList
                      .map((item) => Container(
                    padding: const EdgeInsets.only(right: 6),
                        child: ChipButton(
                              callback: () {
                                setState(() {
                                  selectedList.remove(item);
                                });
                              }, title: item, hasIcon: true, chipType: ButtonType.outlinedButton, icon: Icons.remove_circle,
                            ),
                      ))
                      .toList()
                      .cast<Widget>(),
                )),
          ],
        ),
      ],
    );
  }

  String dropDown() {
    String returnValue = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    DropdownButton<String>(
                        items: <String>['A', 'B', 'C', 'D', 'E', 'F', 'G']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          returnValue = value ?? "";
                        }),
                  ],
                ),
              ],
            ),
          );
        });
    return returnValue;
  }
}
