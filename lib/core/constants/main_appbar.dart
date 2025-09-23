import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../features/exportData/view/export_screen.dart';
import '../../shared/widgets/custom_widgets/page_transition.dart';
import '../../shared/widgets/styles/styles.dart';
import '../../utils/devices/get_localization_provider.dart';
import '../localization/app_localization_controller.dart';
import '../theme/styles/styles.dart';
import 'image_strings.dart';


class MainAppBar extends StatefulWidget {
  const MainAppBar({
    super.key,
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   Provider.of<Alertcontroller>(context, listen: false)
    //       .getNotificationCount();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final local = getLocalizationController(context, listen: true);

    return Directionality(
      textDirection: AppLocalizationController.currentAppLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        height: 100,
        color: AppthemeData.primaryBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // SvgPicture.asset(
              //   ImageandLogos.logosvg,
              //   width: 30,
              //   height: 30,
              // ),
              Row(
                children:  [
                  Icon(Icons.receipt_long, color: AppThemeData.whiteColor,size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Expenso",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppThemeData.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      GestureDetector(onTap:(){
                        Navigator.of(context).push(
                          PageTransition.buildPageRoute(
                            ExportScreen(),// replace with your page
                            // const LoginView(), // replace with your page
                            type: TransitionType.slide, // fade / scale / rotate
                          ),
                        );
                      },child: SizedBox(height:30,width:25,child: Image.asset(ImageandLogos.export_icon))),
                      // Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
                    ],
                  ),
                 SizedBox(width: 15),
                  GestureDetector(
                      // onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const AlertScreen()));
                      // },
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Stack(children: [
                            SvgPicture.asset(ImageandLogos.notification_icon),
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: Consumer<Alertcontroller>(
                            //     builder: (context, controller, child) {
                            //       if (controller.isLoading) {
                            //         const SizedBox();
                            //       }
                            //       return CircleAvatar(
                            //         backgroundColor: Colors.red,
                            //         radius: 8,
                            //         child: Center(
                            //           child: Text(
                            //             controller.newAlertCount.toString(),
                            //             style: const TextStyle(
                            //                 color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // )
                          ]))),
                SizedBox(width: 10,),

                  // GestureDetector(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       backgroundColor: AppThemeData.secondaryColor,
                  //       context: context,
                  //       shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  //       ),
                  //       builder: (context) {
                  //         final languages = [
                  //           {'code': 'en', 'label': 'English'},
                  //           {'code': 'ar', 'label': 'عربي'},
                  //         ];
                  //         return Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             // Header with title and close icon
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     'Selected Language',
                  //                     style: AppThemeData.headingStyle.copyWith(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                   IconButton(
                  //                     icon: const Icon(Icons.close),
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             const Divider(color: Colors.white24, thickness: 1),
                  //             // Language options
                  //             ...languages.map((lang) {
                  //               final isSelected =
                  //                   localizationController.appLanguage == lang['code'];
                  //               return InkWell(
                  //                 onTap: () {
                  //                   localizationController.changeLanguage(lang['code']!);
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: Container(
                  //                   width: double.infinity,
                  //                   padding:
                  //                   const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  //                   color: isSelected
                  //                       ? AppThemeData.teritaryColor
                  //                       : Colors.transparent,
                  //                   child: Text(
                  //                     lang['label']!,
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                       color: isSelected ? Colors.white : Colors.black,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 16,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //             const SizedBox(height: 20),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         localizationController.appLanguage == 'en' ? 'English' : 'عربي',
                  //         style: AppThemeData.headingStyle.copyWith(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //       const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
                  //     ],
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 0),
                  //   child: SizedBox(
                  //     height: 25,
                  //     // color: Colors.red,
                  //     child: DropdownButton<String>(
                  //       value: localizationController.appLanguage,
                  //       icon: const Icon(Icons.arrow_drop_down_sharp,
                  //           color: Colors.white),
                  //       dropdownColor: Colors.blue,
                  //       style: AppThemeData.buttonStyle,
                  //       underline: Container(),
                  //       items: const [
                  //         DropdownMenuItem(value: 'en', child: Text('English')),
                  //         DropdownMenuItem(value: 'ar', child: Text('عربي')),
                  //         // DropdownMenuItem(value: 'ta', child: Text('Tamil')),
                  //       ],
                  //       onChanged: (newLanguage) {
                  //         if (newLanguage != null) {
                  //           localizationController.changeLanguage(newLanguage);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
