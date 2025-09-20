import 'package:stackfood_multivendor_driver/common/widgets/custom_asset_image_widget.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor_driver/feature/notification/controllers/notification_controller.dart';
import 'package:stackfood_multivendor_driver/feature/notification/widgets/notification_dialog_widget.dart';
import 'package:stackfood_multivendor_driver/helper/date_converter_helper.dart';
import 'package:stackfood_multivendor_driver/helper/route_helper.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/images.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  final bool fromNotification;
  const NotificationScreen({super.key, this.fromNotification = false});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<NotificationController>().getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (widget.fromNotification) {
          Get.offAllNamed(RouteHelper.getInitialRoute());
        } else {
          Future.delayed(Duration.zero, () {
            Get.back();
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: 'notification'.tr,
          onBackPressed: () {
            if (widget.fromNotification) {
              Get.offAllNamed(RouteHelper.getInitialRoute());
            } else {
              Get.back();
            }
          },
        ),
        body: GetBuilder<NotificationController>(builder: (notificationController) {
          if (notificationController.notificationList != null) {
            notificationController.saveSeenNotificationCount(notificationController.notificationList!.length);
          }

          List<DateTime> dateTimeList = [];

          return notificationController.notificationList != null ? notificationController.notificationList!.isNotEmpty ? RefreshIndicator(
            onRefresh: () async {
              await notificationController.getNotificationList();
            },
            child: ListView.builder(
              itemCount: notificationController.notificationList!.length,
              padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
              shrinkWrap: true,
              itemBuilder: (context, index) {

                DateTime originalDateTime = DateConverter.dateTimeStringToDate(notificationController.notificationList![index].createdAt!);
                DateTime convertedDate = DateTime(originalDateTime.year, originalDateTime.month, originalDateTime.day);
                bool addTitle = false;

                if (!dateTimeList.contains(convertedDate)) {
                  addTitle = true;
                  dateTimeList.add(convertedDate);
                }

                bool isSeen = notificationController.getSeenNotificationIdList()!.contains(notificationController.notificationList![index].id);

                return Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    addTitle ? Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                      child: Text(
                        DateConverter.convertTodayYesterdayDate(notificationController.notificationList![index].createdAt!),
                        style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7)),
                      ),
                    ) : const SizedBox(),

                    InkWell(
                      onTap: () {
                        notificationController.addSeenNotificationId(notificationController.notificationList![index].id!);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NotificationDialogWidget(notificationModel: notificationController.notificationList![index]);
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
                        ),
                        child: Row(children: [

                          notificationController.notificationList![index].data?.type == 'push_notification' ? ClipOval(
                            child: CustomImageWidget(
                              image: '${notificationController.notificationList![index].imageFullUrl}',
                              height: 60, width: 60,
                              fit: BoxFit.cover,
                            ),
                          ) : CustomAssetImageWidget(
                            image: Images.orderIcon,
                            height: 60, width: 60,
                          ),
                          SizedBox(width: Dimensions.paddingSizeDefault),

                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              Row(children: [

                                Expanded(
                                  child: Text(
                                    notificationController.notificationList![index].title ?? '',
                                    style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: isSeen ? FontWeight.w400 : FontWeight.w700),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: Dimensions.paddingSizeSmall),

                                Text(
                                  DateConverter.convertTimeDifferenceInMinutes(notificationController.notificationList![index].createdAt!),
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: isSeen ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).primaryColor),
                                ),

                              ]),
                              SizedBox(height: Dimensions.paddingSizeSmall),

                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Text(
                                  notificationController.notificationList![index].description ?? '',
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: isSeen ? Theme.of(context).disabledColor : Theme.of(context).textTheme.bodyLarge?.color),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ),

                            ]),
                          ),

                        ]),
                      ),
                    ),

                  ]),
                );
              },
            ),
          ) : Center(child: Text('no_notification_found'.tr)) : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}