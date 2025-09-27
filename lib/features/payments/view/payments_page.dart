import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/component/widgets/item_card_widget.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/payments_controller.dart';
import '../model/payments_child_model.dart';

class PaymentsPage extends StatelessWidget {
  final String? mainMenuId;

  const PaymentsPage({super.key, this.mainMenuId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => PaymentsProvider()
        ..getSubMenu(context: context, mainMenuId: mainMenuId ?? '')
        ..getChildMenu(context: context, mainMenuId: mainMenuId ?? ''),
      child: Consumer<PaymentsProvider>(
        builder: (context, paymentsProvider, child) {
          return SizedBox(
            width: size.width,
            height: size.height,

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Bread crumbs
                  const BreadCrumbs(title: 'Payments'),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.55),
                        border:
                            Border.all(width: 1, color: AppColor.dividerColor),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          length: paymentsProvider.subMenu.length,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ///Search bar
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: AppColor.primaryColor),
                                    width: size.width * 0.30,
                                    height: 40,
                                    child: CustomTextField(
                                      labelTxt: 'Search',
                                      hintTxt: 'Enter text',
                                      controller:
                                          paymentsProvider.searchController,
                                      keyboardType: TextInputType.text,
                                      labelTxtStyle: const TextStyle(
                                        color: AppColor.txtFieldItemColor,
                                      ),
                                      hintTxtStyle: const TextStyle(
                                        color: AppColor.txtFieldItemColor,
                                      ),
                                      onChanged: (value) {
                                        paymentsProvider.searchItems(value);
                                      },
                                      validator: (value) => null,
                                      obscureText: false,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4F7BF).withOpacity(0.3),
                                  border: Border.all(
                                      width: 0.8, color: AppColor.dividerColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                height: 50,
                                padding: const EdgeInsets.all(5),
                                child: TabBar(
                                  onTap: (index) {
                                    paymentsProvider.setTabIndex(
                                        context: context,
                                        index: index,
                                        menuId: mainMenuId ?? '');
                                  },
                                  indicator: BoxDecoration(
                                    color: AppColor.drawerColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorColor: Colors.black,
                                  labelStyle: const TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'poppinsRegular',
                                    color: AppColor.txtColorTab,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  dividerColor: Colors.transparent,
                                  tabs: paymentsProvider.subMenu.map((e) {
                                    return Tab(
                                      text: e.sUBMENUNAME ?? '',
                                    );
                                  }).toList(),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: PaymentTabItem(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

///Tab bar items

class PaymentTabItem extends StatelessWidget {
  const PaymentTabItem({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<PaymentsProvider>(
      builder: (context, paymentProvider, child) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   paymentProvider.setTabIndex(0);
        // });
        final isMobile = size.width < 600;
        final isTablet = size.width >= 600 && size.width < 1024;
        final crossAxisCount = isMobile ? 1 : (isTablet ? 3 : 4);

        if (paymentProvider.isLoading) {
          return isMobile
              ? shimmerListView(itemCount: 6)
              : shimmerGridView(crossAxisCount: crossAxisCount, itemCount: 6);
        }

        if (paymentProvider.childMenu.isEmpty) {
          return const Center(
            child: CustomText(
              text: "No items found",
              color: AppColor.drawerColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return isMobile
            ? buildListView(
                paymentProvider.filteredItems,
              )
            : buildGridView(paymentProvider.filteredItems, crossAxisCount);
      },
    );
  }
}

Widget shimmerListView({required int itemCount}) {
  return ListView.builder(
    itemCount: itemCount,
    itemBuilder: (context, index) => const Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: ShimmerWidget(height: 100, width: double.infinity),
    ),
  );
}

Widget shimmerGridView({required int crossAxisCount, required int itemCount}) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 3.0,
    ),
    itemCount: itemCount,
    itemBuilder: (context, index) =>
        const ShimmerWidget(height: 100, width: double.infinity),
  );
}

Widget buildListView(List<PaymentsChildModel> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return SizedBox(
        width: double.infinity,
        height: 70,
        child: Consumer<PaymentsProvider>(
          builder: (context, paymentStatusProvider, child) {
            paymentStatusProvider.curIndex = index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MouseRegion(
                opaque: false,
                cursor: MouseCursor.defer,
                onEnter: (_) => paymentStatusProvider.onEnter(index),
                onExit: (_) => paymentStatusProvider.onExit(),
                onHover: (_) {
                  paymentStatusProvider.selectedIndex = index;
                },
                child: Transform.scale(
                  scale:
                      paymentStatusProvider.selectedIndex == index ? 1.0 : 0.96,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: paymentStatusProvider.curIndex ==
                                  paymentStatusProvider.selectedIndex
                              ? AppColor.cardTitleColor
                              : AppColor.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                          onTap: () {
                            context.go(item.lINK ?? '');
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                // border: Border.all(color: Colors.grey, width: 0.6),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 48.0,
                                      height: 48.0,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.orange,
                                            Colors.yellow
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Container(
                                            width: 24.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: SvgPicture.asset(
                                              item.iMAGEURL ?? '',
                                              color: Color(0xFF830D00),
                                              height: 18,
                                              width: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.cHILDMENUNAME ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'poppinsRegular',
                                                color: AppColor.backBtn,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget buildGridView(List<PaymentsChildModel> items, int crossAxisCount) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 3.0,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Consumer<PaymentsProvider>(
        builder: (context, paymentStatusProvider, child) {
          paymentStatusProvider.curIndex = index;
          return MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer,
            onEnter: (_) => paymentStatusProvider.onEnter(index),
            onExit: (_) => paymentStatusProvider.onExit(),
            onHover: (_) {
              paymentStatusProvider.selectedIndex = index;
            },
            child: Transform.scale(
              scale: paymentStatusProvider.selectedIndex == index ? 1.0 : 0.96,
              child: Animate(
                effects: [
                  FadeEffect(duration: 100.ms, curve: Curves.easeOut),
                  const ScaleEffect(
                      begin: Offset(0.8, 0.8), curve: Curves.easeIn)
                ],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: paymentStatusProvider.curIndex ==
                                  paymentStatusProvider.selectedIndex
                              ? AppColor.cardTitleColor
                              : AppColor.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                          onTap: () {
                            context.go(item.lINK ?? '');
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                // border: Border.all(color: Colors.grey, width: 0.6),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48.0,
                                      height: 48.0,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.orange,
                                            Colors.yellow
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: SvgPicture.asset(
                                            item.iMAGEURL ?? '',
                                            color: Color(0xFF830D00),
                                            height: 18,
                                            width: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            item.cHILDMENUNAME ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'poppinsRegular',
                                              color: AppColor.backBtn,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
