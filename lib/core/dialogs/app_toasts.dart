import 'package:flutter/material.dart';
import 'package:movie/core/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

abstract class AppToast {
  static void showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      type: type,
      title: Text(title, style: Theme.of(context).textTheme.labelLarge),
      description: Text(
        description,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      primaryColor: AppColors.white,
      autoCloseDuration: const Duration(seconds: 3),
      progressBarTheme: ProgressIndicatorThemeData(
        color: type == ToastificationType.success
            ? AppColors.green
            : type == ToastificationType.info
            ? AppColors.blue
            : type == ToastificationType.warning
            ? AppColors.orange
            : AppColors.red,
      ),
      showProgressBar: true,
      backgroundColor: type == ToastificationType.success
          ? AppColors.green
          : type == ToastificationType.info
          ? AppColors.blue
          : type == ToastificationType.warning
          ? AppColors.orange
          : AppColors.red,
      foregroundColor: AppColors.white,
    );
  }
}
