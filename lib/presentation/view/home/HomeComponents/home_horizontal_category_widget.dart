import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/stare_rating_widget.dart';
import 'package:handy_home_app/presentation/view/home/order_custom_service_screen.dart';
import 'package:skeletons/skeletons.dart';

import '../../../resources/style_manager.dart';

class HomeHorizontalCategoryWidget extends StatelessWidget {
  const HomeHorizontalCategoryWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LatestServiceAddedLoadingState) {
          return SkeletonItem(
              child: Container(
            color: Colors.white,
          ));
        } else if (state is LatestServiceAddedSuccessState) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 27),
              scrollDirection: Axis.horizontal,
              itemCount: state.services.length,
              itemBuilder: (context, index) => SingleServiceWidget(
                imageHeight: 180,
                image: state.services[index].image,
                price:
                    '${state.services[index].priceFrom}-${state.services[index].priceTo}',
                serviceName: state.services[index].name,
              ),
            ),
          );
        }
        return const Icon(
          Icons.error,
          size: 30,
        );
      },
    );
  }
}

class SingleServiceWidget extends StatelessWidget {
  const SingleServiceWidget({
    this.width,
    this.serviceFontSize = 14,
    this.imageHeight,
    this.loadingPlaceholder,
    Key? key,
    required this.image,
    required this.serviceName,
    required this.price,
  }) : super(key: key);
  final double? width;
  final double serviceFontSize;
  final double? imageHeight;
  final String image;
  final String serviceName;
  final String price;
  final Widget? loadingPlaceholder;
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
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) =>
                          loadingPlaceholder ??
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Text(
                    serviceName,
                    textAlign: TextAlign.right,
                    style: StyleManger.headline1(fontSize: serviceFontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$price ش',
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
