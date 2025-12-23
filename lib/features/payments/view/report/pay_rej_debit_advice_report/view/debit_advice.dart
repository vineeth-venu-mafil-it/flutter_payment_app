import 'package:flutter/cupertino.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/debit_advice_rej_controller.dart';
import '../../../report/pay_rej_debit_advice_report/model/pay_report_model.dart';

class PayRejDebitAdviceReport extends StatelessWidget {
  const PayRejDebitAdviceReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return ChangeNotifierProvider(
      create: (context) => PayRejDebitAdviceRptController()
        ..PayRejDebitAdviceRptAccess(context: context),
      child: Consumer<PayRejDebitAdviceRptController>(
        builder: (context, provider, child) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BreadCrumbs(
                        title: 'Payment Rejected Debit Advice Report',
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.7),
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
                          child: Column(children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => context.pop(),
                                              icon: const Icon(
                                                color: AppColor.drawerColor,
                                                Icons.arrow_back,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: isTablet
                                            ? size.width * 0.75
                                            : size.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: AppColor.cardItem,
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor.dividerColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: isTablet
                                                  ? size.width * 0.75
                                                  : size.width * 0.9,
                                              decoration: BoxDecoration(
                                                color: AppColor.drawerColor,
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    topRight:
                                                        Radius.circular(8.0)),
                                              ),
                                              height: 45,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        'Payment Rejected Debit Advice Report',
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'poppinsSemiBold',
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                      child: SizedBox(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFDDDFDC),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColor
                                                                .dividerColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      width: isTablet
                                                          ? size.width * 0.7
                                                          : size.width * 0.9,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 4.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                text: 'Branch Wise',
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
                                                                                child: provider.branch.isNotEmpty
                                                                                    ? DropdownButton2(
                                                                                        dropdownSearchData: DropdownSearchData(
                                                                                          searchController: provider.branchController,
                                                                                          searchInnerWidgetHeight: 50,
                                                                                          searchInnerWidget: Container(
                                                                                            height: 50,
                                                                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                                                            child: TextFormField(
                                                                                              controller: provider.branchController,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                contentPadding: const EdgeInsets.symmetric(
                                                                                                  horizontal: 10,
                                                                                                  vertical: 8,
                                                                                                ),
                                                                                                hintText: 'Search branch...',
                                                                                                hintStyle: TextStyle(
                                                                                                  fontSize: 10,
                                                                                                  fontFamily: 'poppinsRegular',
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                                border: OutlineInputBorder(
                                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        isExpanded: true,
                                                                                        underline: const SizedBox(),
                                                                                        value: provider.selectedBranchId != null ? provider.selectedBranch : null,
                                                                                        hint: CustomText(
                                                                                          text: '----SELECT BRANCH----',
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'poppinsRegular',
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        items: provider.branch.map((branch) {
                                                                                          return DropdownMenuItem(
                                                                                            value: branch.bRANCH,
                                                                                            child: CustomText(
                                                                                              text: branch.bRANCH ?? '',
                                                                                              fontSize: 10,
                                                                                              fontFamily: 'poppinsRegular',
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                        onChanged: (value) {
                                                                                          if (value != null) {
                                                                                            provider.setSelectedBranch(value: value, context: context);
                                                                                            provider.branchController.clear();
                                                                                          }
                                                                                        },
                                                                                        dropdownStyleData: DropdownStyleData(
                                                                                          maxHeight: 300,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.white,
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : const Center(
                                                                                        child: CustomText(
                                                                                          text: '----------Select branch----------',
                                                                                          fontSize: 10,
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
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 4.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                text: 'Status Wise',
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
                                                                                  child: DropdownButton2(
                                                                                    isExpanded: true,
                                                                                    dropdownStyleData: DropdownStyleData(
                                                                                      maxHeight: 200,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                      ),
                                                                                    ),
                                                                                    underline: const SizedBox(),
                                                                                    value: provider.selectedStatusWise.isNotEmpty ? provider.selectedStatusWise : null,
                                                                                    hint: const CustomText(
                                                                                      text: '---SELECT STATUS WISE---',
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    items: provider.statusWise.map((value) {
                                                                                      return DropdownMenuItem(
                                                                                        value: value["Value"],
                                                                                        child: CustomText(
                                                                                          text: value["Text"]?.toString() ?? '',
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'poppinsRegular',
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      );
                                                                                    }).toList(),
                                                                                    onChanged: (value) {
                                                                                      provider.setSelectedStatusWise(value as String);
                                                                                    },
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 4.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                text: 'Select transaction date (From)',
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
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                      context: context,
                                                                                      initialDate: DateTime.now(),
                                                                                      firstDate: DateTime(1900),
                                                                                      lastDate: DateTime.now(),
                                                                                    );

                                                                                    if (pickedDate != null) {
                                                                                      provider.setFromDt("$pickedDate");
                                                                                      String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate).toUpperCase();
                                                                                      provider.fromDateController.text = formattedDate;
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Center(
                                                                                          child: provider.fromDateController.text.isEmpty
                                                                                              ? CustomText(
                                                                                                  text: "Select from date",
                                                                                                  fontSize: isTablet ? 10 : 9,
                                                                                                  fontFamily: 'poppinsRegular',
                                                                                                  color: Colors.black,
                                                                                                )
                                                                                              : CustomText(
                                                                                                  text: provider.fromDateController.text,
                                                                                                  fontSize: isTablet ? 10 : 9,
                                                                                                  fontFamily: 'poppinsRegular',
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Icon(
                                                                                          Icons.calendar_month,
                                                                                          size: 15,
                                                                                          color: Colors.brown,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 4.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                text: 'Select transaction date (To)',
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
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    if (provider.fromDateController.text.isEmpty) {
                                                                                      final snackBar = SnackBar(
                                                                                        content: Text("please select from date first"),
                                                                                        backgroundColor: Colors.red,
                                                                                      );
                                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                    } else {
                                                                                      DateTime? pickedDate = await showDatePicker(
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(1900),
                                                                                        lastDate: DateTime.now(),
                                                                                      );

                                                                                      if (pickedDate != null) {
                                                                                        String fromDateText = provider.fromDateController.text;

                                                                                        if (fromDateText.isNotEmpty) {
                                                                                          DateTime? fromDate = _parseDateSafely(fromDateText);

                                                                                          if (fromDate == null) {
                                                                                            final snackBar = SnackBar(
                                                                                              content: Text("Invalid from date format"),
                                                                                              backgroundColor: Colors.red,
                                                                                            );
                                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                            return;
                                                                                          }

                                                                                          if (pickedDate.isBefore(fromDate)) {
                                                                                            provider.setToDate("");

                                                                                            final snackBar = SnackBar(
                                                                                              content: Text("You can't select a date before the from date"),
                                                                                              backgroundColor: Colors.red,
                                                                                            );
                                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                            return; // Exit without setting the date
                                                                                          }
                                                                                        }

                                                                                        provider.setToDate("$pickedDate");
                                                                                        String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate).toUpperCase();
                                                                                        provider.toDateController.text = formattedDate;
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Center(
                                                                                          child: provider.toDateController.text.isEmpty
                                                                                              ? CustomText(
                                                                                                  text: "Select to date",
                                                                                                  fontSize: isTablet ? 10 : 9,
                                                                                                  fontFamily: 'poppinsRegular',
                                                                                                  color: Colors.black,
                                                                                                )
                                                                                              : CustomText(
                                                                                                  text: provider.toDateController.text,
                                                                                                  fontSize: isTablet ? 10 : 9,
                                                                                                  fontFamily: 'poppinsRegular',
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Icon(
                                                                                          Icons.calendar_month,
                                                                                          size: 15,
                                                                                          color: Colors.brown,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CustomButton(
                                                                        text:
                                                                            'Generate',
                                                                        txtColor:
                                                                            Colors
                                                                                .white,
                                                                        btnColor:
                                                                            AppColor
                                                                                .drawerColor,
                                                                        borderRadious:
                                                                            8,
                                                                        progress: provider
                                                                                .isLoading
                                                                            ? const SizedBox(
                                                                                width:
                                                                                    10,
                                                                                height:
                                                                                    10,
                                                                                child:
                                                                                    CircularProgressIndicator(
                                                                                  color: Colors.white,
                                                                                ))
                                                                            : null,
                                                                        width: isTablet
                                                                            ? 120
                                                                            : 100,
                                                                        height:
                                                                            25,
                                                                        onPressed:
                                                                            () {
                                                                          if (provider.selectedBranchId ==
                                                                              null) {
                                                                            final snackBar =
                                                                                SnackBar(
                                                                              content: Text("please select branch"),
                                                                              backgroundColor: Colors.red,
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                          } else if (provider
                                                                              .selectedStatusWise
                                                                              .isEmpty) {
                                                                            final snackBar =
                                                                                SnackBar(
                                                                              content: Text("please select status wise"),
                                                                              backgroundColor: Colors.red,
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                          } else if (provider
                                                                              .fromDateController
                                                                              .text
                                                                              .isEmpty) {
                                                                            final snackBar =
                                                                                SnackBar(
                                                                              content: Text("please select from date"),
                                                                              backgroundColor: Colors.red,
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                          } else if (provider
                                                                              .toDateController
                                                                              .text
                                                                              .isEmpty) {
                                                                            final snackBar =
                                                                                SnackBar(
                                                                              content: Text("please select to date"),
                                                                              backgroundColor: Colors.red,
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                          } else {
                                                                            provider.fetchdebitAdviceReport(
                                                                                context: context,
                                                                                brId: "${provider.selectedBranchId}",
                                                                                status: provider.selectedStatusWise,
                                                                                frmDate: provider.fromDateController.text,
                                                                                toDate: provider.toDateController.text);
                                                                          }
                                                                        }),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    CustomButton(
                                                                        text:
                                                                            'Exit',
                                                                        txtColor:
                                                                            Colors
                                                                                .white,
                                                                        btnColor: provider.hoverBtn
                                                                            ? AppColor
                                                                                .card3Title
                                                                            : AppColor
                                                                                .errorTxt,
                                                                        borderRadious:
                                                                            8,
                                                                        width: isTablet
                                                                            ? 120
                                                                            : 100,
                                                                        height:
                                                                            25,
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .pop();
                                                                        }),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  provider.debitAdviceReport
                                                          .isNotEmpty
                                                      ? Column(
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                    child:
                                                                        SizedBox(
                                                                  width: isTablet
                                                                      ? size.width *
                                                                          0.7
                                                                      : size.width *
                                                                          0.9,
                                                                  child:
                                                                      SizedBox(
                                                                    width: isTablet
                                                                        ? size.width *
                                                                            0.7
                                                                        : size.width *
                                                                            0.9,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        CustomText(
                                                                          text:
                                                                              'Payment Details',
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'poppinsSemiBold',
                                                                          color:
                                                                              AppColor.drawerColor,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child: Container(
                                                                height: 350,
                                                                width: isTablet
                                                                    ? size.width *
                                                                        0.7
                                                                    : size.width *
                                                                        0.9,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: const Color(
                                                                          0xFFCCC6C6)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child: Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    cardTheme:
                                                                        CardTheme(
                                                                      elevation:
                                                                          0,
                                                                      margin: EdgeInsets
                                                                          .zero,
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
                                                                        2700,
                                                                    wrapInCard:
                                                                        false,
                                                                    headingRowColor:
                                                                        WidgetStateProperty
                                                                            .all(
                                                                      AppColor
                                                                          .drawerColor,
                                                                    ),
                                                                    headingTextStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                    dataTextStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          800],
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                    dividerThickness:
                                                                        0.5,
                                                                    rowsPerPage:
                                                                        provider
                                                                            .rowsPerPage,
                                                                    availableRowsPerPage: const [
                                                                      10,
                                                                      20,
                                                                      50
                                                                    ],
                                                                    onRowsPerPageChanged:
                                                                        (value) {
                                                                      provider.updateRowsPage(
                                                                          data:
                                                                              value!);
                                                                    },
                                                                    showFirstLastButtons:
                                                                        true,
                                                                    showCheckboxColumn:
                                                                        false,
                                                                    columns: [
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Sl.No', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Customer_Name', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Pledge_No', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Pledge_Date', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Area_Name', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Branch_ID', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Branch_Name', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Region_Name', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Response', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                      DataColumn2(
                                                                        label: Center(
                                                                            child:
                                                                                Text('Amount', style: _tableRowHead)),
                                                                        size: ColumnSize
                                                                            .S,
                                                                      ),
                                                                    ],
                                                                    source: PayReportDataSource(
                                                                        provider
                                                                            .debitAdviceReport,
                                                                        provider,
                                                                        context),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox.shrink(),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  DateTime? _parseDateSafely(String dateText) {
    try {
// First try: Standard parsing with uppercase
      String cleanDate = dateText.trim().toUpperCase();
      return DateFormat('dd-MMM-yyyy').parse(cleanDate);
    } catch (e) {
      // print('Standard parsing failed: $e');

// Second try: Manual parsing
      try {
        List<String> parts = dateText.split('-');
        if (parts.length == 3) {
          int day = int.parse(parts[0].trim());
          String monthStr = parts[1].trim().toUpperCase();
          int year = int.parse(parts[2].trim());

          Map<String, int> monthMap = {
            'JAN': 1,
            'FEB': 2,
            'MAR': 3,
            'APR': 4,
            'MAY': 5,
            'JUN': 6,
            'JUL': 7,
            'AUG': 8,
            'SEP': 9,
            'OCT': 10,
            'NOV': 11,
            'DEC': 12
          };

          if (monthMap.containsKey(monthStr)) {
            return DateTime(year, monthMap[monthStr]!, day);
          }
        }
      } catch (e2) {
        print('Manual parsing also failed: $e2');
      }
    }
    return null;
  }
}

class PayReportDataSource extends DataTableSource {
  final List<DebitAdviceReportModel> data;
  final PayRejDebitAdviceRptController provider;
  final BuildContext context;

  PayReportDataSource(this.data, this.provider, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow2(
      cells: [
        DataCell(Center(
            child: Text("${item.sLNO ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.cUSTNAME ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.pLEDGENO ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.tRADATE ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aREANAME ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.bRANCHID ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text("${item.bRANCHNAME ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.rEGNAME ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rESPONSE ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '_'}", style: _tableRowTxtStyle))),
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
  fontSize: 10,
  color: AppColor.cardTitleSubColor,
);
const _tableRowHead = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const _tableHighLiteTxt = TextStyle(
  decoration: TextDecoration.underline,
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.cardTitleSubColor,
);
