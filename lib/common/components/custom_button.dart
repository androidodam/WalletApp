import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/status.dart';

class CustomButton extends StatelessWidget {
  final Size? size;
  final Color? textColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final CustomButtonStatus status;
  final VoidCallback? onTap;
  final String? title;
  final String? icon;
  const CustomButton({
    super.key,
    this.size,
    this.textColor,
    this.borderRadius,
    this.backgroundColor,
    required this.status,
    this.onTap,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CustomButtonStatus.ELEVETED:
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: theme.blue.withValues(alpha: 0.1),
                backgroundColor: backgroundColor ?? theme.blue,
                fixedSize: Size(1.sw(context), 49.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.o),
                )),
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon?.isNotEmpty ?? false)
                  SvgPicture.asset(
                    icon ?? '',
                    fit: BoxFit.cover,
                    width: 15.o,
                    height: 15.o,
                  ),
                8.gapx,
                Text(
                  title ?? '',
                  style: theme.testStyle.copyWith(
                    color: textColor ?? theme.white,
                    fontSize: 14.o,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ));
      case CustomButtonStatus.ICON:
        return SizedBox();
    }
  }
}
