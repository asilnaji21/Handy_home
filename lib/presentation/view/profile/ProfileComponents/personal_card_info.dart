import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/bussiness%20logic/profileCubit/profile_cubit.dart';
import 'package:skeletons/skeletons.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/style_manager.dart';

class PersonalCardInfo extends StatefulWidget {
  const PersonalCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalCardInfo> createState() => _PersonalCardInfoState();
}

class _PersonalCardInfoState extends State<PersonalCardInfo> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is UserInfoLoadingState) {
          return SkeletonItem(
              child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ));
        } else if (state is UserInfoSuccessState) {
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: Endpoints.baseUrl + state.userInfoModel.image,
                    placeholder: (context, url) => const Card(
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.userInfoModel.firstName +
                          ' ' +
                          state.userInfoModel.lastName,
                      style: StyleManger.headline1(fontSize: 18),
                    ),
                    Text(
                      state.userInfoModel.email,
                      style: StyleManger.headline2(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return SkeletonItem(
            child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ));
      },
    );
  }
}
