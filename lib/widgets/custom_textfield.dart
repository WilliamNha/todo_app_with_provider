import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_with_provider/constants/colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    this.horizontalPadding = 20,
    this.fontSize,
    this.textInputType = TextInputType.text,
    this.isAddressField = false,
    this.maxLine,
    this.suffectIcon,
    this.isHasErrorValidation = false,
    this.onTap,
    required this.hintText,
    Key? key,
    this.controller,
    this.isPhoneField = false,
    this.isEmailField = false,
    this.prefixIcon,
    this.readOnly = false,
    this.margin = EdgeInsets.zero,
    this.onChanged,
    this.borderRadius = 16,
    this.maxLength,
  }) : super(key: key);
  final TextInputType textInputType;
  final double horizontalPadding;
  final double? fontSize;
  final GestureTapCallback? onTap;
  final bool isAddressField;
  final int? maxLine;
  final TextEditingController? controller;
  final EdgeInsetsGeometry margin;
  final bool isPhoneField;
  final String hintText;
  final bool isEmailField;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool isHasErrorValidation;
  final Function(String)? onChanged;
  final Widget? suffectIcon;
  final double borderRadius;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      width: double.infinity,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        maxLength: maxLength,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        maxLines: maxLine,
        onTap: onTap,
        readOnly: readOnly,
        cursorColor: AppColor.primaryColor,
        controller: controller,
        inputFormatters: isPhoneField
            ? [
                LengthLimitingTextInputFormatter(12),
              ]
            : null,
        keyboardType: isEmailField
            ? TextInputType.emailAddress
            : isPhoneField
                ? TextInputType.phone
                : textInputType,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(color: Colors.black, fontSize: fontSize),
        decoration: InputDecoration(
          counterText: "",
          suffixIcon: suffectIcon,
          prefixIcon: isPhoneField
              ? const Icon(Icons.local_phone,
                  size: 24, color: AppColor.primaryColor)
              : isEmailField
                  ? const Icon(Icons.email,
                      size: 24, color: AppColor.primaryColor)
                  : prefixIcon,
          hintText: hintText,
          hintStyle:
              TextStyle(color: const Color(0xff999999), fontSize: fontSize),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(
              left: horizontalPadding,
              top: isAddressField ? 60 : 16,
              bottom: isAddressField ? 0 : 16,
              right: horizontalPadding),
          focusedBorder: readOnly
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xffD7D9DE),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color:
                    isHasErrorValidation ? Colors.red : const Color(0xffD7D9DE),
                width: 1),
          ),
        ),
      ),
    );
  }
}
