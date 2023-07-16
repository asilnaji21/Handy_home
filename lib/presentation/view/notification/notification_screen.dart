import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/bussiness%20logic/nofificationCubit/notification_cubit.dart';
import 'package:handy_home_app/data/models/notification_model.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/service_info_screen.dart';
import 'package:skeletons/skeletons.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../data/repository/notificationRepository/notificationiRepository.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().readNotification();
    context.read<NotificationUnReadCubit>().unreadNotification();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('my-widget-key'),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        if (!isVisible) {
          NotificationRepository().changeNotification();
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 5),
              child: Text(
                'الاشعارات',
                style: StyleManger.headline1(),
              ),
            ),
            BlocBuilder<NotificationUnReadCubit, NotificationUnReadState>(
              builder: (context, unreadState) {
                return BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, readState) {
                    if (readState is ReadNotificationLoading ||
                        unreadState is UnreadNotificationLoading) {
                      return Expanded(
                        child: SkeletonListView(
                          itemBuilder: (p0, p1) => Container(
                            height: 70,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      );
                    } else if (readState is ReadNotificationSuccess &&
                        unreadState is UnreadNotificationSuccess) {
                      return Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: !unreadState.notifications.isEmpty,
                              child: Text(
                                'الحديثة',
                                style: StyleManger.headline1(fontSize: 18),
                              ),
                            ),
                            ...unreadState.notifications
                                .map((e) => InkWell(
                                      onTap: () {
                                        print(e);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 0),
                                                color: checkColor(
                                                  status: e.orderStatus,
                                                  isForText: true,
                                                ),
                                              )
                                            ]),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.text,
                                              style: StyleManger.headline1(
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('حالة الطلب:'),
                                                OrderStatusWidget(
                                                  text: e.orderStatus,
                                                  backgroundColor: checkColor(
                                                      status: e.orderStatus,
                                                      isForText: false),
                                                  textColor: checkColor(
                                                      status: e.orderStatus,
                                                      isForText: true),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                            Visibility(
                              visible: !readState.notifications.isEmpty,
                              child: Text(
                                'القديمة',
                                style: StyleManger.headline1(fontSize: 18),
                              ),
                            ),
                            ...readState.notifications
                                .map((e) => InkWell(
                                      onTap: () {
                                        print(e);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 0),
                                                color: checkColor(
                                                  status: e.orderStatus,
                                                  isForText: true,
                                                ),
                                              )
                                            ]),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.text,
                                              style: StyleManger.headline1(
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('حالة الطلب:'),
                                                OrderStatusWidget(
                                                  text: e.orderStatus,
                                                  backgroundColor: checkColor(
                                                      status: e.orderStatus,
                                                      isForText: false),
                                                  textColor: checkColor(
                                                      status: e.orderStatus,
                                                      isForText: true),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      );
                    }
                    return Text('something went wrong');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// List<NotificationModel> notifications = [];
                      // notifications.addAll(unreadState.notifications);
                      // notifications.addAll(readState.notifications);
                      // return Expanded(
                      //   child: ListView.builder(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 28, vertical: 10),
                      //       physics: const BouncingScrollPhysics(),
                      //       itemCount: notifications.length,
                      //       itemBuilder: (context, index) {
                      //         return InkWell(
                      //           onTap: () {
                      //             print(index);
                      //           },
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               if (index ==
                      //                   readState.notifications.length - 1)
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(bottom: 15),
                      //                   child: Text(
                      //                     'القديمة',
                      //                     style: StyleManger.headline1(
                      //                         fontSize: 18),
                      //                   ),
                      //                 ),
                      //               if (index == 0)
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(bottom: 15),
                      //                   child: Text(
                      //                     'الحديثة',
                      //                     style: StyleManger.headline1(
                      //                         fontSize: 18),
                      //                   ),
                      //                 ),
                      //               Container(
                      //                 margin: const EdgeInsets.only(bottom: 10),
                      //                 clipBehavior: Clip.antiAlias,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(8),
                      //                     color: Colors.white,
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                         offset: const Offset(3, 0),
                      //                         color: checkColor(
                      //                           status: notifications[index]
                      //                               .orderStatus,
                      //                           isForText: true,
                      //                         ),
                      //                       )
                      //                     ]),
                      //                 padding: const EdgeInsets.all(8),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       notifications[index].text,
                      //                       style: StyleManger.headline1(
                      //                           fontSize: 14),
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 8,
                      //                     ),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         Text('حالة الطلب:'),
                      //                         OrderStatusWidget(
                      //                           text: notifications[index]
                      //                               .orderStatus,
                      //                           backgroundColor: checkColor(
                      //                               status: notifications[index]
                      //                                   .orderStatus,
                      //                               isForText: false),
                      //                           textColor: checkColor(
                      //                               status: notifications[index]
                      //                                   .orderStatus,
                      //                               isForText: true),
                      //                         )
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // );