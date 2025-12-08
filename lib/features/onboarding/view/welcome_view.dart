import 'package:expense_tracker/features/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/custom_widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_widgets/page_transition.dart';
import '../../../shared/widgets/styles/styles.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../../login/view/login_raf_view.dart';
import '../../navigationScreens/view/bottom_navigation_bar.dart';
import '../controller/welcome_controller.dart';


class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}



class _WelcomeViewState extends State<WelcomeView> {
  @override

  final controller = WelcomeController();
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkAccessToken();
  }

  Future<void> _checkAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? "";
    print("shared token");
    print(token);

    if (token.isNotEmpty) {
      // Navigate directly to bottom navigation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NavigatioScreen()),
        );
      });
    } else {
      // Stay on Welcome screen
      setState(() {
        _isChecking = false;
      });
    }
  }

  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(
      context,
      listen: true,
    );



    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration (replace with your asset or network image)
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
              child: Image.asset(
                "assets/images/onboardingscreen.jpg",
                // height: 200,
                 // auto play
              ),
            ),
            const SizedBox(height: 20),

             Text(
                localizationController.getTextValue(
                  "WELCOME_TRACK_EXPENSES_TITLE",
                ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text(
                localizationController.getTextValue(
                  "WELCOME_DESCRIPTION",
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54,fontSize: 14),
              ),
            ),

        Spacer(),

            // Sign Up Button
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: AppElevatedButton(
            //           label: 'Sign Up',
            //           textStyle: AppthemeData.buttonStyle,
            //           onPressed: (){},
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 20),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      label: localizationController.getTextValue(
                "WELCOME_GET_STARTED",
              ),
                      textStyle: AppthemeData.buttonStyle,
                      onPressed: (){
                        Navigator.of(context).push(
                          PageTransition.buildPageRoute(
                            const LoginPage(), // replace with your page
                            // const LoginView(), // replace with your page
                            type: TransitionType.slide, // fade / scale / rotate
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text(
                localizationController.getTextValue(
                  "WELCOME_TERMS_TEXT",
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
