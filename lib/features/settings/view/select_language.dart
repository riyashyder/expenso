import 'package:expense_tracker/shared/widgets/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/app_localization_controller.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../navigationScreens/view/bottom_navigation_bar.dart';


class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'日本語': 'jp'}
  ];

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(context, listen: false);
    var languageProvider =
    Provider.of<AppLocalizationController>(context, listen: false);
    String selectedLanguage = languageProvider.appLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationController.getTextValue("SELECT_LANGUAGE"),
        ),
        leading: GestureDetector(
          onTap: () {
            // Provider.of<CustomerNavigationProvider>(context, listen: false)
            //     .popIndex();
            // Navigate to another home screen
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios, // iOS style back arrow icon
              color: Colors.black, // Set the color of the icon
              size: 24.0, // Set the size of the icon
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: languages.map((language) {
            String languageName = language.keys.first;
            String languageCode = language.values.first;

            return ListTile(
              title: Text(languageName),
              trailing: Radio<String>(
                value: languageCode,
                groupValue: selectedLanguage,
                activeColor: AppthemeData.primaryBackground,
                onChanged: (String? value) async {
                  if (value != null) {
                    languageProvider.changeLanguage(value);

                    Navigator.pop(context, value); // return selected language
                  }
                },

                // onChanged: (String? value) async {
                //   if (value != null) {
                //     languageProvider.changeLanguage(value);
                //     final prefs = await SharedPreferences.getInstance();
                //     Navigator.pop(context);
                //     // Navigator.pushAndRemoveUntil(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //       builder: (context) =>
                //     //           NavigatioScreen()), // Replace with your dashboard widget
                //     //       (Route<dynamic> route) => false,
                //     // );
                //   }
                // },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
