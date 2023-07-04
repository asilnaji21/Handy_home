import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';

Future<bool?> customDialogWidget(BuildContext context,
    {required String message}) async {
  return await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.redDarkColor,
                          elevation: 0),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text(
                        'نعم',
                        style: TextStyle(color: ColorManager.redLightColor),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.background,
                          elevation: 0),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        'لا',
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
