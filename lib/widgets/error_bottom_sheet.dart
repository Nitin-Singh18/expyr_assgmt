import 'package:flutter/material.dart';

import '../common/extensions/context_extension.dart';
import '../common/utils.dart';
import '../theme/app_color.dart';
import 'ea_elevated_button.dart';

/// A bottom sheet widget for displaying error messages.
class ErrorBottomSheet extends StatelessWidget {
  final Object exception;

  const ErrorBottomSheet({super.key, required this.exception});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getIcon(),
          vGap(20),
          Text(
            exception.toString(),
            style: context.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          vGap(20),
          EaElevatedButton(
              title: "Okay", onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }

  /// Returns an error icon with a circular red background.
  Widget _getIcon() => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColor.lightRedColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error_outline,
          size: 30,
        ),
      );
}
