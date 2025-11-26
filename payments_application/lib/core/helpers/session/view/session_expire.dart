import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/config/styles/colors.dart';
import '../../../utils/shared/component/widgets/custom_button.dart';
import '../../../utils/shared/component/widgets/custom_text.dart';
import '../../../utils/shared/constant/assets_path.dart';
import '../../cache_helper/app_cache_helper.dart';
import '../controller/session_cookie_provider.dart';
import '../controller/session_provider.dart';

class SessionExpiredPage extends StatelessWidget {
  const SessionExpiredPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sessionProvider =
          Provider.of<SessionProvider>(context, listen: false);
      sessionProvider.clearSession();
      final appCacheHelper = AppCacheHelper();
      appCacheHelper.clearData('empCode');
      appCacheHelper.clearData('branchID');
      appCacheHelper.clearData('branchName');
    });

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPath.appBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: h * 0.60,
              width: w < 600 ? w * 0.65 : (w < 1024 ? w * 0.50 : w * 0.30),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColor.dividerColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor
                        .dividerColor, // Background color of the CircleAvatar
                    child: Icon(
                      Icons.warning_amber,
                      size: 25, // Size of the icon
                      color: AppColor.drawerColor, // Color of the icon
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: CustomText(
                      text: "Session Expired",
                      fontSize: 18,
                      fontFamily: 'poppinsSemiBold',
                      color: AppColor.drawerColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CustomText(
                      text:
                          "Your session has timed out due to inactivity. Please \nlog in again to continue.",
                      fontSize: 12,
                      fontFamily: 'poppinsRegular',
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      text: 'Login',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 60,
                      height: 25,
                      onPressed: () async {
                        const url =
                            'https://uatapp.manappuram.net/MaaPortal/login';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
