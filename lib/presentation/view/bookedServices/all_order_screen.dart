import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';

import '../../../app/constants_manager.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../home/service_info_screen.dart';
import 'active_order_screen..dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookedServiceCubit>().allOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BookedServiceCubit, BookedServiceState>(
        builder: (context, state) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (state is AllOrderLoadingState) {
                return const BookedServiceLoading();
              } else if (state is AllOrderSuccessState) {
                if (state.orders.isEmpty) {
                  return const Center(
                    child: Text('لا يوجد طلبات'),
                  );
                }
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 90,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                    state.orders[index].totalPrice.toString(),
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
                );
              }
              return const Center(child: Text('Something went wrong'));
            },
            itemCount: state is AllOrderSuccessState
                ? state.orders.length
                : state is AllOrderLoadingState
                    ? 15
                    : 0,
          );
        },
      ),
    );
  }
}
