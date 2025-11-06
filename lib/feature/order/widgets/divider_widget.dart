import 'package:flutter/material.dart';
import 'package:tastyso_delivery_driver/util/dimensions.dart';

class DividerWidget extends StatelessWidget {
  final double? height;
  const DividerWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimensions.paddingSizeSmall,
      width: double.infinity,
      color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
    );
  }
}
