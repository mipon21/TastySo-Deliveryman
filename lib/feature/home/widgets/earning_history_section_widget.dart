import 'package:tastyso_delivery_driver/common/widgets/title_widget.dart';
import 'package:tastyso_delivery_driver/feature/home/widgets/earning_history_item_widget.dart';
import 'package:tastyso_delivery_driver/feature/profile/controllers/profile_controller.dart';
import 'package:tastyso_delivery_driver/util/dimensions.dart';
import 'package:tastyso_delivery_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class EarningHistorySectionWidget extends StatelessWidget {
  const EarningHistorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      // Debug: Check if widget is being built
      debugPrint(
          '----EarningHistorySectionWidget built - Loading: ${profileController.isEarningHistoryLoading}, List: ${profileController.earningHistoryList?.length ?? 'null'}');

      if (profileController.isEarningHistoryLoading &&
          profileController.earningHistoryList == null) {
        return Column(
          children: [
            TitleWidget(title: 'Earning History'),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            ...List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeDefault),
                child: Shimmer(
                  duration: const Duration(seconds: 2),
                  enabled: true,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }

      // Show empty state if list is empty (but loaded)
      if (!profileController.isEarningHistoryLoading &&
          (profileController.earningHistoryList == null ||
              profileController.earningHistoryList!.isEmpty)) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(title: 'Earning History'),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Center(
                child: Text(
                  'No Earning History Found',
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: 'Earning History'.tr),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          ...profileController.earningHistoryList!.map((earning) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: EarningHistoryItemWidget(earningHistory: earning),
            );
          }).toList(),
          if (profileController.earningHistoryTotalSize >
              profileController.earningHistoryList!.length)
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    profileController.getEarningHistory(
                      isUpdate: true,
                      offset: profileController.earningHistoryOffset + 1,
                    );
                  },
                  child: Text(
                    'Load More',
                    style: robotoMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
