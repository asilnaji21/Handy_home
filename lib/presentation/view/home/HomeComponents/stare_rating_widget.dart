import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';

class StareRatingWidget extends StatelessWidget {
  const StareRatingWidget({
    Key? key,
    required this.ratingNumber,
  }) : super(key: key);
  final String ratingNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      width: 53,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 20,
          ),
          Text(
            ratingNumber,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorManager.primaryMainEnableColor,
      ),
    );
  }
}
