import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/category_screen.dart';
import 'package:skeletons/skeletons.dart';

import '../../../bussiness logic/homeCubit/home_cubit.dart';
import 'HomeComponents/home_category_lable_widget.dart';
import 'HomeComponents/home_horizontal_category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().categories();
    context.read<HomeCubit>().latestAddedService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
          ),
          children: [
            Text(
              'الرئيسية',
              style: StyleManger.headline1(),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                print(state);
                return GridView.builder(
                    padding: const EdgeInsets.only(top: 21),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      if (state is CategoryLoadingState) {
                        return SkeletonItem(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.all(5),
                        ));
                      }
                      if (state is CategorySuccessState) {
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamed(
                                RouteConstants.categoryRoute,
                                arguments: index + 1);
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: state.categories[index].icon,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  state.categories[index].name,
                                  style: StyleManger.headline1(fontSize: 14),
                                ),
                                Text(
                                    '${state.categories[index].countServices} خدمات فرعية')
                              ],
                            ),
                          ),
                        );
                      }
                      return const CircularLoadingWidget();
                    });
              },
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.customServiceImage),
                    Text(
                      'لم تعثر على الخدمة المطلوبة؟',
                      style: StyleManger.headline1(fontSize: 14),
                    ),
                    const Text(
                      'يمكنك طلب خدمة مخصصة بما يتوافق مع احتياجاتك باضافة كافة التفاصيل حول الخدمة المطلوبة.',
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NavigationManager.pushNamed(
                            RouteConstants.orderCustomServiceRoute);
                      },
                      child: const Text('طلب خدمة مخصصة'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

        //TODO: solve the latest service added and most ordered api "there is confilict at the state"
        HomeCategoryLabelWidget(
          title: 'الأكثر طلباً',
          onPressed: () {},
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print(state);
            if (state is LatestServiceAddedLoadingState) {
              return SkeletonItem(
                  child: Container(
                height: 250,
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
        ),
        const SizedBox(
          height: 10,
        ),
        HomeCategoryLabelWidget(
          title: 'المضافة حديثاً',
          onPressed: () {},
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print(state);
            if (state is LatestServiceAddedLoadingState) {
              return SkeletonItem(
                  child: Container(
                height: 250,
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
        )
      ],
    );
  }
}
