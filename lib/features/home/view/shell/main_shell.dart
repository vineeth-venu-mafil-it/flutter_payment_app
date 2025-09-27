import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/routes/app_route_path.dart';
import '../../../../core/utils/config/styles/colors.dart';
import '../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../core/utils/shared/constant/assets_path.dart';
import '../../../drawer/controller/drawer_controller.dart';
import '../../../drawer/view/drawer_widget.dart';
import '../../controller/home_controller.dart';

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false)
          .employeeDetails(context: context);
      Provider.of<DrawerProvider>(context, listen: false)
          .getMainMenu(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;

    return Scaffold(
      key: drawerKey,
      drawer: isTablet ? null : Drawer(child: DrawerWidget()),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, isTablet),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.appBackground),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.2),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isTablet) _buildTabletDrawer(context),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: widget.child,
                          ),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletDrawer(BuildContext context) {
    return Consumer<DrawerProvider>(
      builder: (context, sliderController, child) {
        final size = MediaQuery.of(context).size;
        final drawerWidth = sliderController.isDrawerExpanded
            ? size.width * 0.17
            : size.width * 0.05;

        return Material(
          elevation: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: drawerWidth,
            height: double.infinity,
            child: DrawerWidget(),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, bool isTablet) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : AppColor.appbarColor,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? Colors.grey[800]! : AppColor.dividerColor,
            width: 1.0,
          ),
        ),
      ),
      height: 56,
      child: Row(
        children: [
          // Logo
          isTablet?SizedBox(
            width: MediaQuery.of(context).size.width * 0.17,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/images/app_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ):SizedBox.shrink(),

          const SizedBox(width: 8),

          Row(
            children: [
              if (!isTablet)
                IconButton(
                  icon: Icon(Icons.menu, color: Color(0xFF830D00)),
                  onPressed: () => drawerKey.currentState?.openDrawer(),
                  splashRadius: 20,
                ),

              isTablet?ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF1C1B1F), Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    'Payment Application',
                    style: TextStyle(
                      fontFamily: 'poppinsRegular',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ):SizedBox.shrink()
            ],
          ),

          // Branch Name
          isTablet?Expanded(
            child: Consumer<DrawerProvider>(
              builder: (context, sliderController, child) {
                sliderController.setCurBranchName();
                return Center(
                  child: CustomText(
                    text:
                        "MANAPPURAM FINANCE LIMITED :- ${sliderController.branchName}",
                    fontSize: 12,
                    fontFamily: 'poppinsRegular',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF1818),
                  ),
                );
              },
            ),
          ):Expanded(child: SizedBox()),

          // User Details
          _buildUserDetails(),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        final empName =
            homeProvider.empDetailModel.response?.first.eMPNAME ?? '';
        final initials = empName.isNotEmpty ? empName[0] : '';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor,
                  border: Border.all(
                    color: AppColor.dividerColor,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Container(
                              height: 32,
                              color: Colors.red,
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              height: 32,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: CustomText(
                          text: initials,
                          fontSize: 12,
                          fontFamily: 'poppinsSemiBold',
                          fontWeight: FontWeight.w600,
                          color: AppColor.cardTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CustomText(
                text: empName,
                fontSize: 12,
                fontFamily: 'poppinsRegular',
                fontWeight: FontWeight.w600,
                color: AppColor.cardTitleColor,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.appbarColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: const Center(
        child: CustomText(
          text:
              "© 2025 - Designed & Developed by Team Modernization, IT S/W Manappuram | www.manappuram.com",
          fontSize: 12,
          fontFamily: 'poppinsRegular',
          color: AppColor.card7Title,
        ),
      ),
    );
  }
}
