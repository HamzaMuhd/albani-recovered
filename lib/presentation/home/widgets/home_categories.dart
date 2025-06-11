import 'package:albani/core/configs/constants/services_cadegories.dart';
import 'package:albani/presentation/home/widgets/vertical_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoriesController extends GetxController {
  final scrollController = ScrollController();
}

class HomeCategories extends StatelessWidget {
  HomeCategories({
    super.key,
  });
  final controller = Get.put(HomeCategoriesController());

  @override
  Widget build(BuildContext context) {
    final dark = context.isDarkMode;
    return Center(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          controller: controller.scrollController,
          shrinkWrap: true,
          itemCount: CategoriesData.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = CategoriesData.categories[index];
            return VerticalImageText(
              image: category.image,
              title: category.title,
              onTap: category.onTap,
            );
          },
        ),
      ),
    );
  }
}
