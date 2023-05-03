import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninja_theme/ninja_theme.dart';
import 'package:ninjafood/app/features/role_user/home/controllers/home_controller.dart';
import 'package:ninjafood/app/features/role_user/home/presentation/layout/mobile/widgets/widgets.dart';
import 'package:ninjafood/app/features/role_user/tabs/controllers/tabs_controller.dart';
import 'package:ninjafood/app/helper/helper.dart';

class AppBarHomeWidget extends GetView<TabsController> {
  const AppBarHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(() {
              final homeController = Get.find<HomeController>();
              final isViewTypeNormal = homeController.homeViewType.value == HomeViewType.normal;
              if (!isViewTypeNormal) {
                return AppButtonBack(onPressed: () {
                  homeController.onPressedBackToNormalHome();
                });
              }
              return AppButtonDrawer(onPressed: () => controller.toggleDrawer());
            }),
            const Expanded(
              child: AppPadding(
                  padding: const AppEdgeInsets.only(top: AppGapSize.medium),
                  child: AppText.headlineSmall(text: 'Ninja Food')),
            ),
            AppButtonNotification(onPressed: () => controller.onPressedNotification()),
          ],
        ),
        AppPadding(
            padding: AppEdgeInsets.only(
              left: AppGapSize.medium,
              right: AppGapSize.medium,
              top: AppGapSize.medium,
              bottom: isIos ? AppGapSize.none : AppGapSize.medium,
            ),
            child: ProductSearchBar()),
      ],
    );
  }
}
