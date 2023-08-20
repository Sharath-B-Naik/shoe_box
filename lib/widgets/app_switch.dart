import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final Color? borderColor;
  final ValueChanged<bool> onToggle;
  const AppSwitch({
    Key? key,
    this.value = false,
    required this.onToggle,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      value: value,
      activeColor: const Color(0xff01ab97),
      toggleColor: Colors.white,
      toggleSize: 24,
      height: 28,
      width: 48,
      padding: 1,
      onToggle: onToggle,
      switchBorder: Border.all(color: borderColor ?? Colors.transparent),
    );
  }
}
