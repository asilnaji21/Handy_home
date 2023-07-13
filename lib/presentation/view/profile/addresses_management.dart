import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:handy_home_app/customwidget/textformfield_custom.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:skeletons/skeletons.dart';

import '../../../customwidget/custom_button_with_background_widget.dart';
import '../../resources/color_manager.dart';
import '../home/category_screen.dart';
import 'ProfileComponents/add_address_bottom_sheet.dart';

class AddressesManagementScreen extends StatefulWidget {
  const AddressesManagementScreen({Key? key}) : super(key: key);

  @override
  State<AddressesManagementScreen> createState() =>
      _AddressesManagementScreenState();
}

class _AddressesManagementScreenState extends State<AddressesManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context.read<ProfileCubit>().getUserInfo();
          return true;
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 10, right: 30),
              child: CustomHeaderWidget(
                title: 'إدارة العناوين',
              ),
            ),
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is LocationSuccessState &&
                      state.locations.isEmpty) {
                    return Text('لا يوجد عناوين');
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    itemBuilder: (context, index) {
                      if (state is LocationLoadingState) {
                        return SkeletonItem(
                            child: Container(
                          height: 120,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ));
                      } else if (state is LocationSuccessState) {
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'المنزل ${index + 1}',
                                      style:
                                          StyleManger.headline1(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    CustomIconButton(
                                        backgroundColor:
                                            ColorManager.background,
                                        iconColor: Colors.grey,
                                        icon: Icons.edit,
                                        onTap: () {
                                          print('edit');
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomIconButton(
                                      backgroundColor:
                                          ColorManager.redLightColor,
                                      iconColor: ColorManager.redDarkColor,
                                      icon: Icons.delete,
                                      onTap: () {
                                        print('delete');
                                      },
                                    )
                                  ],
                                ),
                                Text(state.locations[index].country +
                                    ' , ' +
                                    state.locations[index].city),
                                Text(state.locations[index].building +
                                    ' , ' +
                                    state.locations[index].apartmentNumber),
                                Text(state.locations[index].phoneNumber)
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Text('something went wrong');
                      }
                    },
                    itemCount: state is LocationSuccessState
                        ? state.locations.length
                        : state is LocationLoadingState
                            ? 10
                            : 0,
                  );
                },
              ),
            ),
            CustomButtonWithBackgroundWidget(
              text: '+ إضافة عنوان جديد',
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -3),
                  blurRadius: 10,
                  color: Colors.grey.shade400,
                )
              ],
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  clipBehavior: Clip.antiAlias,
                  context: context,
                  builder: (context) => const AddAddressBottomSheet(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ));
  }
}
