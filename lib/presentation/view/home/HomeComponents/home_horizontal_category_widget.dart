import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/stare_rating_widget.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/style_manager.dart';

class HomeHorizontalCategoryWidget extends StatelessWidget {
  const HomeHorizontalCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: 27),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImagePath.serviceImage,
                      height: 180,
                    ),
                    Text(
                      'تنضيف داخلي: كنب وسجاد',
                      textAlign: TextAlign.right,
                      style: StyleManger.headline1(fontSize: 14),
                    ),
                    Text(
                      '30 - 50 ش',
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                ),
                child: StareRatingWidget(ratingNumber: '4.6'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
