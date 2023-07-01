import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../category_screen.dart';
import '../../../resources/validation_manager.dart';

Future<dynamic> ratingBottomSheet(BuildContext context,
    {required TextEditingController controller}) {
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    context: context,
    backgroundColor: ColorManager.background,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'قيّم تجربتك',
                        style: StyleManger.headline1(fontSize: 22),
                      ),
                      const CardForIconWidget(
                          icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 4,
                    minLines: 4,
                    key: fieldKey,
                    controller: controller,
                    validator: (value) => value!.isNotEmptyField,
                    decoration: const InputDecoration(
                        hintText:
                            'اكتب تعليقك هنا بكل صراحة لتحسين تجربة المستخدمين'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            width: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                          ),
                          itemCount: 5,
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 2.5,
                        unratedColor: Colors.grey,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glowColor: Colors.white,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: ColorManager.primaryMainEnableColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            CustomButtonWithBackgroundWidget(
                onPressed: () {
                  if (fieldKey.currentState!.validate()) {
                    print('rating ok');
                  }
                },
                text: 'تأكيد التقييم')
          ],
        ),
      ),
    ),
  );
}
