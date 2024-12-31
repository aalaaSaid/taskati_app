
import 'package:flutter/material.dart';
import 'package:taskati/core/utils/text_styles.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    required this.onPressed,
  });
  final double? width;
  final double? height;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: onPressed,
            child: Text(text,
                style:
                getBodyTextStyle( context, color: AppColors.whiteColor))));
  }
}
