import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

class PaginationList extends StatefulWidget {
  const PaginationList(
      {super.key,
      required this.onClickPage,
      required this.total,
      required this.perPage});
  final Function onClickPage;
  final int total;
  final int perPage;

  @override
  State<PaginationList> createState() => _PaginationListState();
}

class _PaginationListState extends State<PaginationList> {
  int currentPage = 1;
  int totalPage = 1;
  int perPage = 0;

  void calculatePages() {
    totalPage = (widget.total / widget.perPage).ceil();
    if (totalPage > 2) {
      perPage = 2;
    } else if (totalPage == 2) {
      currentPage = 1;
      perPage = 1;
    } else if (totalPage <= 1) {
      currentPage = 1;
      perPage = 0;
    }
  }

  @override
  void didUpdateWidget(covariant PaginationList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.total != widget.total) {
      currentPage = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculatePages();

    return (widget.total > 0)
        ? Pagination(
            paginateButtonStyles: PaginateButtonStyles(
                backgroundColor: Colors.white,
                activeBackgroundColor: Colors.blue,
                textStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
                activeTextStyle:
                    bodyLarge(context)?.copyWith(color: Colors.white)),
            prevButtonStyles: PaginateSkipButton(
                icon: const Icon(
                  Icons.navigate_before,
                  color: Colors.blue,
                ),
                buttonBackgroundColor: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            nextButtonStyles: PaginateSkipButton(
                icon: const Icon(
                  Icons.navigate_next,
                  color: Colors.blue,
                ),
                buttonBackgroundColor: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            onPageChange: (number) {
              widget.onClickPage(number);
              setState(() {
                currentPage = number;
              });
            },
            useGroup: false,
            totalPage: totalPage,
            show: perPage,
            currentPage: currentPage,
          )
        : const SizedBox();
  }
}
