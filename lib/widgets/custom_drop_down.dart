import 'package:shoe_box/constants/constants.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?>? onChanged;
  final List<String> items;

  const CustomDropDown({
    Key? key,
    this.value,
    this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      value: value,
      onChanged: onChanged,
      underline: const SizedBox(),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        elevation: 0,
        scrollbarTheme: const ScrollbarThemeData(thumbVisibility: MaterialStatePropertyAll(true)),
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE2E2E2),
          ),
        ),
      ),
      buttonStyleData: const ButtonStyleData(elevation: 10),
      customButton: Container(
        height: 48,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFA9A9A9)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: Constants.defualtBoxShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                value ?? 'Select category',
                fontWeight: FontWeight.w400,
                color: value != null ? null : const Color(0xFF94A3B8),
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 5.0),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 18,
            )
          ],
        ),
      ),
      items: List.generate(
        items.length,
        (index) {
          return DropdownMenuItem(
            value: items[index],
            child: Text(items[index]),
          );
        },
      ),
    );
  }
}
