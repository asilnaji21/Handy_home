import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app/l10n/locale_keys.g.dart';
import '../app/routes/navigation_manager.dart';
import '../presentation/resources/color_manager.dart';

class BackButtonCstom extends StatelessWidget {
  const BackButtonCstom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => NavigationManager.pop(),
      icon: const Icon(
        Icons.arrow_back,
        color: ColorManager.brownColor,
      ),
      label: Text(
        LocaleKeys.backText.tr(),
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: ColorManager.brownColor),
      ),
      style: const ButtonStyle(alignment: AlignmentDirectional.bottomStart),
    );
  }
}
