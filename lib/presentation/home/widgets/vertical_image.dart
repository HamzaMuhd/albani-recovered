import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.backgrondColor,
    this.onTap,
  });
  final String image, title;
  final Color? backgrondColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: dark ? AppColors.grey : AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: SvgPicture.asset(image,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            dark ? Colors.black : Colors.white,
                            BlendMode.srcIn)))),
            const SizedBox(height: 16 / 2),
            SizedBox(
              width: 55,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
