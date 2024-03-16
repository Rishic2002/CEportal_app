import 'package:ceportal/Utils/constants.dart';
import 'package:ceportal/Utils/functions.dart';
import 'package:ceportal/Utils/theme_helper.dart';
import 'package:ceportal/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:url_launcher/url_launcher.dart';

class Essentials {
  static double commonPadding = 10;
  static double sSize = 14;
  static double rSize = 16;
  static double nSize = 15;
  static double mSize = 18;

  static double lSize = 20;
  static double mHeader = 22;
  static double bHeader = 25;

  static const yellowColor = Color.fromARGB(255, 244, 176, 28);
  static const Color primaryColor = Color(0xff57c75f);
  static const Color pinkColor = Color(0xffDF43A3);

  static networkPlaceHolder() {
    return (_, __) {
      return Center(child: getProgressBar(size: 15));
    };
  }

  static errorPlaceHolder() {
    return (_, __, ___) {
      return const SizedBox.shrink();
    };
  }

  static PreferredSizeWidget myAppBar(BuildContext context, String? title,
      {List<Widget>? actions,
      bool showLogo = false,
      bool backButton = true,
      Color appbarcolor = Colors.transparent,
      Color Textcolor = Colors.white,
      Color Iconcolor = Colors.white,
      bool applyGradient = true,
      FontWeight fontWeight = FontWeight.bold,
      bool showText = true,
      Widget? bottomsheetwidget,
      bool isHeader = false,
      Widget? mywidget,
      Widget? leading,
      bool centertitle = false,
      bool showChatButton = false,
      bool showSearchButton = false}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: applyGradient
            ? BoxDecoration(
                gradient: PrimaryColors().mainGradient,
              )
            : BoxDecoration(
                color: appbarcolor,
              ),
        child: AppBar(
          centerTitle: centertitle,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              if (backButton)
                Container(
                  height: 32,
                  width: 32,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 23,
                        color: Iconcolor,
                      ),
                    ),
                  ),
                ),
              if (backButton) Essentials.widthSpacer(8),
              if (showLogo)
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const Team(),
                    //   ),
                    // );
                  },
                  child: Image.asset(ImageConstant.clubLogo,
                      height: 40, width: 40),
                ),
              if (showLogo) Essentials.widthSpacer(8),
              if (showText)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: myText(
                    title ?? '',
                    context: context,
                    fontSize: Essentials.lSize,
                    isHeader: isHeader,
                    textColor: Textcolor,
                    fontWeight: fontWeight,
                  ),
                )
            ],
          ),
          actions: [
            if (mywidget != null) mywidget,
            if (showChatButton)
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const MessageScreen(),
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Iconcolor,
                    size: 30.0,
                  ),
                ),
              ),
            if (showSearchButton)
              GestureDetector(
                onTap: () {
                  Essentials.showCustomBottomSheet(
                      context: context,
                      child: SizedBox(child: bottomsheetwidget));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Iconcolor,
                    size: 30.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // static Widget myOptionList(context, List<PopupMenuEntry> menuTiles,
  //     {String? headerText, double? iconSize, double? margin}) {
  //   return Container(
  //       margin: EdgeInsets.all(margin ?? 12),
  //       child: myRoundIconBtn(
  //           context: context,
  //           icon: Icons.more_horiz_sharp,
  //           iconColor: Colors.black54,
  //           color: Colors.transparent,
  //           iconSize: iconSize ?? 26,
  //           onPress: () {
  //             showModalBottomSheet(
  //                 context: context,
  //                 builder: (context) {
  //                   Widget headerWidget = myText(headerText ?? '',
  //                       context: context,
  //                       textAlign: TextAlign.center,
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: Essentials.lSize);
  //                   return Container(
  //                     child: ListView(
  //                       shrinkWrap: true,
  //                       children: [
  //                         heightSpacer(10),
  //                         ...[
  //                           heightSpacer(10),
  //                           headerWidget,
  //                           heightSpacer(10),
  //                         ],
  //                         ...menuTiles,
  //                         myButton(
  //                             context: context,
  //                             textColor: myColors.themeText(context),
  //                             bgColor: myColors.themeBlueGrey(context),
  //                             label: "Close",
  //                             onPressed: () {
  //                               Navigator.of(context).pop();
  //                             })
  //                       ],
  //                     ),
  //                   );
  //                 });
  //           }));
  // }

  // static showOptionsBottomSheet(context, List<PopupMenuEntry> menuTiles,
  //     {String? headerText}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         Widget headerWidget = myText(headerText ?? '',
  //             context: context,
  //             textAlign: TextAlign.center,
  //             fontWeight: FontWeight.w700,
  //             fontSize: Essentials.lSize);
  //         return Container(
  //           child: ListView(
  //             shrinkWrap: true,
  //             children: [
  //               heightSpacer(10),
  //               ...[
  //                 heightSpacer(10),
  //                 headerWidget,
  //                 heightSpacer(10),
  //               ],
  //               ...menuTiles,
  //               myButton(
  //                   context: context,
  //                   textColor: myColors.themeText(context),
  //                   bgColor: myColors.themeBlueGrey(context),
  //                   label: "Close",
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   })
  //             ],
  //           ),
  //         );
  //       });
  // }

  static Widget divider({double size = 3, double margin = 12}) {
    return Container(
      margin: EdgeInsets.all(margin),
      color: Colors.grey,
      height: size,
    );
  }

  static Widget getProgressBar({double size = 50}) {
    return Center(
      child: SpinKitThreeBounce(
        color: primaryColor,
        size: size,
      ),
    );
  }

  static looseFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static SizedBox heightSpacer(double height) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox widthSpacer(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget myCustomButton(
      {required BuildContext context,
      required String text,
      double width = 100,
      double textPadding = 8,
      double circleRadius = 4,
      Color color = Colors.white,
      VoidCallback? onTap,
      double? fontSize}) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(circleRadius),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: PrimaryColors().blue,
            // gradient: PrimaryColors().mainGradient,
            borderRadius: BorderRadius.circular(circleRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(textPadding),
            child: Center(
              child: myText(text,
                  context: context, fontSize: fontSize, textColor: color),
            ),
          ),
        ),
      ),
    );
  }

  static BoxDecoration shadowDecoration({
    // Border? myborder,
    // BorderRadius? myborderradius,
    double opacity = 0.05,
    Color color = Colors.grey,
  }) {
    return BoxDecoration(
      // color: color,
      // border: myborder,
      // borderRadius: myborderradius,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(opacity),
          spreadRadius: 5,
          blurRadius: 9,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static BoxDecoration chatScreenDecor({
    Border? myborder,
    BorderRadius? myborderradius,
    double opacity = 0.3,
    Color color = Colors.grey,
    Color boxshadowcolor = Colors.grey,
  }) {
    return BoxDecoration(
      color: color,
      border: myborder,
      borderRadius: myborderradius,
      boxShadow: [
        BoxShadow(
          color: boxshadowcolor.withOpacity(opacity),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static BoxDecoration cardShadowDecoration( //used for the home cards

      {
    double opacity = 0.1,
    Color color = Colors.grey,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(opacity),
          spreadRadius: 6,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
      color: PrimaryColors().white,
    );
  }

  // static showMyModalBottomSheet(
  //     {required BuildContext context, required WidgetBuilder builder}) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: builder,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(12),
  //         topRight: Radius.circular(12),
  //       ),
  //     ),
  //   );
  // }

  // static showMyOptionsSheet(
  //     {required BuildContext context,
  //     required List<Map<String, dynamic>> options,
  //     required Function callback,
  //     String? header}) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (ctx) => MyOptionsSheet(
  //       options: options,
  //       headerText: header,
  //     ),
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(12),
  //         topRight: Radius.circular(12),
  //       ),
  //     ),
  //   ).then((value) {
  //     if (value != null && value is String) {
  //       callback(value);
  //     }
  //   });
  // }

  static launchURL({required BuildContext context, required String url}) async {
    Uri uri = Uri.parse(url);
    await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : CustomSnackBar()
            .basicSnackbar(context, 'Error occurred while launching ths url');
  }

  static showCustomBottomSheet(
      {required BuildContext context, required Widget child}) {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        backgroundColor: PrimaryColors().white,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return child;
        });
  }
}
