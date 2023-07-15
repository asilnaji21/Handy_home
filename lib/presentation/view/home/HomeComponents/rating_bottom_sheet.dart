import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';

import '../../../../customwidget/loading_widget.dart';
import '../../../../customwidget/snackbar.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../category_screen.dart';
import '../../../resources/validation_manager.dart';

Future<dynamic> ratingBottomSheet(
  BuildContext context, {
  required int serviceId,
}) {
  // GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  return showModalBottomSheet(
    barrierColor: Colors.grey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    context: context,
    backgroundColor: ColorManager.background,
    isScrollControlled: true,
    builder: (context) => RatingWidget(
      // fieldKey: fieldKey
      serviceId: serviceId,
    ),
  );
}

class RatingWidget extends StatefulWidget {
  const RatingWidget({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  final int serviceId;

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  TextEditingController commentController = TextEditingController();
  double selectedRating = 2.5;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 350.h,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                    maxLines: 3,
                    minLines: 3,
                    key: fieldKey,
                    controller: commentController,
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
                          setState(() {
                            selectedRating = rating;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is ReviewLoadingState) {
                  showLoading(context);
                } else if (state is ReviewSuccessState) {
                  context.read<HomeCubit>().serviceDetails(
                      endPoint: Endpoints.serviceDetails(id: widget.serviceId));
                  NavigationManager.pop();
                  NavigationManager.pop();
                  showSnackBar(context,
                      text: state.message,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                } else if (state is ReviewFailedState) {
                  NavigationManager.pop();
                  NavigationManager.pop();
                  showSnackBar(context,
                      text: state.message,
                      backgroundColor: Colors.grey,
                      textColor: Colors.black);
                }
              },
              child: CustomButtonWithBackgroundWidget(
                  onPressed: () {
                    if (fieldKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<HomeCubit>().addReview(
                          reviewValue: selectedRating.toInt(),
                          comment: commentController.text,
                          service: widget.serviceId);
                    }
                  },
                  text: 'تأكيد التقييم'),
            )
          ],
        ),
      ),
    );
  }
}
