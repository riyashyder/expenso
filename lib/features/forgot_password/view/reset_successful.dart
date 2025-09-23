import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
// import 'package:raffle_lk_shop/features/auth/view/login_view.dart';

// import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localization_controller.dart';
import '../../../core/theme/styles/styles.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/login_raf_view.dart';
// import '../../../core/utils/helpers/provider_helper.dart';
// import '../../../widgets/custom_widgets/app_elevated_button.dart';

class ResetSuccessful extends StatelessWidget {
  const ResetSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(context, listen: true);

    return Directionality(
      textDirection: AppLocalizationController.currentAppLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/img_login_background.svg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/icons/icn_goback.svg',
                            width: MediaQuery.of(context).size.width * 0.042,
                            height: MediaQuery.of(context).size.height * 0.042,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/images/raffle_logo.svg',
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Center(
                            child: Lottie.asset(
                              "assets/lottie/passwordResetSuccess.json",
                              width: 500,
                              height: 200,
                              fit: BoxFit.contain,
                              repeat: false,
                              // animate: true,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                          Text(localizationController.getTextValue("PASSWORD_SUCCESS_HEADER"),
                              style: AppThemeData.headingStyle),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          Text(
                            localizationController.getTextValue("PASSWORD_SUCCESS_SUB_HEADER"),
                            textAlign: TextAlign.center,
                            style: AppthemeData.subheadingStyle.copyWith(fontSize: 14),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                          Row(
                            children: [
                              Expanded(
                                child: AppElevatedButton(
                                  label: localizationController.getTextValue("PASSWORD_SUCCESS_CONTINUE"),
                                  textStyle: AppthemeData.buttonStyle.copyWith(fontSize: 14),
                                  // onPressed: controller.submitOtp,
                                  onPressed: () {
                                    // Navigator.popUntil(context, (route) => route.isActive);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                    );

                                    // Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                                    //       (Route<dynamic> route) => false,
                                    // );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
