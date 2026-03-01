import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String? title;

  const CustomAppBar({super.key, this.title, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? BackButton(
              style: IconButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.grey300),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: true,
      title: Text(title ?? ''),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
