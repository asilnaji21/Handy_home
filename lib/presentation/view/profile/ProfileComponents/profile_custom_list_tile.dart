import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';

class ProfileCustomListTile extends StatelessWidget {
  const ProfileCustomListTile({
    this.onTap,
    required this.text,
    Key? key,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Text(text, style: StyleManger.headline1(fontSize: 14)),
      trailing: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: ColorManager.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: const Icon(
          Icons.arrow_right_rounded,
        ),
      ),
    );
  }
}
