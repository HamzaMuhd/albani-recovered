import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget customTextField(
  BuildContext context, {
  required TextEditingController controller,
  required FocusNode focusNode,
  required String label,
  required String hintText,
  required String? Function(String?) validator,
  bool isObscure = false,
  void Function(String)? onFieldSubmitted,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    obscureText: isObscure,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      errorStyle: const TextStyle(color: Colors.red),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
  );
}
