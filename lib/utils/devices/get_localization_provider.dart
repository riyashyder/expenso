import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localization_controller.dart';

AppLocalizationController getLocalizationController(BuildContext context,
    {bool listen = false}) {
  return Provider.of<AppLocalizationController>(context, listen: listen);
}
