import 'package:expense_tracker/features/onboarding/view/shooting_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/styles/styles.dart';
import 'hiBubble.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Top Section
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.flash_on, size: 20, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "Myga",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),


                // const SizedBox(height: 20),

                // Astronaut + Planet Image
                Expanded(
                  child: Stack(
                    children: [
                      // Top-right positioned star
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 10, right: 10), // Optional padding
                      //     child: Image.asset(
                      //       'assets/images/shooting_star.png', // Replace with your star image
                      //       width: 50, // Adjust size as needed
                      //       height: 50,
                      //     ),
                      //   ),
                      // ),
                      // Centered content
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ...List.generate(5, (index) => Positioned.fill(top:0,right:0,child: Padding(
                              padding: const EdgeInsets.only(top: 10, right: 10),
                              child: ShootingStar(),
                            )
                            )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 90),
                              child: Image.asset(
                                'assets/images/onboard_star.png',

                                fit: BoxFit.contain,
                              ),
                            ),
                            // Adjust these values to align exactly with the hand
                            const Positioned(
                              top: 100,   // Tune this for exact hand location
                              right: 250,
                              child: HiBubble(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: Image.asset(
                                'assets/images/onboard_spaceman.png',
                                height: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // SvgPicture.asset(
                            //   'assets/images/drop_shape.svg',
                            //   height: 250,
                            //   fit: BoxFit.contain,
                            // )


                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: const [
                      Text(
                        'Nice to meet you',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'I’m Myga, your Genius Assistant',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Built with cognitive science and powered by AI. I’ll help you master what matters most — at your own pace, in your own way.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeData.darkViolet, // Dark purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size.fromHeight(60),
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Internal padding
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Navigation logic
                    },
                    child: Row(
                      children: [
                        // Invisible placeholder to balance the layout
                        Container(
                          width: 36, // width equal to icon container for perfect centering
                        ),

                        // Expanded to center the text
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Icon in rounded rectangle
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppThemeData.whiteColor,
                            // color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            color: AppThemeData.darkViolet,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),




                const SizedBox(height: 40),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/drop_shape_1.svg',
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text over the SVG background
          Positioned(
            bottom: 30, // Adjust as needed
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children:  [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Nice to meet you',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'I’m Myga, your Genius Assistant',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text(
                      'Built with cognitive science and powered by AI. I’ll help you master what matters most — at your own pace, in your own way.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 2.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeData.darkViolet, // Dark purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size.fromHeight(60),
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Internal padding
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Navigation logic
                    },
                    child: Row(
                      children: [
                        // Invisible placeholder to balance the layout
                        Container(
                          width: 36, // width equal to icon container for perfect centering
                        ),

                        // Expanded to center the text
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Icon in rounded rectangle
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppThemeData.whiteColor,
                            // color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            color: AppThemeData.darkViolet,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
