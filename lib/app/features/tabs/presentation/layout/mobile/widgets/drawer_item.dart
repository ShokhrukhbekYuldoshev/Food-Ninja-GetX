import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninja_theme/ninja_theme.dart';
import 'package:ninjafood/app/features/tabs/infrastructure/models/menu_models.dart';

class DrawerItem extends StatelessWidget {
  final bool isSelected;
  final MenuItem menuItem;
  final VoidCallback? onTap;

  const DrawerItem({Key? key, required this.isSelected, required this.menuItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String title = menuItem.title;
    if (menuItem.menuType == MenuType.changeTheme) {
      title = Get.isDarkMode ? "Light Theme" : "Dark Theme";
    }
    return AppPadding.small(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.8) : null,
          borderRadius: BorderRadius.circular(8),
          boxShadow: !isSelected
              ? null
              : [
                  BoxShadow(
                    color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(-4, 4),
                  ),
                  BoxShadow(
                      color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(4, -4))
                ],
        ),
        child: ListTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  menuItem.iconData,
                  color: isSelected ? ThemeColors.textDarkColor : null,
                  size: Theme.of(context).textTheme.bodyMedium!.fontSize,
                ),
                AppPadding.medium(
                  child: Text(
                    title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color:
                              isSelected ? ThemeColors.textDarkColor : Theme.of(context).textTheme.headlineSmall!.color,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                ),
              ],
            ),
          ),
          selected: isSelected,
          onTap: () => onTap?.call(),
        ),
      ),
    );
  }
}
