import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/extensions/context_extension.dart';
import '../theme/app_color.dart';
/// Shows a custom elevated button [EaElevatedButton].
class EaElevatedButton extends StatelessWidget {
  /// The button's title.
  final String title;

  /// The function to execute when the button is pressed.
  final VoidCallback? onPressed;

  const EaElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
