import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../../utils/default_style.dart';

class TitleAndChipsSchedule extends StatefulWidget {
  const TitleAndChipsSchedule(
      {super.key,
      required this.options,
      required this.title,
      required this.size});
  final List<String> options;
  final String title;
  final double size; //Screen width

  @override
  State<TitleAndChipsSchedule> createState() => _TitleAndChipsScheduleState();
}

class _TitleAndChipsScheduleState extends State<TitleAndChipsSchedule> {
  int selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(widget.title, style: headLineSmall(context)),
            ),
            LimitedBox(
              maxWidth: widget.size - 40,
              child: ChipsChoice<int>.single(
                  value: selectedChip,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: widget.options,
                    value: (i, v) => i,
                    label: (i, v) => v,
                    // tooltip: (i, v) => v,
                  ),
                  choiceCheckmark: true,
                  choiceStyle: C2ChipStyle.outlined(
                      color: Colors.blue,
                      backgroundColor: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      selectedStyle: C2ChipStyle.filled(
                          color: Colors.blue, foregroundColor: Colors.white)),
                  onChanged: (value) {
                    setState(() {
                      selectedChip = value;
                    });
                  }),
            ),
            BookingSchedule(
              date: widget.options[selectedChip],
            )
          ],
        ),
      ],
    );
  }
}

class BookingSchedule extends StatelessWidget {
  const BookingSchedule({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Text('$date');
  }
}
