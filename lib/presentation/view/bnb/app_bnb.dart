import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bookedServiceCubit/booked_service_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/searchCubit/search_cubit.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/view/bookedServices/booked_services_screen.dart';
import 'package:handy_home_app/presentation/view/notification/notification_screen.dart';
import 'package:handy_home_app/presentation/view/profile/profile_screen.dart';
import 'package:handy_home_app/presentation/view/search/search_screen.dart';

import '../../../app/locator.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/nofificationCubit/notification_cubit.dart';
import '../../../data/network/local/local_network.dart';
import '../../resources/assets_manager.dart';
import '../home/home_screen.dart';

class AppBNB extends StatefulWidget {
  const AppBNB({Key? key}) : super(key: key);

  @override
  State<AppBNB> createState() => _AppBNBState();
}

class _AppBNBState extends State<AppBNB> {
  Timer? timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        const Duration(seconds: 30),
        (Timer t) =>
            context.read<NotificationUnReadCubit>().unreadNotification());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BnbManagerCubit, BnbManagerState>(
        builder: (context, state) {
      List<Widget> tabs = [
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LatestServiceCubit(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
          ],
          child: const HomeScreen(),
        ),
        getIt<SharedPrefController>().getLoggedIn()
            ? const NotificationScreen()
            : const GestScreen(),
        getIt<SharedPrefController>().getLoggedIn()
            ? const BookedServiceScreen()
            : const GestScreen(),
        getIt<SharedPrefController>().getLoggedIn()
            ? BlocProvider(
                create: (context) => SearchCubit(),
                child: const SearchScreen(),
              )
            : const GestScreen(),
        getIt<SharedPrefController>().getLoggedIn()
            ? MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthCubit(),
                  )
                ],
                child: const ProfileScreen(),
              )
            : const GestScreen(),
      ];
      return Scaffold(
        body: tabs[state.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            context.read<BnbManagerCubit>().onSelectItem(value);
          },
          items: iconItemsPath
              .map(
                (e) => BottomNavigationBarItem(
                  label: '',
                  icon: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      SvgPicture.asset(
                        e,
                        color: state.selectedIndex == iconItemsPath.indexOf(e)
                            ? ColorManager.primaryMainEnableColor
                            : null,
                      ),
                      IconPath.notificationIcon == e
                          ? BlocBuilder<NotificationUnReadCubit,
                              NotificationUnReadState>(
                              builder: (context, state) {
                                return Visibility(
                                  visible:
                                      !(state is UnreadNotificationSuccess &&
                                          state.notifications.isEmpty),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    alignment: Alignment.topCenter,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}

List<String> iconItemsPath = [
  IconPath.homeIcon,
  IconPath.notificationIcon,
  IconPath.bookingIcon,
  IconPath.searchIcon,
  IconPath.profileIcon
];

class GestScreen extends StatelessWidget {
  const GestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('انت مستخدم زائر , لكي تتمتع بصلاحبات اكثر سجل دخول'),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  NavigationManager.goToAndRemove(RouteConstants.loginRoute);
                },
                child: const Text('تسجيل دخول'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
