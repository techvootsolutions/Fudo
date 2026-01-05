import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fudo/src/core/utils/Style/colors.dart';
import 'package:fudo/src/core/utils/Style/text_style.dart';
import 'package:fudo/src/core/utils/helper/padding_class.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? okButtonText,
  VoidCallback? onTapOk,
  bool isShowCancel = false,
  String cancelButtonText = '',
}) {
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: AppBgColors.background),
    onPressed:
        onTapOk ??
        () async {
          NavigationService.goBack();
        },
    child: Text(
      okButtonText ?? "Okay",
      style: TextStyleTheme.customTextStyle(
        color: AppTextColors.black,
        size: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: AppBgColors.cream),
    onPressed: () async {
      NavigationService.goBack();
    },
    child: Text(
      cancelButtonText,
      style: TextStyleTheme.customTextStyle(
        color: AppTextColors.white,
        size: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyleTheme.customTextStyle(
        color: AppTextColors.black,
        size: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    content: Text(content ?? ""),
    actions: [isShowCancel == true ? cancelButton : Container(), okButton],
  );

  /// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

customAlert({
  required BuildContext context,
  Widget? title,
  Widget? content,
  Widget? cancelWidget,
  Widget? confirmWidget,
  Color? backGroundColor,
  bool? barrierDismissible,
  String? contentString,
  String? cancelButtonTExt,
  String? confirmButtonText,
  bool? isCenterAction = true,
  bool? showCancelBtn = true,
  VoidCallback? onSubmit,
  Future<bool> Function()? onWillPop,
}) {
  return showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.4),
    transitionBuilder: (context, a1, a2, widget) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor: AppBgColors.white,
            actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
            contentPadding: EdgeInsets.only(right: 20, left: 20, top: 15),
            title: title,
            content: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  content ??
                      Text(
                        contentString ?? "",
                        style: TextStyleTheme.customTextStyle(
                         
                        ),
                        textAlign: TextAlign.center,
                      ),
                  paddingTop(10),
                ],
              ),
            ),
            actionsAlignment: isCenterAction!
                ? MainAxisAlignment.spaceEvenly
                : null,
            actions: <Widget>[
              if (showCancelBtn ?? true)
                cancelWidget ??
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                      ),
                      onPressed: () => NavigationService.goBack(),
                      child: Text(
                        cancelButtonTExt ?? 'Cancel',
                        style: TextStyleTheme.customTextStyle(
                          size: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
              confirmWidget ??
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppButtonColors.primaryBtnColor,
                      ),
                    ),
                    onPressed: onSubmit ?? () => NavigationService.goBack(),
                    child: Text(
                      confirmButtonText ?? 'Okay',
                      style: TextStyleTheme.customTextStyle(
                        color: AppTextColors.white,
                        size: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox();
    },
  );
}

customAlert2({
  required BuildContext context,
  Widget? title,
  Widget? content,
  Widget? cancelWidget,
  Widget? confirmWidget,
  Color? backGroundColor,
  bool? barrierDismissible,
  String? contentString,
  String? cancelButtonTExt,
  String? confirmButtonText,
  bool? isCenterAction = true,
  bool? showCancelBtn = true,
  VoidCallback? onSubmit,
  Future<bool> Function()? onWillPop,
}) {
  return showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.4),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppBgColors.newBgSecondaryColor,
          actionsPadding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          contentPadding: EdgeInsets.only(right: 20, left: 20, top: 15),
          title: title,
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                content ??
                    Text(
                      contentString ?? "",
                      style: TextStyleTheme.customTextStyle(
                        color: AppTextColors.black,
                        size: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                paddingTop(10),
              ],
            ),
          ),
          actionsAlignment: isCenterAction!
              ? MainAxisAlignment.spaceEvenly
              : null,
          actions: <Widget>[
            if (showCancelBtn ?? true)
              cancelWidget ??
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppBgColors.lightRed,
                      ),
                    ),
                    onPressed: () => NavigationService.goBack(),
                    child: Text(
                      cancelButtonTExt ?? 'Cancel',
                      style: TextStyleTheme.customTextStyle(
                        color: AppTextColors.black,
                        size: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            confirmWidget ??
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppBgColors.primary70Opacity,
                    ),
                  ),
                  onPressed: onSubmit ?? () => NavigationService.goBack(),
                  child: Text(
                    confirmButtonText ?? 'Okay',
                    style: TextStyleTheme.customTextStyle(
                      color: AppTextColors.black,
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox();
    },
  );
}
