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
        itemBuilder: (context, index) => const SingleServiceWidget(
          imageHeight: 180,
        ),
      ),
    );
  }
}

class SingleServiceWidget extends StatelessWidget {
  const SingleServiceWidget({
    this.width,
    this.serviceFontSize = 14,
    this.imageHeight,
    Key? key,
  }) : super(key: key);
  final double? width;
  final double serviceFontSize;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: imageHeight,
                    width: width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.asset(
                      ImagePath.serviceImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'تنضيف داخلي: كنب وسجاد',
                    textAlign: TextAlign.right,
                    style: StyleManger.headline1(fontSize: serviceFontSize),
                    overflow: TextOverflow.ellipsis,
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
                top: 18,
                left: 16,
              ),
              child: StareRatingWidget(ratingNumber: '4.6'),
            )
          ],
        ),
      ),
    );
  }
}
