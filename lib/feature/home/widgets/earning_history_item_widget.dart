import 'package:tastyso_delivery_driver/common/widgets/custom_card.dart';
import 'package:tastyso_delivery_driver/feature/profile/domain/models/earning_history_model.dart';
import 'package:tastyso_delivery_driver/helper/price_converter_helper.dart';
import 'package:tastyso_delivery_driver/util/color_resources.dart';
import 'package:tastyso_delivery_driver/util/dimensions.dart';
import 'package:tastyso_delivery_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningHistoryItemWidget extends StatelessWidget {
  final EarningHistoryModel earningHistory;

  const EarningHistoryItemWidget({
    super.key,
    required this.earningHistory,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fastfood,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Expanded(
                      child: Text(
                        earningHistory.itemName ?? 'order_items'.tr,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                if (earningHistory.paymentTime != null)
                  Text(
                    earningHistory.paymentTime!,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeExtraSmall),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                    child: Text(
                      earningHistory.orderId != null
                          ? '# ${earningHistory.orderId}'
                          : '# ${earningHistory.id}',
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                PriceConverter.convertPrice(earningHistory.amount ?? 0),
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: ColorResources.green,
                ),
              ),
              if (earningHistory.status != null)
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeExtraSmall),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.green.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                    child: Text(
                      earningHistory.status!,
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: ColorResources.green,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
