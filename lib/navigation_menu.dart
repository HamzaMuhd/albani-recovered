import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade500, // Border color
                  width: 0.1, // Border thickness
                ),
              ),
            ),
            child: NavigationBar(
                height: 70,
                elevation: 0,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Custom rounded corners
                ),
                backgroundColor: context.isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.ligthBackground,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                destinations: List<NavigationDestination>.generate(
                    controller.destinations.length, (index) {
                  final destination = controller.destinations[index];
                  return NavigationDestination(
                    icon: destination.isSvg
                        ? SvgPicture.asset(
                            controller.selectedIndex.value == index
                                ? destination.unselectedSvg!
                                : destination.selectedSvg!,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                                controller.selectedIndex.value == index
                                    ? AppColors.primary
                                    : context.isDarkMode
                                        ? const Color(0xFFC9C2D0)
                                        : const Color(0xFF49454F),
                                BlendMode.srcIn))
                        : Icon(
                            size: 28,
                            destination.icon,
                            color: controller.selectedIndex.value == index
                                ? AppColors.primary
                                : null,
                          ),
                    label: destination.label,
                  );
                }))),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
