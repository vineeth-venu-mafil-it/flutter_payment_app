import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../controller/drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;

    return Consumer<DrawerProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff141356),
                          Color(0xff0095DA),
                        ],
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: provider.mainMenu.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final item = provider.mainMenu[index];
                        final isHovered = provider.hoveredIndex == index;

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 8.0),
                          child: buildDrawerOption(
                            text: item.mENUNAME ?? '',
                            isHovered: isHovered,
                            onTap: () {
                              final link = item.lINK ?? '';
                              final menuId = item.mENUID != null
                                  ? 'main_menu_id=${item.mENUID}'
                                  : '';
                              final fullLink =
                                  menuId.isNotEmpty ? '$link?$menuId' : link;
                              context.go(fullLink);
                            },
                            onHover: (isHovering) {
                              provider
                                  .setHoveredIndex(isHovering ? index : null);
                            },
                            isExpanded: provider.isDrawerExpanded,
                            provider: provider,
                            imgUrl: item.iMAGEURL ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                isTablet?Container(
                  width: 10,
                  height: size.height,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColor.appbarColor,
                        ),
                        child: Center(
                          child: CustomText(
                            text:"d",
                            fontSize: 12,
                            fontFamily: 'poppinsRegular',
                            color: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ):SizedBox.shrink()
              ],
            ),
            isTablet?Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xFF59A3D0)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      onTap: provider.toggleDrawerExpansion,
                      child: Icon(
                        provider.isDrawerExpanded
                            ? Icons.keyboard_arrow_left
                            : Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ):SizedBox.shrink()
          ],
        );
      },
    );
  }

  Widget buildDrawerOption({
    required String text,
    required String imgUrl,
    required bool isHovered,
    required VoidCallback onTap,
    required Function(bool) onHover,
    required bool isExpanded,
    required DrawerProvider provider,
  }) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      child: Container(
        decoration: BoxDecoration(
          color: isHovered
              ? Color(0xFFFFFFFF).withOpacity(0.42)
              : const Color(0xFF041034).withOpacity(0.42),
          borderRadius: BorderRadius.circular(6.0),
        ),
        height: 45,
        child: isExpanded
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: SvgPicture.asset(
                          imgUrl,
                          height: 18,
                          width: 18,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: text,
                              color: Colors.white,
                              fontFamily: 'poppinsRegular',
                              fontSize: 11,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetsPath.arrowBack,
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  width: 30,
                  child: Center(
                    child: SvgPicture.asset(
                      imgUrl,
                      height: 18,
                      width: 18,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
