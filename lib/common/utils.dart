import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_color.dart';
import '../widgets/error_bottom_sheet.dart';
import 'constants.dart';

SizedBox hGap(double width) => SizedBox(width: width);

SizedBox vGap(double height) => SizedBox(height: height);

Widget progressIndicator() => const Center(child: CircularProgressIndicator());

Widget messageWidget(String description) => Center(child: Text(description));

Future<void> showErrorBottomSheet({
  required BuildContext context,
  bool isGlobal = false,
  required Object exception,
}) async {
  showBottomSheet(
      context: context,
      widget: ErrorBottomSheet(
        exception: exception,
      ));
}

Future<void> showBottomSheet({
  required BuildContext context,
  required Widget widget,
  bool isScrollControlled = false,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColor.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radiusMedium),
        topRight: Radius.circular(radiusMedium),
      ),
    ),
    isScrollControlled: isScrollControlled,
    enableDrag: false,
    showDragHandle: false,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

String formatDateTime(DateTime time) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(time);
}
