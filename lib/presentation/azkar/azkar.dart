// screens/azkar_screen.dart
import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/azkar/azkdar_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/azkar_controller.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AzkarController controller = Get.put(AzkarController());

    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          "Azkar",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DuaDetailsScreen(
                    duas: category.duas, categoryName: category.name));
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.book, size: 40, color: AppColors.primary),
                    const SizedBox(height: 10),
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
