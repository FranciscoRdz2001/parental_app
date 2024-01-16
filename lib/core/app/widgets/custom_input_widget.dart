import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class CustomInputWidget extends StatefulWidget {
  final String? label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  const CustomInputWidget({
    super.key,
    this.label,
    this.onChanged,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
        borderRadius: BorderRadius.circular(16),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: _obscureText,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        isCollapsed: true,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, size: 16, color: AppColors.gray),
        border: _border(AppColors.placeHolderColor),
        errorBorder: _border(AppColors.placeHolderColor),
        enabledBorder: _border(AppColors.placeHolderColor),
        focusedBorder: _border(AppColors.placeHolderColor),
        disabledBorder: _border(AppColors.placeHolderColor),
        focusedErrorBorder: _border(AppColors.placeHolderColor),
        labelText: widget.label,
        floatingLabelStyle: AppStyles.w400(14, AppColors.gray),
        hintText: widget.label,
        hintStyle: AppStyles.w400(14, AppColors.gray),
        errorStyle: AppStyles.w400(12, Colors.red),
        helperStyle: AppStyles.w400(12, AppColors.gray),
        suffixStyle: AppStyles.w400(12, AppColors.gray),
        labelStyle: AppStyles.w400(14, AppColors.gray),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.gray,
                  size: 16,
                ),
              )
            : null,
      ),
    );
  }
}
