import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/category_screen.dart';
import 'package:skeletons/skeletons.dart';
import '../../../app/locator.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/custom_button_with_background_widget.dart';
import '../../../customwidget/custom_dialog_widget.dart';
import '../../../data/models/service_model.dart';
import '../../../data/network/local/local_network.dart';
import 'HomeComponents/customer_comment_widget.dart';
import 'HomeComponents/order_service_bottom_sheet.dart';
import 'HomeComponents/rating_bottom_sheet.dart';
import 'HomeComponents/stare_rating_widget.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({required this.serviceEndPoint, Key? key})
      : super(key: key);
  final String serviceEndPoint;
  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController ratingController = TextEditingController();
  bool isScroll = false;
  ServiceModel? service;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().serviceDetails(endPoint: widget.serviceEndPoint);
    context.read<BookedServiceCubit>().allOrders();
    scrollController.addListener(() {
      setState(() {
        isScroll = scrollController.offset > 0;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ServiceDetailsSuccessState) {
              setState(() {
                service = state.serviceDetails;
              });
            }
          },
          builder: (context, state) {
            if (state is ServiceDetailsLoadingState) {
              return const CircularLoadingWidget();
            } else if (state is ServiceDetailsSuccessState) {
              return Column(
                children: [
                  Container(
                    color: isScroll ? Colors.white : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: CustomHeaderWidget(
                        title: state.serviceDetails.name,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: CachedNetworkImage(
                                      imageUrl: state.serviceDetails.image,
                                      placeholder: (context, url) => Container(
                                        height: 180,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        color: Colors.grey,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                                left: 25,
                              ),
                              child: StareRatingWidget(ratingNumber: '4.6'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                state.serviceDetails.name,
                                style: StyleManger.headline1(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  '${state.serviceDetails.priceFrom} - ${state.serviceDetails.priceTo} شيكل'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'تتضمن هذه الخدمة التالي:',
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.serviceInclude!
                            .map((e) => Text('✅ $e'))
                            .toList(),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'لا تتضمن هذه الخدمة التالي:',
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.serviceExclude!
                            .map((e) => Text('❌ $e'))
                            .toList(),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تعليقات العملاء',
                              style: StyleManger.headline1(fontSize: 16),
                            ),
                            Visibility(
                              visible:
                                  getIt<SharedPrefController>().getLoggedIn(),
                              child: BlocBuilder<BookedServiceCubit,
                                  BookedServiceState>(
                                builder: (context, ordersState) {
                                  if (ordersState is AllOrderLoadingState) {
                                    return SkeletonItem(
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  } else if (ordersState
                                      is AllOrderSuccessState) {
                                    if (ordersState.orders.any((element) =>
                                        (element.service ==
                                            state.serviceDetails.id) &&
                                        element.orderStatus == 'مكتمل')) {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager
                                                .buttonBackgroundColor,
                                          ),
                                          onPressed: () {
                                            ratingBottomSheet(context,
                                                serviceId:
                                                    state.serviceDetails.id!);
                                          },
                                          child: const Text(
                                            'قيّم تجربتك',
                                            style: TextStyle(
                                              color: ColorManager
                                                  .primaryMainEnableColor,
                                            ),
                                          ));
                                    }
                                    return SizedBox();
                                  }
                                  return SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.reviews!
                            .map(
                              (e) => CustomerCommentWidget(
                                comment: e.comment,
                                image: Endpoints.baseUrl + e.image,
                                name: e.name,
                                rating: e.review,
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Icon(
              Icons.error,
              size: 30,
            );
          },
        ),
        bottomNavigationBar: CustomButtonWithBackgroundWidget(
            onPressed: () async {
              if (getIt<SharedPrefController>().getLoggedIn()) {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  context: context,
                  backgroundColor: ColorManager.background,
                  useSafeArea: true,
                  isScrollControlled: true,
                  builder: (context) => OrderServiceBottomSheet(
                    service: service,
                  ),
                );
              } else {
                bool? value = await customDialogWidget(context,
                    buttonColor: ColorManager.primaryMainEnableColor,
                    message:
                        'انت مستخدم زائر , لكي تتمتع بصلاحبات اكثر سجل دخول');
                if (value != null && value) {
                  NavigationManager.goToAndRemove(RouteConstants.loginRoute);
                }
              }
            },
            text: 'اطلب هذه الخدمة'));
  }
}

List<String> include = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];

List<String> exclude = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];
