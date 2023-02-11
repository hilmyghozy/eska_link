import 'package:eska_link/utils/v_color.dart';
import 'package:flutter/material.dart';

Scaffold defaultWidgetContainer(
  context,
  PreferredSizeWidget appBar,
  Widget widget, {
  bool safeArea = false,
}) {
  return Scaffold(
    appBar: appBar,
    body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: !safeArea
            ? Container(
                color: VColor.primaryBackground,
                child: widget,
              )
            : Container(
                color: VColor.white,
                child: SafeArea(
                  child: Container(
                    color: VColor.primaryBackground,
                    child: widget,
                  ),
                ),
              )),
  );
}
