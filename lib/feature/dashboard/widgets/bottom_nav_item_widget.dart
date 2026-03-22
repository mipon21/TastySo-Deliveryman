import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastyso_delivery_driver/common/widgets/custom_asset_image_widget.dart';
import 'package:tastyso_delivery_driver/feature/order/controllers/order_controller.dart';
import 'package:tastyso_delivery_driver/util/dimensions.dart';
import 'package:tastyso_delivery_driver/util/styles.dart';

class BottomNavItemWidget extends StatelessWidget {
  final String icon;
  final Function? onTap;
  final bool isSelected;
  final int? width;
  final int? height;
  final int? pageIndex;
  final String? label;
  const BottomNavItemWidget(
      {super.key,
      required this.icon,
      this.onTap,
      this.isSelected = false,
      this.pageIndex,
      this.width,
      this.height,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomAssetImageWidget(
                    image: icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    height: height == null ? 25 : height!.toDouble(),
                    width: width == null ? 25 : width!.toDouble()),
                pageIndex == 1
                    ? Positioned(
                        top: -8,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: GetBuilder<OrderController>(
                              builder: (orderController) {
                            return Text(
                              orderController.latestOrderList?.length
                                      .toString() ??
                                  '0',
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: Colors.white),
                            );
                          }),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            if (label != null && label!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  label!,
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
