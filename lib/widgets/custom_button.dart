import 'package:flutter/material.dart';
import 'package:todo_app_with_provider/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final bool isTextBold;
  final String buttonText;
  final GestureTapCallback? onPressed;
  final EdgeInsets? margin;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color textColor;
  final Color? buttonBorderColor;
  final double borderRadius;
  final Widget? icon;
  final Color? disableButtonColor;
  const CustomButton({
    this.disableButtonColor,
    this.isTextBold = false,
    this.icon,
    this.buttonBorderColor,
    this.width,
    this.height,
    required this.buttonText,
    this.borderRadius = 16,
    this.buttonColor = AppColor.primaryColor,
    this.margin,
    this.fontSize,
    this.textColor = Colors.white,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonSytle = OutlinedButton.styleFrom(
      foregroundColor: AppColor.primaryColor,
      backgroundColor: onPressed == null
          ? disableButtonColor ?? Theme.of(context).disabledColor
          : buttonColor ?? AppColor.primaryColor,
      minimumSize:
          Size(width ?? MediaQuery.of(context).size.width, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(
        color: buttonBorderColor ?? AppColor.primaryColor,
      ),
    );
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.purple,
      backgroundColor: onPressed == null
          ? disableButtonColor ?? Theme.of(context).disabledColor
          : buttonColor ?? AppColor.primaryColor,
      minimumSize:
          Size(width ?? MediaQuery.of(context).size.width, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
    return Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: onPressed,
        style: buttonBorderColor != null ? outlineButtonSytle : flatButtonStyle,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon != null
                ? const SizedBox(
                    width: 4,
                  )
                : const SizedBox(),
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: isTextBold
                  ? TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: fontSize ?? 16)
                  : TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: fontSize ?? 16),
            ),
          ],
        ),
      ),
    );
  }
}
