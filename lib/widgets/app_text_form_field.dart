import 'package:shoe_box/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? leading;
  final Widget? trailing;
  final TextAlign? textAlign;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final int? minLines;
  final int? maxLines;
  final double height;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextFormField({
    Key? key,
    this.controller,
    this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.leading,
    this.trailing,
    this.textAlign,
    this.borderRadius = 8,
    this.contentPadding = const EdgeInsets.only(bottom: 5.0),
    this.minLines,
    this.maxLines,
    this.height = 48,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFA9A9A9)),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: Constants.defualtBoxShadow,
      ),
      child: Row(
        children: [
          if (leading != null) leading!,
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType,
              minLines: minLines,
              maxLines: maxLines ?? 1,
              cursorWidth: 1,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
