import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/payments/debit_advise_block/controller/debit_advise_block_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';

class DebitAdviseBlock extends StatelessWidget {
  const DebitAdviseBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ChangeNotifierProvider(
      create: (context) =>
          DebitAdviseBlockProvider()..debitAdviseBlockAccess(context: context),
      child: Consumer<DebitAdviseBlockProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BreadCrumbs(
                    title: 'Debit advise block',
                  ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    color: AppColor.drawerColor,
                                    Icons.arrow_back,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    isTablet ? size.width * 0.75 : size.width,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cardItem,
                                  border: Border.all(
                                      width: 1, color: AppColor.dividerColor),
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
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.drawerColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                      ),
                                      height: 45,
                                      child: Center(
                                        child: CustomText(
                                          text: 'BLOCK OR RELEASE DEBIT ADVISE',
                                          fontSize: isTablet ? 14 : 13,
                                          fontFamily: 'poppinsSemiBold',
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: isTablet ? 10 : 8.0,
                                          horizontal: isTablet ? 0 : 8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: AppColor.dividerColor
                                                  .withOpacity(0.4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  _buildResponsiveRadioGroup(
                                                    context: context,
                                                    options: [
                                                      {
                                                        'title': 'Block',
                                                        'value': '1'
                                                      },
                                                      {
                                                        'title': 'Release',
                                                        'value': '2'
                                                      },
                                                    ],
                                                    groupValue:
                                                        provider.selectedType,
                                                    onChanged: (value) {
                                                      provider
                                                          .updateSelectedType(
                                                              value, context);
                                                      // provider.resetSelection();
                                                    },
                                                    isTablet: isTablet,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            provider.branch.isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Select Branch',
                                                            fontSize: isTablet
                                                                ? 12
                                                                : 10,
                                                            fontFamily:
                                                                'poppinsRegular',
                                                            color: Colors.black,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 30,
                                                            width: size.width *
                                                                0.25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .dividerColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child:
                                                                DropdownButton2(
                                                              isExpanded: true,
                                                              dropdownStyleData:
                                                                  DropdownStyleData(
                                                                      maxHeight:
                                                                          300,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      )),
                                                              underline:
                                                                  const SizedBox(),
                                                              value: provider
                                                                      .selectedBranch!
                                                                      .isNotEmpty
                                                                  ? provider
                                                                      .selectedBranch
                                                                  : null,
                                                              dropdownSearchData:
                                                                  DropdownSearchData(
                                                                searchController:
                                                                    provider
                                                                        .branchController,
                                                                searchInnerWidgetHeight:
                                                                    50,
                                                                searchInnerWidget:
                                                                    Container(
                                                                  height: 50,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    expands:
                                                                        true,
                                                                    maxLines:
                                                                        null,
                                                                    controller:
                                                                        provider
                                                                            .branchController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            const BorderSide(color: Colors.black),
                                                                      ),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'search branch',
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              hint:
                                                                  const CustomText(
                                                                text:
                                                                    '----------SELECT BRANCH----------',
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'poppinsRegular',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              items: provider
                                                                  .branch
                                                                  .map((value) {
                                                                return DropdownMenuItem(
                                                                  value:
                                                                      "${value.bRID}",
                                                                  child:
                                                                      CustomText(
                                                                    text: value
                                                                            .bRANCH
                                                                            ?.toString() ??
                                                                        '',
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'poppinsRegular',
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                provider.setBranch(
                                                                    value:
                                                                        value);
                                                                provider.fetchTransaction(
                                                                    context:
                                                                        context,
                                                                    type: provider
                                                                        .selectedType,
                                                                    branchId:
                                                                        provider.selectedBranch ??
                                                                            '');
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Select branch',
                                                            fontSize: isTablet
                                                                ? 12
                                                                : 10,
                                                            fontFamily:
                                                                'poppinsRegular',
                                                            color: Colors.black,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 30,
                                                            width: size.width *
                                                                0.25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .dividerColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child: const Center(
                                                              child: CustomText(
                                                                text:
                                                                    '----------SELECT BRANCH----------',
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'poppinsRegular',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            provider.transList.isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Select Transaction',
                                                            fontSize: isTablet
                                                                ? 12
                                                                : 10,
                                                            fontFamily:
                                                                'poppinsRegular',
                                                            color: Colors.black,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: size.width *
                                                                0.35,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .dividerColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child:
                                                                DropdownButton2(
                                                              isExpanded: true,
                                                              dropdownStyleData:
                                                                  DropdownStyleData(
                                                                      maxHeight:
                                                                          300,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      )),
                                                              underline:
                                                                  const SizedBox(),
                                                              value: provider
                                                                      .selectedTrans!
                                                                      .isNotEmpty
                                                                  ? provider
                                                                      .selectedTrans
                                                                  : null,
                                                              dropdownSearchData:
                                                                  DropdownSearchData(
                                                                searchController:
                                                                    provider
                                                                        .transController,
                                                                searchInnerWidgetHeight:
                                                                    50,
                                                                searchInnerWidget:
                                                                    Container(
                                                                  height: 50,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    expands:
                                                                        true,
                                                                    maxLines:
                                                                        null,
                                                                    controller:
                                                                        provider
                                                                            .transController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        borderSide:
                                                                            const BorderSide(color: Colors.black),
                                                                      ),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'search transaction',
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              hint:
                                                                  const CustomText(
                                                                text:
                                                                    '----------SELECT TRANSACTION----------',
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'poppinsRegular',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              items: provider
                                                                  .transList
                                                                  .map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value
                                                                      .sEQNO,
                                                                  child:
                                                                      CustomText(
                                                                    text: value
                                                                            .tRANSACTIONS
                                                                            ?.toString() ??
                                                                        '',
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'poppinsRegular',
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                provider
                                                                    .setTransaction(
                                                                        value:
                                                                            value);
                                                                provider.changeTransaction(
                                                                    context:
                                                                        context,
                                                                    type: provider
                                                                        .selectedType,
                                                                    seqNum:
                                                                        provider.selectedTrans ??
                                                                            '');
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Select Transaction',
                                                            fontSize: isTablet
                                                                ? 12
                                                                : 10,
                                                            fontFamily:
                                                                'poppinsRegular',
                                                            color: Colors.black,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: size.width *
                                                                0.35,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .dividerColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child: const Center(
                                                              child: CustomText(
                                                                text:
                                                                    '----------SELECT TRANSACTION----------',
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'poppinsRegular',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            const SizedBox(height: 15),
                                            Center(
                                                child: SizedBox(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFDDDFDC),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColor
                                                          .dividerColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                width: isTablet
                                                    ? size.width * 0.7
                                                    : size.width * 0.9,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Document Id',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? provider.transDet.first.docId ?? ''
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Amount',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? "${provider.transDet.first.amount ?? ''}"
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Customer name',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? provider.transDet.first.custName ?? ''
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Transaction date',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? provider.transDet.first.valueDate!.split('T')[0] ?? ''
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Trans ref No',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? "${provider.transDet.first.corporateId ?? ''}"
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            'Transaction ID',
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text: provider.transDet.isNotEmpty
                                                                              ? provider.transDet.first.settlTransId ?? ''
                                                                              : "",
                                                                          fontSize: isTablet
                                                                              ? 12
                                                                              : 10,
                                                                          fontFamily:
                                                                              'poppinsRegular',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                            const SizedBox(height: 10),
                                            Center(
                                              child:
                                                  provider.custAccDetails
                                                          .isNotEmpty
                                                      ? SizedBox(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFDDDFDC),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .dividerColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            width: isTablet
                                                                ? size.width *
                                                                    0.7
                                                                : size.width *
                                                                    0.9,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColor
                                                                        .drawerColor,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                8.0),
                                                                        topRight:
                                                                            Radius.circular(8.0)),
                                                                  ),
                                                                  height: 35,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      CustomText(
                                                                        text:
                                                                            "Customer account details",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: 'Customer Name',
                                                                                    fontSize: isTablet ? 12 : 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  const SizedBox(height: 4),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColor.primaryColor,
                                                                                      border: Border.all(
                                                                                        width: 1,
                                                                                        color: AppColor.dividerColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: CustomText(
                                                                                      text: provider.custAccDetails.isNotEmpty ? provider.custAccDetails.first.cUSTNAME ?? '' : "",
                                                                                      fontSize: isTablet ? 12 : 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: 'Bank',
                                                                                    fontSize: isTablet ? 12 : 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  const SizedBox(height: 4),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColor.primaryColor,
                                                                                      border: Border.all(
                                                                                        width: 1,
                                                                                        color: AppColor.dividerColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: CustomText(
                                                                                      text: provider.custAccDetails.isNotEmpty ? "${provider.custAccDetails.first.bANKNAME ?? ''}" : "",
                                                                                      fontSize: isTablet ? 12 : 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        
                                                                        ],
                                                                      ),
                                                                      SizedBox(height:15),
                                                                      Row(
                                                                        children: [
                                                                        
                                                                          Expanded(
                                                                            child:
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: 'IFSC code',
                                                                                    fontSize: isTablet ? 12 : 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  const SizedBox(height: 4),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColor.primaryColor,
                                                                                      border: Border.all(
                                                                                        width: 1,
                                                                                        color: AppColor.dividerColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: CustomText(
                                                                                      text: provider.custAccDetails.isNotEmpty ? provider.custAccDetails.first.iFSCCODE ?? '' : "",
                                                                                      fontSize: isTablet ? 12 : 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: 'Beneficiary branch',
                                                                                    fontSize: isTablet ? 12 : 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  const SizedBox(height: 4),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColor.primaryColor,
                                                                                      border: Border.all(
                                                                                        width: 1,
                                                                                        color: AppColor.dividerColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: CustomText(
                                                                                      text: provider.custAccDetails.isNotEmpty ? provider.custAccDetails.first.bENEFICIARYBRANCH ?? '' : "",
                                                                                      fontSize: isTablet ? 12 : 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: 'Beneficiary account',
                                                                                    fontSize: isTablet ? 12 : 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  const SizedBox(height: 4),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColor.primaryColor,
                                                                                      border: Border.all(
                                                                                        width: 1,
                                                                                        color: AppColor.dividerColor,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    child: CustomText(
                                                                                      text: provider.custAccDetails.isNotEmpty ? provider.custAccDetails.first.bENEFICIARYACCOUNT ?? '' : "",
                                                                                      fontSize: isTablet ? 12 : 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                        text:
                                                            provider.selectedType ==
                                                                    '1'
                                                                ? 'Block'
                                                                : 'Release',
                                                        txtColor: Colors.white,
                                                        btnColor: AppColor
                                                            .drawerColor,
                                                        borderRadious: 8,
                                                        progress: provider
                                                                .isLoading
                                                            ? const SizedBox(
                                                                width: 10,
                                                                height: 10,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                ))
                                                            : null,
                                                        width: isTablet
                                                            ? 120
                                                            : 100,
                                                        height: 30,
                                                        onPressed: () {
                                                          if (provider.selectedBranch ==
                                                                  '-1' ||
                                                              provider
                                                                  .selectedBranch!
                                                                  .isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .errorTxt,
                                                                content:
                                                                    CustomText(
                                                                  text:
                                                                      'please select branch',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            );
                                                          } else if (provider
                                                                      .selectedTrans ==
                                                                  '-1' ||
                                                              provider
                                                                  .selectedTrans!
                                                                  .isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .errorTxt,
                                                                content:
                                                                    CustomText(
                                                                  text:
                                                                      'please select transaction',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            provider.btnSubmit(
                                                                context:
                                                                    context,
                                                                type: provider
                                                                    .selectedType,
                                                                seqNum: provider
                                                                        .selectedTrans ??
                                                                    '');
                                                          }
                                                        }),
                                                    const SizedBox(width: 10),
                                                    CustomButton(
                                                      text: 'Exit',
                                                      txtColor: Colors.white,
                                                      btnColor: provider
                                                              .hoverBtn
                                                          ? AppColor.card3Title
                                                          : AppColor.errorTxt,
                                                      width:
                                                          isTablet ? 120 : 100,
                                                      height: 30,
                                                      borderRadious: 8,
                                                      onHover: (isHovering) {
                                                        provider.mouseHover();
                                                      },
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
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

  Widget _buildResponsiveRadioGroup({
    required BuildContext context,
    required List<Map<String, String>> options,
    required String groupValue,
    required Function(String) onChanged,
    required bool isTablet,
  }) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Wrap(
      spacing: isTablet ? 20.0 : 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: options.map((option) {
        return SizedBox(
          width:
              isTablet ? (isLandscape ? 150 : 130) : (isLandscape ? 120 : 110),
          child: _customRadioTile(
            title: option['title']!,
            value: option['value']!,
            groupValue: groupValue,
            onChanged: (value) => onChanged(value!),
          ),
        );
      }).toList(),
    );
  }

  Widget _customRadioTile({
    required final String title,
    required final String value,
    required final String groupValue,
    required final ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          fillColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColor.hdTxtColor;
            }
            return AppColor.cardTitleSubColor;
          }),
          activeColor: AppColor.hdTxtColor,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: CustomText(
            text: title,
            fontSize: 12,
            fontFamily: 'poppinsRegular',
            color: AppColor.backBtn,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
