import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
class BookedServiceLoading extends StatelessWidget {
  const BookedServiceLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Container(
        height: 90,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
