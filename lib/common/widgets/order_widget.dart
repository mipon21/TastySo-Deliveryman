import 'package:stackfood_multivendor_driver/common/widgets/custom_card.dart';
import 'package:stackfood_multivendor_driver/feature/order/domain/models/order_model.dart';
import 'package:stackfood_multivendor_driver/feature/order/screens/order_details_screen.dart';
import 'package:stackfood_multivendor_driver/helper/route_helper.dart';
import 'package:stackfood_multivendor_driver/util/color_resources.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/images.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final bool isRunningOrder;
  final int orderIndex;
  const OrderWidget({super.key, required this.orderModel, required this.isRunningOrder, required this.orderIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteHelper.getOrderDetailsRoute(orderModel.id),
          arguments: OrderDetailsScreen(orderId: orderModel.id, isRunningOrder: isRunningOrder, orderIndex: orderIndex),
        );
      },
      child: CustomCard(
        child: Column(children: [

          Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault),
              ),
            ),
            child: Row(children: [

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('order'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),

                Row(children: [
                  Text('# ${orderModel.id} ', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),

                  Text('(${orderModel.detailsCount} ${'item'.tr})', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor)),
                ]),
              ]),

              const Expanded(child: SizedBox()),

              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 2),
                  decoration: BoxDecoration(
                    color: orderModel.paymentStatus == 'paid' ? ColorResources.green.withValues(alpha: 0.1) : ColorResources.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: Text(
                    orderModel.paymentStatus == 'paid' ? 'paid'.tr : 'unpaid'.tr,
                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: orderModel.paymentStatus == 'paid' ? ColorResources.green : ColorResources.red),
                  ),
                ),
                const SizedBox(height: 2),

                Text(
                  orderModel.paymentMethod == 'cash_on_delivery' ? 'cod'.tr : 'digitally_paid'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                ),

              ]),
            ]),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.asset(orderModel.orderStatus == 'picked_up' ? Images.personIcon : Images.house, width: 20, height: 20),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Text(
                  orderModel.orderStatus == 'picked_up' ? 'customer_location'.tr : orderModel.restaurantName ?? '',
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.location_on, size: 20, color: Theme.of(context).hintColor),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                  Expanded(child: Text(
                    orderModel.orderStatus == 'picked_up' ? orderModel.deliveryAddress!.address.toString() : orderModel.restaurantAddress ?? '',
                    style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  )),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                  InkWell(
                    onTap: () async {
                      String url;
                      if(orderModel.orderStatus == 'picked_up') {
                        url = 'https://www.google.com/maps/dir/?api=1&destination=${orderModel.deliveryAddress!.latitude}'
                            ',${orderModel.deliveryAddress!.longitude}&mode=d';
                      }else  {
                        url = 'https://www.google.com/maps/dir/?api=1&destination=${orderModel.restaurantLat ?? '0'}'
                            ',${orderModel.restaurantLng ?? '0'}&mode=d';
                      }
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url, mode: LaunchMode.externalApplication);
                      } else {
                        showCustomSnackBar('${'could_not_launch'.tr} $url');
                      }
                    },
                    child: Row(children: [
                      Icon(Icons.directions, size: 20, color: Theme.of(context).primaryColor),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      Text(
                        'direction'.tr,
                        style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ]),
                  ),
                ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text('details'.tr, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline, decorationColor: Theme.of(context).primaryColor)),
            ]),
          ),

        ]),
      ),
    );
  }
}