import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';

showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      // barrierColor: Colors.transparent,
      builder: (context) => const Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: ColorManager.primaryMainEnableColor,
                  )),
            ),
          ));
}
