import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';
import 'package:skeletons/skeletons.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../home/service_info_screen.dart';

class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({Key? key}) : super(key: key);

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookedServiceCubit>().activeOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BookedServiceCubit, BookedServiceState>(
        builder: (context, state) {
          if (state is ActiveOrderSuccessState && state.orders.isEmpty) {
            return const Center(
              child: Text('لا يوجد طلبات'),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (state is ActiveOrderLoadingState) {
                return const BookedServiceLoading();
              } else if (state is ActiveOrderSuccessState) {
                return InkWell(
                  onTap: () async {
                    await NavigationManager.pushNamed(
                        RouteConstants.serviceDetailsRoute,
                        arguments: Endpoints.serviceDetails(
                            id: state.orders[index].service));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    elevation: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      // height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              // alignment: Alignment.center,
                              child: Image.asset(
                                ImagePath.serviceImage,
                                fit: BoxFit.fill,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.orders[index].name ?? 'خدمة مخصصة',
                                    ),
                                    Text(
                                        'التاريخ: ${state.orders[index].dateOrder}'),
                                    Text(
                                        'الوقت: ${state.orders[index].timeOrder}'),
                                  ],
                                ),
                              )),
                          Expanded(
                              child: OrderStatusWidget(
                            text: state.orders[index].orderStatus,
                            alignment: Alignment.bottomCenter,
                            backgroundColor: checkColor(
                                status: state.orders[index].orderStatus,
                                isForText: false),
                            textColor: checkColor(
                                status: state.orders[index].orderStatus,
                                isForText: true),
                          ))
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: Text('Something went wrong'));
            },
            itemCount: state is ActiveOrderSuccessState
                ? state.orders.length
                : state is ActiveOrderLoadingState
                    ? 15
                    : 0,
          );
        },
      ),
    );
  }

  Color checkColor({required String status, required bool isForText}) {
    if (status == 'مرفوض') {
      return isForText ? ColorManager.redDarkColor : ColorManager.redLightColor;
    } else if (status == 'مكتمل') {
      return isForText
          ? ColorManager.greenDarkColor
          : ColorManager.greenLightColor;
    } else if (status == 'قيد المراجعة') {
      return isForText
          ? ColorManager.orangeDarkColor
          : ColorManager.orangeLightColor;
    } else {
      return isForText
          ? ColorManager.blueDarkColor
          : ColorManager.blueLightColor;
    }
  }
}

class BookedServiceLoading extends StatelessWidget {
  const BookedServiceLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
        child: Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
    ));
  }
}
