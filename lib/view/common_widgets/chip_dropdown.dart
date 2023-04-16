import 'package:flutter/material.dart';
import 'package:lettutor/const/custom_color.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';
import '../../const/const_value.dart';
import 'dialogs/base_dialog/bottom_sheet_dialog.dart';


class ChipDropdown extends StatefulWidget {
  const ChipDropdown({super.key, required this.options, required this.size});
  final List<String> options;
  final Size size; //Screen width

  @override
  State<ChipDropdown> createState() => _ChipDropdownState();
}

class _ChipDropdownState extends State<ChipDropdown> {
  List<String> selectedList = [];

  @override
  void initState() {
    selectedList.add('+  Add');
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
                maxWidth: widget.size.width-90,
                child: Wrap(
                  children: selectedList
                      .map((item) => Container(
                              padding: const EdgeInsets.only(right: 6),
                              child: (item!='+  Add')?
                                ChipButton(
                                callback: () {
                                  setState(() {
                                    selectedList.remove(item);
                                  });
                                },
                                title: item,
                                hasIcon: true,
                                chipType: ButtonType.outlinedButton,
                                icon: Icons.clear,
                              ):ChipButton(callback: () {
                                  onPressedAdd(context, widget.size);
                              }, title: '+  Add', hasIcon: false, chipType: ButtonType.filledButton),
                            ))
                        .toList()
                        .cast<Widget>())),
          ],
        ),
      ],
    );
  }

  void onPressedAdd(BuildContext context, Size size) {Widget child =
      LimitedBox(
        maxHeight: size.height * 0.8,
        maxWidth: size.width,
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (BuildContext context, int index) {
            if (selectedList.contains(widget.options[index])) {
              return Container();
            } else {
              return Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(title: Text(widget.options[index]),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        List<String> newList = [widget.options[index]];
                        newList.addAll(selectedList);
                        selectedList = newList;
                      });
                    },),
                  const Divider(height: 2, )
                ],
              ),
            );
            }
          },
        ),
      );
    showBottomDialog(context, 'Select a speciality', child);
  }
}
