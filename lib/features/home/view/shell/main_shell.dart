import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/helpers/routes/app_route_name.dart';
import 'package:payments_application/core/helpers/routes/app_route_path.dart';
import 'package:payments_application/core/helpers/session/controller/session_cookie_provider.dart';
import 'package:payments_application/core/utils/shared/component/widgets/custom_alert_box.dart';
import 'package:payments_application/features/drawer/view/drawer_widget.dart';
import 'package:payments_application/features/payments/controller/payments_controller.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/internet_connectivity/controller/internet_connectivity_provider.dart';
import '../../../../core/helpers/session/controller/session_controller.dart';
import '../../../../core/utils/config/styles/colors.dart';
import '../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../core/utils/shared/constant/assets_path.dart';
import '../../../drawer/controller/drawer_controller.dart';
import '../../controller/home_controller.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    final appBarHeight = size.height * 0.073;
    final sessionManager = Provider.of<SessionManager>(context);

    // Check session status
    if (!sessionManager.sessionActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sessionManager.endSession().then((_) {
          context.go(RoutesPath.session_expires);
        });
      });
      return Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPath.appBackground),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Check connectivity status
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    if (!connectivityProvider.isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomAlertDialog.showCustomAlertDialog(
          context: context,
          title: "No Internet Connection",
          message: "Please check your internet settings.",
          onCancelPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
            context.go(RoutesPath.connectivity_page);
          },
        );
      });
      return const SizedBox
          .shrink(); // Early return to avoid building the Scaffold
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(child: DrawerWidget()),
      body: Row(
        children: [
          if (isTablet) ...[
            Consumer<SliderProvider>(
              builder: (context, sliderController, child) {
                final drawerWidth = sliderController.isDrawerExpanded
                    ? size.width * 0.17
                    : size.width * 0.05;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: drawerWidth,
                  child: const DrawerWidget(),
                );
              },
            )
          ],
          Expanded(
            child: Column(
              children: [
                _buildAppBar(scaffoldKey, isTablet, context),
                Expanded(child: child),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(GlobalKey<ScaffoldState> scaffoldKey, bool isTablet,
      BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.appbarColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.dividerColor,
            width: 1.0,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.073,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          if (!isTablet)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColor.appBarColor),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
          if (isTablet)
            Consumer<SliderProvider>(
              builder: (context, sliderController, child) {
                return IconButton(
                  icon: Icon(
                    sliderController.isDrawerExpanded
                        ? Icons.menu_open
                        : Icons.menu,
                    color: AppColor.card7Title,
                  ),
                  onPressed: sliderController.toggleDrawerExpansion,
                );
              },
            ),
          const SizedBox(width: 8),
          const CustomText(
            text: "Payments Application",
            fontSize: 18,
            fontFamily: 'poppinsSemiBold',
            color: AppColor.card7Title,
          ),
          Expanded(child: _buildUserDetails()),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 20,
          height: 20,
          child: CircleAvatar(
            backgroundColor: AppColor.card3Title,
            child: const Icon(
              Icons.person,
              size: 16,
              color: AppColor.card2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) => CustomText(
              overflow: TextOverflow.ellipsis,
              text: homeProvider.empDetailModel.response?.first.eMPNAME ?? '',
              fontSize: 12,
              fontFamily: 'poppinsRegular',
              color: AppColor.cardTitleColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.appbarColor,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Center(
          child: CustomText(
            text:
                "© 2023 - Designed & Developed by Team Modernization, IT S/W Manappuram | www.manappuram.com",
            fontSize: 12,
            fontFamily: 'poppinsRegular',
            color: AppColor.card7Title,
          ),
        ),
      ),
    );
  }
}
