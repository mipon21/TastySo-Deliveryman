import 'package:tastyso_delivery_driver/util/dimensions.dart';
import 'package:tastyso_delivery_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CountCardWidget extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String? value;
  final double height;
  const CountCardWidget(
      {super.key,
      required this.backgroundColor,
      required this.title,
      required this.value,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
      decoration: BoxDecoration(
        color: value != null ? backgroundColor : Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 150,
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: robotoRegular.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        Text(
          ":",
          style: robotoRegular.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        value != null
            ? Text(
                value!,
                style: robotoBold.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyLarge?.color),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Shimmer(
                duration: const Duration(seconds: 2),
                enabled: value == null,
                color: Colors.grey[500]!,
                child: Container(
                    height: 60,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5))),
              ),
      ]),
    );
  }
}
