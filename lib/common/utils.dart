import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_color.dart';
import '../widgets/error_bottom_sheet.dart';
import 'constants.dart';

/// Returns a horizontal gap of the specified [width].
SizedBox hGap(double width) => SizedBox(width: width);

/// Returns a vertical gap of the specified [height].
SizedBox vGap(double height) => SizedBox(height: height);

/// Returns a centered circular progress indicator.
Widget progressIndicator() => const Center(child: CircularProgressIndicator());

/// Returns a centered text widget displaying the given [description].
Widget messageWidget(String description) => Center(child: Text(description));

/// Displays an error bottom sheet to show an exception message.
Future<void> showErrorBottomSheet({
  required BuildContext context,
  bool isGlobal = false,
  required Object exception,
}) async {
  showBottomSheet(
    context: context,
    widget: ErrorBottomSheet(exception: exception),
  );
}

/// Displays a bottom sheet with the given [widget] content.
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

/// Formats a [DateTime] object into a `yyyy-MM-dd` string format.
String formatDateTime(DateTime time) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(time);
}
