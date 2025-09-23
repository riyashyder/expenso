//add common styles here which are used acorss apps
import 'package:flutter/material.dart';

class AppthemeData {
  static const Color primaryBackground = Color(0xFF002885);
  static const Color textheadingcolor = Color(0xff2f60d6);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color teritaryColor = Color(0xFF295ACB);
  static const Color otherColor = Color(0xFF1745AD);
  static const Color circleColor = Color(0xFF2353C1);
  static const Color blackColor = Color(0xFF000000);
  static const Color buttonColor = Color(0xFF2F61D6);
  static const Color borderColor = Color(0XFFE2E8F0);
  static const Color labelColor = Color(0XFF8C8C8C);
  static const Color greyColor = Color(0XFF666666);
  static const Color lightGreyColor = Color(0XFFF7F8FA);
  static const Color activeColor = Color(0xfffcd6e9);
  static const Color activeText = Color(0xfffd496a);
  static const Color lightBlueColor = Color(0XFFF1F7FF);
  static const Color pendingbackground = Color(0xffffecda);
  static const Color approvedbackground = Color(0xffdeffe4);
  static const Color rejectbackground = Color(0xffffdddd);
  static const Color pendingtext = Color(0xffff6b00);
  static const Color approvedtext = Color(0xff1cc641);
  static const Color rejectText = Color(0xffff4635);
  static const Color profileHeading = Color(0XFF1A1A1A);
  static const Color helpdata = Color(0XFFF6F6F6);
  static const Color helpValue = Color(0XFF2F61D6);
  static const Color delBtn = Color(0XFFE33B3B);
  static const Color canceledit = Color(0XFFF2F2F2);

  static const Color badgeStatusColorRed = Color(0XFFFFE4D9);
  static const Color badgeStatusColorTextRed = Color(0XFFFD6020);
  static const Color badgeStatusColorBlue = Color(0XFFDEE6F8);
  static const Color badgeStatusColorTextBlue = Color(0XFF2F61D6);
  static const Color badgeStatusColorGreen = Color(0XFFDEFFE4);
  static const Color badgeStatusColorTextGreen = Color(0XFF00BE2A);
  static const Color badgeStatusColorGrey = Color(0XFFF7F8FA);

  static const Color badgeStatusColorTextGrey = Color(0XFFB5B7B9);
  static const Color hintTextColor = Color(0XFFB5B5B7);
  static const Color lightRedColor = Color(0XFFFFE9E9);
  static const Color cardStyleColor = Color(0XFF666666);
  static const Color cardStyleValueColor = Color(0XFF1A1A1A);
  static const Color darkRed = Color(0XFFFF0000);
  static const Color disabledButtonColor = Color(0xffb7caf3);
  static const Color pendingBgcolor = Color(0xffFFE4D9);
  static const Color pendingTextcolor = Color(0xffFD6020);
  static const Color rejectedBgcolor = Color(0xffFFDDDD);
  static const Color rejectedTextcolor = Color(0xffFF4635);
  static const Color approvedBgcolor = Color(0xffDEFFE4);
  static const Color approvedTextcolor = Color(0xff00BE2A);
  static const Color approveBtn = Color(0xff2AAC7E);
  static const Color changeBack = Color(0xffF0F4FF);
  static const Color changeColor = Color.fromARGB(255, 140, 137, 137);
  static const Color subHeading = Color(0XFF1A1A1A);
  static const Color verify = Color(0XFF333333);
  static const Color ticketlabel = Color(0XFF422B03);
  static const Color customName = Color(0XFF373737);
  static const Color participateName = Color(0XFF050038);
  static const Color starbuckscredet = Color(0XFF057143);
  static const Color dominoscredet = Color(0XFF017EB4);
  static const Color line = Color(0XFFC2832E);
  static const Color filterLabel = Color(0xff31373D);
  static const Color floatLabel = Color(0xff555E67);
  static const Color filter = Color(0xff333333);
  static const Color tickerLine = Color(0xffBEBCBD);
  static const Color winAmount = Color(0xffE4A72F);
  static const Color winName = Color(0xffC6C6C6);

  //Text
  static const String currencyAED = 'LKR';

  //Bar chart gradients
  static Gradient bargradient2 = const LinearGradient(
    colors: [Color(0xff4473e2), Color(0xff6f97f4), Color(0xff90b1fd)],
  );
  static Gradient bargradient1 = const LinearGradient(
    colors: [Color(0xff7e88f5), Color(0xff76a9f9), Color(0xffdfa9f9)],
  );

  // textstyles
  static TextStyle get pageheding {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: textheadingcolor,
    );
  }

  static TextStyle get dashcardnum {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: textheadingcolor,
    );
  }

  static TextStyle get buttonStyle {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: secondaryColor,
    );
  }
  static TextStyle get tranparentbuttonStyle {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.transparent,
    );
  }

  static TextStyle get winStyle {
    return TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w600,
      color: winAmount,
    );
  }
  static TextStyle get winNameStyle {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: winName,
    );
  }

  static TextStyle get forgotPassStyle {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: teritaryColor,
    );
  }

  static TextStyle get headStyle {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: buttonColor,
    );
  }

  static TextStyle get headingStyle {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }

  static TextStyle get smallSubheadingStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: greyColor,
    );
  }

  static TextStyle get smallSubheadingStyleBold {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: greyColor,
    );
  }
  static TextStyle get jackpotcard {
    return TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w400,
      color: subHeading,
    );
  }

  static TextStyle get smallblackheadingStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: blackColor,
    );
  }

  static TextStyle get smallblackheadingStylebold {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: blackColor,
    );
  }

  static TextStyle get tableHeader {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }
  static TextStyle get customerName {
    return TextStyle(
      fontSize: 9.1,
      fontWeight: FontWeight.w400,
      color: customName,
    );
  }

  static TextStyle get tableValues {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: blackColor,
    );
  }

  static TextStyle get smallblueheading {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: primaryBackground,
    );
  }

  static TextStyle get smallblueheadingUnderline {
    return TextStyle(
      fontSize: 12,
      decoration: TextDecoration.underline,
      decorationColor: badgeStatusColorTextBlue,
      decorationThickness: 2,
      fontWeight: FontWeight.w400,
      color: badgeStatusColorTextBlue,
    );
  }

  static TextStyle get bottomSheetSearchBar {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: hintTextColor,
    );
  }

  static TextStyle get bottomSheetSideBarStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }

  static TextStyle get bottomSheetHeader {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }

  static TextStyle get bottomSheetHintText {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: greyColor,
    );
  }

  static TextStyle get cardStyle {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: cardStyleColor,
    );
  }

  static TextStyle get cardStyleValues {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: cardStyleColor,
    );
  }

  static TextStyle get batchFontStyle {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: cardStyleColor,
    );
  }

  static TextStyle get subheadingStyle {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: blackColor,
    );
  }

  static TextStyle get clearfilter {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: helpValue,
    );
  }
  static TextStyle get results {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: helpValue,
    );
  }

  static TextStyle get clearfilterr {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: greyColor,
    );
  }

  static TextStyle get bigheadingStyle {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: secondaryColor,
    );
  }
  static TextStyle get confirmationheadingStyle {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: teritaryColor,
    );
  }

  static TextStyle get smallheadingStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryColor,
    );
  }

  static TextStyle get dialogBoxButtonStyle {
    return TextStyle(
      // fontSize: 24,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: teritaryColor,
    );
  }

  static TextStyle get headersColor {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: otherColor,
    );
  }

  static TextStyle get profileHeader {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textheadingcolor,
    );
  }

  static TextStyle get profileShopName {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: blackColor,
    );
  }

  static TextStyle get personalInfo {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textheadingcolor,
    );
  }

  static TextStyle get footerStyle {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: secondaryColor,
    );
  }

  static TextStyle get helpandSupport {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: profileHeading,
    );
  }

  static TextStyle get teambtns {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secondaryColor,
    );
  }

  static TextStyle get profilePicture {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: profileHeading,
    );
  }

  static TextStyle get hometab {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: profileHeading,
    );
  }
  static TextStyle get hometabContent {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: profileHeading,
    );
  }
  static TextStyle get blootab {
    return TextStyle(
      fontSize: 18.53,
      fontWeight: FontWeight.w500,
      color: profileHeading,
    );
  }

  static TextStyle get otpScreen {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }

  static TextStyle get greytextstyle {
    return TextStyle(color: profileHeading, fontWeight: FontWeight.w400,fontSize:14 );
  }

  static TextStyle get darkgreytextstyle {
    return TextStyle(
      color: greyColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get btbluetextstyle {
    return TextStyle(
      color: otherColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get personalHeading {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: blackColor,
    );
  }

  static TextStyle get rafflelabel {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: helpValue,
    );
  }

  static TextStyle get inputTextStyle {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: Colors.black,
    );
  }

  static TextStyle get raffleRecord {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle get raffleUpcoming {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: subHeading,
    );
  }
  static TextStyle get raffleUpcomingSub {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: subHeading,
    );
  }
  static TextStyle get floatinglabel {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: helpValue,
    );
  }
  static TextStyle get ticketstyle {
    return TextStyle(
      fontSize: 15.77,
      fontWeight: FontWeight.w600,
      color: ticketlabel,
    );
  }
  static TextStyle get participate {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: participateName,
    );
  }
  static TextStyle get creditsStar {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: starbuckscredet,
    );
  }
  static TextStyle get filterLabelStyle {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: filterLabel,
    );
  }
  static TextStyle get floatLabelStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: floatLabel,
    );
  }


}
