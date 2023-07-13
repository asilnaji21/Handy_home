import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/customwidget/custom_dialog_widget.dart';
import 'package:handy_home_app/data/network/local/local_network.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/view/profile/ProfileComponents/cureent_password_bottom_sheet.dart';
import 'package:handy_home_app/presentation/view/profile/ProfileComponents/edit_personal_info_bottom_sheet.dart';

import '../../../app/locator.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/snackbar.dart';
import '../../resources/style_manager.dart';
import 'ProfileComponents/personal_card_info.dart';
import 'ProfileComponents/profile_custom_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        children: [
          Text(
            'الملف الشخصي',
            style: StyleManger.headline1(),
          ),
          const SizedBox(
            height: 20,
          ),
          PersonalCardInfo(),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              NavigationManager.pushNamed(
                  RouteConstants.becomeServiceProviderInfoScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.secondaryLightColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: ColorManager.primaryMainEnableColor,
                    )
                  ]),
              child: ListTile(
                title: Text('انضم الينا كمقدم خدمة!',
                    style: StyleManger.headline1(fontSize: 14)),
                trailing: Container(
                  height: 25,
                  width: 25,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorManager.primaryMainEnableColor,
                  ),
                  child: SvgPicture.asset(
                    IconPath.dollarIcon,
                  ),
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  ProfileCustomListTile(
                    text: 'تغيير المعلومات الشخصية',
                    onTap: () {
                      personalInfoBottomSheet(context);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'تغيير البريد الالكتروني',
                    onTap: () {
                      changeEmailBottomSheet(context);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'إدارة العناوين',
                    onTap: () async {
                      bool value = await NavigationManager.pushNamed(
                          RouteConstants.addressesManagementScreen);
                      if (value) {
                        context.read<ProfileCubit>().getUserInfo();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  ProfileCustomListTile(
                    text: 'تواصل معنا',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'عن التطبيق',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الاستخدام',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الخصوصية',
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'الأسئلة الشائعة',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(top: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LogoutState &&
                      state.logoutStatus == LogoutStatus.success) {
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    NavigationManager.goToAndRemove(RouteConstants.loginRoute);
                  } else if (state is LogoutState &&
                      state.logoutStatus == LogoutStatus.failed) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  } else if (state is LogoutState &&
                      state.logoutStatus == LogoutStatus.loading) {
                    showLoading(context);
                  }
                },
                child: ListTile(
                  onTap: () async {
                    bool? value = await customDialogWidget(context,
                        message: 'هل انت متأكد من تسجيل الخروج؟');
                    if (value != null && value == true) {
                      context.read<AuthCubit>().logout(
                          refresh: getIt<SharedPrefController>()
                              .getUser()
                              .refreshToken);
                      getIt<SharedPrefController>().isLoggedIn(value: false);
                    }
                  },
                  title: Text('تسجيل الخروح',
                      style: StyleManger.headline1(
                        fontSize: 14,
                        color: ColorManager.redDarkColor,
                      )),
                  trailing: Container(
                    height: 22,
                    width: 22,
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: ColorManager.redLightColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      IconPath.logoutIcon,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
