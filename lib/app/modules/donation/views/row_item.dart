// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

class RowItem extends GetView {
  final String lValue;
  final String rValue;
  final IconData? icon;
  final int lFlex;
  final int rFlex;
  final Function()? onTap;

  const RowItem(this.lValue, this.rValue,
      {super.key, this.lFlex = 1, this.rFlex = 1, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: lFlex, child: CSText(lValue)),
        horizontalSpaceSmall,
        Expanded(flex: rFlex, child: CSText(rValue)),
        if (icon != null) horizontalSpaceSmall,
        if (icon != null) CsIcon(icon),
      ],
    );
  }
}
