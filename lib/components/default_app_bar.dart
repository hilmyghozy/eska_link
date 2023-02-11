import 'package:eska_link/utils/v_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar defaultAppBar(
  context,
  String? title, {
  dynamic action,
  VoidCallback? onBackPressed,
  bool showBackButton = false,
  Function()? searchSuffixAction,
}) {
  return AppBar(
      toolbarHeight: 56,
      centerTitle: false,
      titleSpacing: 0,
      surfaceTintColor: VColor.textBlack,
      leading: showBackButton
          ? IconButton(
              icon: Image.asset(
                "assets/images/ic-arrow-back.png",
                color: VColor.primaryGold,
                width: 32,
              ),
              onPressed: onBackPressed ??
                  () {
                    // Navigator.of(context).pop();
                    Get.back();
                  })
          : null,
      iconTheme: const IconThemeData(
          color: VColor.primaryGold, //change your color here
          size: 18),
      backgroundColor: VColor.primaryGreen,
      elevation: 0.0,
      title: Container(
        padding: showBackButton
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title ?? "",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [action ?? Container()]);
}
