import 'package:stackfood_multivendor_driver/feature/language/controllers/localization_controller.dart';
import 'package:stackfood_multivendor_driver/feature/language/widgets/language_card_widget.dart';
import 'package:stackfood_multivendor_driver/feature/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor_driver/helper/route_helper.dart';
import 'package:stackfood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:stackfood_multivendor_driver/util/app_constants.dart';
import 'package:stackfood_multivendor_driver/util/dimensions.dart';
import 'package:stackfood_multivendor_driver/util/images.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_button_widget.dart';
import 'package:stackfood_multivendor_driver/common/widgets/custom_snackbar_widget.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body:
          GetBuilder<LocalizationController>(builder: (localizationController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              Images.languageBackground,
              height: 210,
              width: 210,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Text('choose_your_language'.tr,
                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Text('choose_your_language_to_proceed'.tr,
                style:
                    robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                itemCount: localizationController.languages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Dimensions.paddingSizeSmall,
                  mainAxisSpacing: Dimensions.paddingSizeSmall,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return LanguageCardWidget(
                    languageModel: localizationController.languages[index],
                    localizationController: localizationController,
                    index: index,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 0)
              ],
            ),
            child: CustomButtonWidget(
              buttonText: 'next'.tr,
              onPressed: () {
                if (localizationController.languages.isNotEmpty &&
                    localizationController.selectedLanguageIndex != -1) {
                  localizationController.setLanguage(Locale(
                    AppConstants
                        .languages[localizationController.selectedLanguageIndex]
                        .languageCode!,
                    AppConstants
                        .languages[localizationController.selectedLanguageIndex]
                        .countryCode,
                  ));
                  Get.find<SplashController>().setLanguageIntro(false);
                  Get.offNamed(RouteHelper.getSignInRoute());
                } else {
                  showCustomSnackBar('select_a_language'.tr);
                }
              },
            ),
          ),
        ]);
      }),
    );
  }
}
