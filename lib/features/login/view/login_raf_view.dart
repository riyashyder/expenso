  import 'package:expense_tracker/core/theme/styles/styles.dart';
  import 'package:expense_tracker/features/login/view/register_screen.dart';
  import 'package:expense_tracker/features/login/view/widget/switcher.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:provider/provider.dart';

  import '../../../core/constants/image_path_constants.dart';
  import '../../../core/localization/app_localization_controller.dart';
  import '../../../shared/connectivity_provider/connectivity_provider.dart';
  import '../../../shared/connectivity_provider/no_connectivity_screen.dart';
  import '../../../shared/widgets/styles/styles.dart';
  import '../../../utils/devices/get_localization_provider.dart';
  import '../controller/login_controller.dart';

  import 'login_screen.dart';

  class NoGlowScrollBehavior extends ScrollBehavior {
    Widget buildViewportChrome(
        BuildContext context,
        Widget child,
        AxisDirection axisDirection,
        ) {
      return child;
    }
  }

  class LoginPage extends StatefulWidget {
    final int initialTab;
    final String? id;
    final String? email;
    final String? mobile;

    const LoginPage({super.key, this.initialTab = 0,this.id,this.email, this.mobile});

    @override
    State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
    int selectedTab = 0;
    @override
    void initState() {
      super.initState();
      selectedTab = widget.initialTab;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final loginController = Provider.of<LoginController>(
          context,
          listen: false,
        );

        // final user = context.read<StartCreditController>().userModel;

        await loginController.loadRememberedCredentials();

        if (widget.email != null && widget.email!.isNotEmpty) {
          loginController.emailController.text = widget.email!;
          loginController.validateEmail(widget.email!);
        } else {
          loginController.emailController.text = '';
        }

        // if (widget.mobile != null && widget.mobile!.isNotEmpty) {
        //   registerController.mobileController.text = widget.mobile!;
        // } else {
        //   registerController.mobileController.text = '';
        // }
        loginController.notify();
      });
    }

    // int selectedTab = 0;
    bool showOtpScreen = false;
    // final loginController = LoginController();

    @override
    Widget build(BuildContext context) {
      final localizationController = getLocalizationController(
        context,
        listen: true,
      );
      final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
      return Consumer<ConnectivityProvider>(
        builder: (context, value, child) {
          if (value.isConnected) {
            return PopScope(
              canPop: true,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) {
                  Future.delayed(Duration.zero, () {
                    SystemNavigator.pop();
                  });
                }
              },
              child: Directionality(
                textDirection:
                AppLocalizationController.currentAppLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    backgroundColor: AppthemeData.primaryBackground,
                    resizeToAvoidBottomInset: true,
                    body: Stack(
                      children: [
                        Positioned.fill(
                          child: SvgPicture.asset(
                            'assets/images/login_background.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 40),

                            // Logo + App Name
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
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
                            ),

                            const SizedBox(height: 40),

                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10),
                              child: Text(
                                selectedTab==0? "Welcome back! \n\nYour financial journey continues. Log in to see your progress and stay on top of your goals.!" : "Every big goal starts with a small step. Sign up now and take charge of your spending, one expense at a time.",
                                style: AppthemeData.bigheadingStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppThemeData.whiteColor
                                ),
                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                                              //         SizedBox(
                                              //           height:
                                              //           MediaQuery.of(context).size.height * 0.06,
                                              //         ),
                                              //         Row(
                                              //           mainAxisAlignment: MainAxisAlignment.start,
                                              //           children: [
                                              //             SvgPicture.asset(
                                              //              ' Rimages.logosvg',
                                              //               width:
                                              //               MediaQuery.of(context).size.width *
                                              //                   0.03,
                                              //               height:
                                              //               MediaQuery.of(context).size.height *
                                              //                   0.03,
                                              //             ),
                                              //           ],
                                              //         ),
                                              //
                                              //         SizedBox(
                                              //           height:
                                              //           MediaQuery.of(context).size.height * 0.04,
                                              //         ),
                                              //         Align(
                                              //           alignment: Alignment.centerLeft,
                                              //           child: Text(
                                              //             localizationController.getTextValue(
                                              //               "LOGIN_HEADER",
                                              //             ),
                                              //             style: AppthemeData.bigheadingStyle,
                                              //           ),
                                              //         ),
                                              //         SizedBox(
                                              //           height:
                                              //           MediaQuery.of(context).size.height * 0.01,
                                              //         ),
                                              //         Align(
                                              //           alignment: Alignment.centerLeft,
                                              //           child: Text(
                                              //             localizationController.getTextValue(
                                              //               "PLAY_AND_WIN",
                                              //             ),
                                              //             style: AppthemeData.smallheadingStyle,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),

                            Spacer(),


                            Align(
                                                alignment: Alignment.bottomCenter,
                                                child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height:
                        isKeyboardOpen
                            ? MediaQuery.of(context).size.height * 0.50
                            : MediaQuery.of(context).size.height * 0.6,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50),
                          ),
                        ),
                        child: SingleChildScrollView(
                          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              TabSwitcher(
                                selectedTab: selectedTab,
                                onTabSelected: (index) {
                                  // final user =
                                  //     context
                                  //         .read<StartCreditController>()
                                  //         .userModel;
                                  final hasEmail =
                                      widget.email != null &&
                                          widget.email!.isNotEmpty;
                                  final hasMobile =
                                      widget.mobile != null &&
                                          widget.mobile!.isNotEmpty;

                                  if (hasEmail) {
                                    if (index == 1) return;
                                  } else if (!hasEmail && hasMobile) {
                                    if (index == 0) return;
                                  }

                                  setState(() {
                                    selectedTab = index;
                                  });
                                },

                                // onTabSelected: (index) {
                                //   setState(() {
                                //     selectedTab = index;
                                //   });
                                // },
                                leftTabText: "Login",
                                rightTabText: 'Register',
                              ),
                              if (selectedTab == 0)
                                LoginForm(
                                  id: widget.id,
                                  email: widget.email,
                                  // loginController: loginController,
                                  // localizationController:
                                  //     localizationController,
                                )
                              else if (selectedTab == 1 && !showOtpScreen)
                                RegisterForm(
                                  number: widget.mobile,
                                  onOtpSent: () {
                                    setState(() {
                                      showOtpScreen = true;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                                                ),
                                              ),
                                            ],
                                          ),
              ]),
            ))));
          }
          return NoConnectivityScreen();
        },
      );
    }
  }
