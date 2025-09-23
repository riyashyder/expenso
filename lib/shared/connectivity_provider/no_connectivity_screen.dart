import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utils/devices/get_localization_provider.dart';
import '../widgets/styles/styles.dart';
import 'connectivity_provider.dart';

class NoConnectivityScreen extends StatelessWidget {
  const NoConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = getLocalizationController(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            // SvgPicture.asset(Rimages.logoblack),
            // SizedBox(
            //   height: 40,
            // ),
            // SvgPicture.asset(Rimages.someWrong),
            Text(
              local.getTextValue("OOPS_OFFLINE"),
              style: AppthemeData.pageheding.copyWith(fontSize: 25),
            ),
            Text(
              local.getTextValue("CHECK_CONNECTION"),
              style: AppthemeData.headingStyle.copyWith(fontSize: 11),
            ),
            SizedBox(
              height: 15,
            ),
            Consumer<ConnectivityProvider>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () => value.checkConnectivity(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppthemeData.primaryBackground,
                    ),
                    width: 200,
                    height: 50,
                    child: Center(
                      child: value.isloading
                          ? CircularProgressIndicator(
                              strokeWidth: 0.5,
                              color: Colors.white,
                            )
                          : Text(
                              'Try Again',
                              style: AppthemeData.bottomSheetHintText
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
