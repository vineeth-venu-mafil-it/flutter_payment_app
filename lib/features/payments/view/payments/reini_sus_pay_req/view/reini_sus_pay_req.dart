import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payment_app/features/payments/view/payments/reini_sus_pay_req/controller/reini_sus_pay_req_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/js.dart';

import '../../../../../../core/utils/config/styles/colors.dart';

import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../../../../../home/model/branch_model.dart';
import '../model/transaction_model.dart';

class ReiniSusPayReq extends StatelessWidget {
  const ReiniSusPayReq({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return ChangeNotifierProvider(
      create: (context) => ReiniSusPayReqProvider()..setData(context: context),
      child: Consumer<ReiniSusPayReqProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BreadCrumbs(
                    title: 'Re initiate successful payment request',
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
                                          text:
                                              'Reinitiate successful payment request',
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
                                                      'title': 'Search',
                                                      'value': '1'
                                                    },
                                                    {
                                                      'title': 'Select',
                                                      'value': '2'
                                                    },
                                                  ],
                                                  groupValue:
                                                      provider.selectedType,
                                                  onChanged: (value) {
                                                    provider.updateSelectedType(
                                                        value, context);
                                                    provider.resetSelection();
                                                  },
                                                  isTablet: isTablet,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
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
                                                      'title': 'IMPS',
                                                      'value': '1'
                                                    },
                                                    {
                                                      'title': 'SFTP',
                                                      'value': '2'
                                                    },
                                                  ],
                                                  groupValue:
                                                      provider.selectedPayMode,
                                                  onChanged: (value) {
                                                    provider
                                                        .updateSelectedPayMode(
                                                            value, context);
                                                    provider.resetSelection();
                                                  },
                                                  isTablet: isTablet,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          provider.selectedType == '1'
                                              ? SizedBox(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        color: AppColor
                                                            .dividerColor
                                                            .withOpacity(0.4),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            _buildResponsiveRadioGroup(
                                                              context: context,
                                                              options: [
                                                                {
                                                                  'title':
                                                                      'Document Id',
                                                                  'value': '1'
                                                                },
                                                                {
                                                                  'title':
                                                                      'Customer Id',
                                                                  'value': '2'
                                                                },
                                                                {
                                                                  'title':
                                                                      'Corporate Id',
                                                                  'value': '3'
                                                                },
                                                                {
                                                                  'title':
                                                                      'RRN/UTR No',
                                                                  'value': '4'
                                                                },
                                                              ],
                                                              groupValue: provider
                                                                  .selectedDocType,
                                                              onChanged:
                                                                  (value) {
                                                                provider
                                                                    .updateSelectedDocType(
                                                                        value);
                                                                provider
                                                                    .resetSelection();
                                                              },
                                                              isTablet:
                                                                  isTablet,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      _buildSearchRow(
                                                          context,
                                                          provider,
                                                          isTablet,
                                                          size),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          provider.selectedType == "2"
                                              ? Center(
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
                                                                          "Select date",
                                                                      fontSize:
                                                                          isTablet
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
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
                                                                        border: Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColor.dividerColor),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              DateTime? pickedDate = await showDatePicker(
                                                                                context: context,
                                                                                initialDate: DateTime.now(),
                                                                                firstDate: DateTime(1900),
                                                                                lastDate: DateTime.now(),
                                                                              );

                                                                              if (pickedDate != null) {
                                                                                String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
                                                                                provider.updateDate(date: formattedDate);
                                                                              }
                                                                            },
                                                                            icon: const Icon(Icons.calendar_today,
                                                                                color: AppColor.drawerColor,
                                                                                size: 15),
                                                                          ),
                                                                          Expanded(
                                                                              child: Center(
                                                                            child:
                                                                                CustomText(
                                                                              text: provider.curDate,
                                                                              fontSize: isTablet ? 12 : 10,
                                                                              fontFamily: 'poppinsRegular',
                                                                              color: Colors.black,
                                                                            ),
                                                                          ))
                                                                        ],
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
                                                                          "Select bank",
                                                                      fontSize:
                                                                          isTablet
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
                                                                    provider.bankList
                                                                            .isNotEmpty
                                                                        ? Container(
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(width: 1, color: AppColor.dividerColor),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                DropdownButton2<String>(
                                                                              isExpanded: true,
                                                                              dropdownStyleData: DropdownStyleData(
                                                                                maxHeight: 300,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                              underline: const SizedBox(),
                                                                              value: provider.selectedBank!.isNotEmpty ? provider.selectedBank : null,
                                                                              dropdownSearchData: DropdownSearchData(
                                                                                searchController: provider.bankController,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height: 50,
                                                                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                                                  child: TextFormField(
                                                                                    expands: true,
                                                                                    maxLines: null,
                                                                                    controller: provider.bankController,
                                                                                    decoration: InputDecoration(
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: Colors.black),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'search bank',
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              hint: const CustomText(
                                                                                text: '----------SELECT BANK----------',
                                                                                fontSize: 12,
                                                                                fontFamily: 'poppinsRegular',
                                                                                color: Colors.black,
                                                                              ),
                                                                              items: provider.bankList.map((value) {
                                                                                return DropdownMenuItem(
                                                                                  value: "${value.bANKCODE}",
                                                                                  child: CustomText(
                                                                                    text: value.bANKNAME?.toString() ?? '',
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (value) {
                                                                                if (value != null) {
                                                                                  if (provider.curDate == 'Select date') {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        backgroundColor: Colors.red,
                                                                                        content: CustomText(
                                                                                          text: "Please select date",
                                                                                          fontSize: 12,
                                                                                          fontFamily: 'poppinsRegular',
                                                                                          color: AppColor.primaryColor,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    provider.setBank(value: value);
                                                                                    String bankId = provider.selectedBank!.split('.').first;
                                                                                    provider.fetchBranch(
                                                                                      context: context,
                                                                                      frmDate: provider.curDate,
                                                                                      bankId: bankId,
                                                                                      payMode: provider.selectedPayMode,
                                                                                    );
                                                                                  }
                                                                                }
                                                                              },
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child:
                                                                                Container(
                                                                              height: 30,
                                                                              decoration: BoxDecoration(
                                                                                color: AppColor.primaryColor,
                                                                                border: Border.all(width: 1, color: AppColor.dividerColor),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: CustomText(
                                                                                text: '----------SELECT BANK----------',
                                                                                fontSize: 12,
                                                                                fontFamily: 'poppinsRegular',
                                                                                color: Colors.black,
                                                                              ),
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
                                                                          "Select branch",
                                                                      fontSize:
                                                                          isTablet
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
                                                                    provider.branchList
                                                                            .isNotEmpty
                                                                        ? Container(
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(width: 1, color: AppColor.dividerColor),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                DropdownButton2(
                                                                              isExpanded: true,
                                                                              dropdownStyleData: DropdownStyleData(
                                                                                maxHeight: 300,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                              underline: const SizedBox(),
                                                                              value: provider.selectedBranch!.isNotEmpty ? provider.selectedBranch : null,
                                                                              dropdownSearchData: DropdownSearchData(
                                                                                searchController: provider.branchController,
                                                                                searchInnerWidgetHeight: 50,
                                                                                searchInnerWidget: Container(
                                                                                  height: 50,
                                                                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                                                  child: TextFormField(
                                                                                    expands: true,
                                                                                    maxLines: null,
                                                                                    controller: provider.branchController,
                                                                                    decoration: InputDecoration(
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        borderSide: const BorderSide(color: Colors.black),
                                                                                      ),
                                                                                      isDense: true,
                                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10,
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      hintText: 'search branch',
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              hint: const CustomText(
                                                                                text: '----------SELECT BRANCH----------',
                                                                                fontSize: 12,
                                                                                fontFamily: 'poppinsRegular',
                                                                                color: Colors.black,
                                                                              ),
                                                                              items: provider.branchList.map((value) {
                                                                                return DropdownMenuItem(
                                                                                  value: "${value.bRANCHID}",
                                                                                  child: CustomText(
                                                                                    text: value.bRANCHNAME?.toString() ?? '',
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (value) {
                                                                                if (value != null) {
                                                                                  provider.setBranch(value: value);
                                                                                  provider.fetchTransDrop(
                                                                                    context: context,
                                                                                  );
                                                                                }
                                                                              },
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child:
                                                                                Container(
                                                                              height: 30,
                                                                              decoration: BoxDecoration(
                                                                                color: AppColor.primaryColor,
                                                                                border: Border.all(width: 1, color: AppColor.dividerColor),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: Center(
                                                                                child: CustomText(
                                                                                  text: '----------SELECT BRANCH----------',
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'poppinsRegular',
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          provider.transList.isNotEmpty
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width:
                                                              size.width * 0.35,
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
                                                                          BorderRadius.circular(
                                                                              8.0),
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
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        8),
                                                                child:
                                                                    TextFormField(
                                                                  expands: true,
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
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.black),
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
                                                                          BorderRadius.circular(
                                                                              8),
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            items: provider
                                                                .transList
                                                                .map((value) {
                                                              return DropdownMenuItem(
                                                                value:
                                                                    value.sEQNO,
                                                                child:
                                                                    CustomText(
                                                                  text: value
                                                                          .tRANSACTIONS
                                                                          ?.toString() ??
                                                                      '',
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              provider
                                                                  .setTransaction(
                                                                      value:
                                                                          value);

                                                              provider.changeTransaction(
                                                                  context:
                                                                      context,
                                                                  transNum:
                                                                      "${provider.selectedTrans}",
                                                                  payMode: provider
                                                                      .selectedPayMode);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width:
                                                              size.width * 0.25,
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
                                                              color:
                                                                  Colors.black,
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
                                                    color:
                                                        AppColor.dividerColor),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text: provider.transDetails.isNotEmpty
                                                                            ? provider.transDetails.first.dOCID ??
                                                                                ''
                                                                            : "",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text: provider.transDetails.isNotEmpty
                                                                            ? "${provider.transDetails.first.aMOUNT ?? ''}"
                                                                            : "",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text: provider.transDetails.isNotEmpty
                                                                            ? provider.transDetails.first.cUSTNAME ??
                                                                                ''
                                                                            : "",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text: provider.transDetails.isNotEmpty
                                                                            ? provider.transDetails.first.vALUEDATE?.split('T')[0] ??
                                                                                ''
                                                                            : "",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text: provider.transDetails.isNotEmpty
                                                                            ? "${provider.transDetails.first.cORPORATEID ?? ''}"
                                                                            : "",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                                      fontSize:
                                                                          isTablet
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
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColor
                                                                            .primaryColor,
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
                                                                        text:
                                                                            "${provider.transDetails.isNotEmpty ? provider.transDetails.first.sETTLTRANSID ?? '' : ""}",
                                                                        fontSize: isTablet
                                                                            ? 12
                                                                            : 10,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color: Colors
                                                                            .black,
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
                                                provider.custDetails.isNotEmpty
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
                                                              ? size.width * 0.7
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
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0)),
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
                                                                      fontSize:
                                                                          isTablet
                                                                              ? 12
                                                                              : 10,
                                                                      fontFamily:
                                                                          'poppinsRegular',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
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
                                                                                    text: provider.custDetails.isNotEmpty ? provider.custDetails.first.cUSTNAME ?? '' : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
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
                                                                                    text: provider.custDetails.isNotEmpty ? "${provider.custDetails.first.bANKNAME ?? ''}" : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
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
                                                                                    text: provider.custDetails.isNotEmpty ? provider.custDetails.first.iFSCCODE ?? '' : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
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
                                                                                    text: provider.custDetails.isNotEmpty ? provider.custDetails.first.bENEFICIARYBRANCH ?? '' : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
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
                                                                                    text: provider.custDetails.isNotEmpty ? provider.custDetails.first.bENEFICIARYACCOUNT ?? '' : "",
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
                                          const SizedBox(height: 15),
                                          Center(
                                            child:
                                                provider.transStatus.isNotEmpty
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
                                                              ? size.width * 0.7
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
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0)),
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
                                                                          "Transaction status",
                                                                      fontSize:
                                                                          isTablet
                                                                              ? 12
                                                                              : 10,
                                                                      fontFamily:
                                                                          'poppinsRegular',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CustomText(
                                                                                  text: 'TransactionRefNo',
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
                                                                                    text: provider.transStatus.isNotEmpty ? provider.transStatus.first.tRANREFNO ?? '' : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CustomText(
                                                                                  text: 'Response',
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
                                                                                    text: provider.transStatus.isNotEmpty ? "${provider.transStatus.first.rESPONSE ?? ''}" : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CustomText(
                                                                                  text: 'Bank RRN',
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
                                                                                    text: provider.transStatus.isNotEmpty ? provider.transStatus.first.bANKRRN ?? '' : "",
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
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CustomText(
                                                                                  text: 'Tra_date',
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
                                                                                    text: provider.transStatus.isNotEmpty ? provider.transStatus.first.tRADT ?? '' : "",
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox.shrink(),
                                          ),
                                          const SizedBox(height: 15),
                                          Center(
                                            child:
                                                (provider.selectedType == '2' &&
                                                        provider.payBank ==
                                                            '1' &&
                                                        provider.iciciBank
                                                            .isNotEmpty)
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
                                                              ? size.width * 0.7
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
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0)),
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
                                                                          "ICICI Bank IMPS Transaction Inquiry Status",
                                                                      fontSize:
                                                                          isTablet
                                                                              ? 12
                                                                              : 10,
                                                                      fontFamily:
                                                                          'poppinsRegular',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Center(
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child:
                                                                      Container(
                                                                    height: 250,
                                                                    width: size
                                                                            .width *
                                                                        0.60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              const Color(0xFFCCC6C6)),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        cardTheme:
                                                                            CardTheme(
                                                                          elevation:
                                                                              0,
                                                                          margin:
                                                                              EdgeInsets.zero,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          PaginatedDataTable2(
                                                                        headingRowHeight:
                                                                            35.0,
                                                                        dataRowHeight:
                                                                            40.0,
                                                                        horizontalMargin:
                                                                            16,
                                                                        columnSpacing:
                                                                            16,
                                                                        minWidth:
                                                                            size.width,
                                                                        wrapInCard:
                                                                            false,
                                                                        headingRowColor:
                                                                            WidgetStateProperty.all(
                                                                          AppColor
                                                                              .drawerColor,
                                                                        ),
                                                                        headingTextStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                        dataTextStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey[800],
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                        dividerThickness:
                                                                            0.5,
                                                                        rowsPerPage:
                                                                            provider.rowsPerPage,
                                                                        availableRowsPerPage: const [
                                                                          10,
                                                                          20,
                                                                          50
                                                                        ],
                                                                        onRowsPerPageChanged:
                                                                            (value) {
                                                                          provider.updateRowsPage(
                                                                              data: value!);
                                                                        },
                                                                        showFirstLastButtons:
                                                                            true,
                                                                        showCheckboxColumn:
                                                                            false,
                                                                        columns: [
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('ActCode', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('Response', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BankRRN', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('TranRefNo', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('PaymentRef', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('TranDateTime', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('Amount', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BeneMMID', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BeneMobile', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BeneAccNo', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BeneIFSC', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                          DataColumn2(
                                                                            label:
                                                                                Center(
                                                                              child: Text('BeneName', style: _tableRowHead),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                        source: PostDataSource(
                                                                            provider.iciciBank,
                                                                            provider,
                                                                            context),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomButton(
                                                    text: 'Request',
                                                    fontSize:
                                                        isTablet ? 14 : 12,
                                                    txtColor: Colors.white,
                                                    btnColor:
                                                        AppColor.card3Title,
                                                    width: isTablet ? 100 : 80,
                                                    height: 30,
                                                    borderRadious: 8,
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(width: 8),
                                                  CustomButton(
                                                    text: 'Exit',
                                                    fontSize:
                                                        isTablet ? 14 : 12,
                                                    txtColor: Colors.white,
                                                    btnColor:
                                                        AppColor.card3Title,
                                                    width: isTablet ? 100 : 80,
                                                    height: 30,
                                                    borderRadious: 8,
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
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

  Widget _buildDetailRow(
      {required List<String> labels, required bool isTablet}) {
    return Row(
      children: labels.map((label) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: isTablet ? 12 : 10,
                  fontFamily: 'poppinsRegular',
                  color: Colors.black,
                ),
                const SizedBox(height: 4),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    border: Border.all(width: 1, color: AppColor.dividerColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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

  Widget _buildSearchRow(BuildContext context, ReiniSusPayReqProvider provider,
      bool isTablet, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? size.width * 0.3 : size.width * 0.8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomText(
                    text: 'Enter Document Id',
                    fontSize: isTablet ? 12 : 10,
                    fontFamily: 'poppinsRegular',
                    color: Colors.black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColor.primaryColor,
                    ),
                    height: 30,
                    child: CustomTextField(
                      labelTxt: 'Enter document id',
                      hintTxt: 'Enter document id',
                      controller: provider.docTypeController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z0-9-_]*$')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      labelTxtStyle: const TextStyle(
                        color: AppColor.txtFieldItemColor,
                        fontSize: 12,
                      ),
                      hintTxtStyle: const TextStyle(
                        color: AppColor.txtFieldItemColor,
                        fontSize: 12,
                      ),
                      onChanged: (value) {},
                      obscureText: false,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  text: 'Search',
                  fontSize: isTablet ? 14 : 12,
                  txtColor: Colors.white,
                  btnColor: AppColor.card3Title,
                  width: isTablet ? 100 : 80,
                  height: 30,
                  borderRadious: 8,
                  onPressed: () {
                    provider.fetchTransDrop(
                      context: context,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
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

class PostDataSource extends DataTableSource {
  final List<Transaction> data;
  final ReiniSusPayReqProvider provider;
  final BuildContext context;

  PostDataSource(this.data, this.provider, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow2(
      cells: [
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.actCode ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.response ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.bankRRN ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.tranRefNo ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.paymentRef ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.tranDateTime ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.amount ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.beneMMID ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.beneMobile ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.beneAccNo ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.beneIFSC ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.beneName ?? '-', style: _tableRowTxtStyle),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

const _tableRowTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: AppColor.cardTitleSubColor,
);

const _tableRowHead = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
