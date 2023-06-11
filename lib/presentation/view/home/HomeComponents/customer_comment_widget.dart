import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/stare_rating_widget.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/style_manager.dart';
class CustomerCommentWidget extends StatelessWidget {
  const CustomerCommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                ImagePath.profileImage,
                fit: BoxFit.fill,
              ),
              clipBehavior: Clip.antiAlias,
            ),
            Text(
              'أحمد العزايزة',
              style: StyleManger.headline1(fontSize: 12),
            ),
            const Spacer(),
            const StareRatingWidget(ratingNumber: '4.6')
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد.',
          style: StyleManger.headline2(),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
