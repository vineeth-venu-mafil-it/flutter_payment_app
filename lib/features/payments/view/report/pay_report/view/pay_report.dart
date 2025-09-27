import 'package:flutter_payment_app/features/payments/view/report/pay_report/view/widgets/docid_widget.dart';
import '../controller/pay_ogl_report_controller.dart';
import '../view/widgets/corid_widget.dart';
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
import '../model/pay_report_model.dart';

class PayReport extends StatelessWidget {
  const PayReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return ChangeNotifierProvider(
      create: (context) =>
          PayReportController()..payReportAccess(context: context),
      child: Consumer<PayReportController>(
        builder: (context, provider, child) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BreadCrumbs(
                    title: 'Payment report',
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.7),
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
                                          width: isTablet
                                              ? size.width * 0.75
                                              : size.width * 0.9,
                                          decoration: BoxDecoration(
                                            color: AppColor.drawerColor,
                                            borderRadius:
                                                const BorderRadius.only(
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
                                                text: 'Payment Report',
                                                fontSize: 14,
                                                fontFamily: 'poppinsSemiBold',
                                                color: AppColor.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
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
                                                      SizedBox(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Module Wise',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: AppColor.dividerColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child: provider.module.isEmpty
                                                                                ? CustomText(
                                                                                    text: "---SELECT MODULE---",
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  )
                                                                                : DropdownButtonHideUnderline(
                                                                                    child: DropdownButton2(
                                                                                      isExpanded: true,
                                                                                      value: provider.selectedModule.isNotEmpty
                                                                                          ? provider.module.firstWhere(
                                                                                              (item) => item.moduleId.toString() == provider.selectedModule,
                                                                                              orElse: () => provider.module.first,
                                                                                            )
                                                                                          : provider.module.isNotEmpty
                                                                                              ? provider.module.first
                                                                                              : null,
                                                                                      items: provider.module.map((module) {
                                                                                        return DropdownMenuItem(
                                                                                          value: module,
                                                                                          child: CustomText(
                                                                                            text: module.module ?? '',
                                                                                            fontSize: 10,
                                                                                            fontFamily: 'poppinsRegular',
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        );
                                                                                      }).toList(),
                                                                                      onChanged: (value) {
                                                                                        provider.setSelectedModule(value!.moduleId.toString());
                                                                                      },
                                                                                      buttonStyleData: const ButtonStyleData(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                                                                      ),
                                                                                      dropdownStyleData: DropdownStyleData(
                                                                                        maxHeight: 300,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                        ),
                                                                                      ),
                                                                                      menuItemStyleData: const MenuItemStyleData(
                                                                                        height: 40,
                                                                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                                                                      ),
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
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Payment Type',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
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
                                                                                  maxHeight: 300,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                ),
                                                                                underline: const SizedBox(),
                                                                                value: provider.selectedPayType.isNotEmpty ? provider.selectedPayType : null,
                                                                                hint: const CustomText(
                                                                                  text: '---SELECT PAY-TYPE---',
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'poppinsRegular',
                                                                                  color: Colors.black,
                                                                                ),
                                                                                items: provider.payType.map((value) {
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
                                                                                  provider.setSelectedPayType(
                                                                                    value as String,
                                                                                  );
                                                                                  provider.fetchBank(
                                                                                    context: context,
                                                                                    payType: value,
                                                                                  );
                                                                                },
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Payment bank',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: AppColor.dividerColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child: provider.bank.isEmpty
                                                                                ? CustomText(
                                                                                    text: "---SELECT BANK---",
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'poppinsRegular',
                                                                                    color: Colors.black,
                                                                                  )
                                                                                : DropdownButtonHideUnderline(
                                                                                    child: DropdownButton2(
                                                                                      isExpanded: true,
                                                                                      value: provider.selectedBank.isNotEmpty
                                                                                          ? provider.bank.firstWhere(
                                                                                              (item) => item.bANKCODE.toString() == provider.selectedBank,
                                                                                              orElse: () => provider.bank.first,
                                                                                            )
                                                                                          : provider.bank.isNotEmpty
                                                                                              ? provider.bank.first
                                                                                              : null,
                                                                                      items: provider.bank.map((bank) {
                                                                                        return DropdownMenuItem(
                                                                                          value: bank,
                                                                                          child: CustomText(
                                                                                            text: bank.bANKNAME ?? '',
                                                                                            fontSize: 10,
                                                                                            fontFamily: 'poppinsRegular',
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        );
                                                                                      }).toList(),
                                                                                      onChanged: (value) {
                                                                                        provider.setSelectedBank(value!.bANKCODE.toString());
                                                                                      },
                                                                                      buttonStyleData: const ButtonStyleData(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                                                                      ),
                                                                                      dropdownStyleData: DropdownStyleData(
                                                                                        maxHeight: 300,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                        ),
                                                                                      ),
                                                                                      menuItemStyleData: const MenuItemStyleData(
                                                                                        height: 40,
                                                                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                                                                      ),
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
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Branch Wise',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                                                            hintText: 'Search module...',
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
                                                                                    value: provider.selectedBranchId != -1 ? provider.selectedBranch : null,
                                                                                    hint: CustomText(
                                                                                      text: '----Select branch----',
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'poppinsRegular',
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    items: provider.branch.map((branch) {
                                                                                      return DropdownMenuItem(
                                                                                        value: branch.BRANCH,
                                                                                        child: CustomText(
                                                                                          text: branch.BRANCH ?? '',
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
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Status Wise',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
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
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Select transaction date (From)',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: AppColor.dividerColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                InkWell(
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
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomText(
                                                                            text:
                                                                                'Select transaction date (To)',
                                                                            fontSize: isTablet
                                                                                ? 12
                                                                                : 10,
                                                                            fontFamily:
                                                                                'poppinsRegular',
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 4),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              border: Border.all(
                                                                                width: 1,
                                                                                color: AppColor.dividerColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                InkWell(
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
                                                                    txtColor: Colors
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
                                                                    height: 25,
                                                                    onPressed:
                                                                        () {
                                                                      if (provider
                                                                          .fromDateController
                                                                          .text
                                                                          .isEmpty) {
                                                                      } else {}
                                                                      if (provider
                                                                          .selectedModule
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select module"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                          .selectedPayType
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select payment type"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                          .selectedBank
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select bank"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                              .selectedBranchId ==
                                                                          -1) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select branch"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                          .selectedStatusWise
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select status wise"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                          .fromDateController
                                                                          .text
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select from date"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else if (provider
                                                                          .toDateController
                                                                          .text
                                                                          .isEmpty) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              Text("please select to date"),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                      } else {
                                                                        provider.fetchOglReport(
                                                                            context:
                                                                                context,
                                                                            modId: provider
                                                                                .selectedModule,
                                                                            payType: provider
                                                                                .selectedPayType,
                                                                            payBank: provider
                                                                                .selectedBank,
                                                                            brId:
                                                                                "${provider.selectedBranchId}",
                                                                            status:
                                                                                provider.selectedStatusWise,
                                                                            frmDate: provider.fromDateController.text,
                                                                            toDate: provider.toDateController.text);
                                                                      }
                                                                    }),
                                                                SizedBox(
                                                                    width: 10),
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
                                                                    height: 25,
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
                                              provider.oglReport.isNotEmpty
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Center(
                                                                child: SizedBox(
                                                              width: isTablet
                                                                  ? size.width *
                                                                      0.7
                                                                  : size.width *
                                                                      0.9,
                                                              child: SizedBox(
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
                                                                      color: AppColor
                                                                          .drawerColor,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        CustomButton(
                                                                          text:
                                                                              'PDF',
                                                                          txtColor:
                                                                              Colors.white,
                                                                          btnColor:
                                                                              AppColor.pdfBtn,
                                                                          borderRadious:
                                                                              8,
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              25,
                                                                          onPressed:
                                                                              () {
                                                                            provider.savePdfPayReport(provider.oglReport,
                                                                                context);
                                                                          },
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                15),
                                                                        CustomButton(
                                                                          text:
                                                                              'Excel',
                                                                          txtColor:
                                                                              Colors.white,
                                                                          btnColor:
                                                                              AppColor.excelBtn,
                                                                          borderRadious:
                                                                              8,
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              25,
                                                                          onPressed:
                                                                              () {
                                                                            provider.exportToExcel(provider.oglReport,
                                                                                context);
                                                                          },
                                                                        ),
                                                                      ],
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
                                                              color:
                                                                  Colors.white,
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
                                                                  elevation: 0,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
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
                                                                minWidth: 2700,
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
                                                                  fontSize: 13,
                                                                ),
                                                                dataTextStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontSize: 13,
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
                                                                        child: Text(
                                                                            'PaymentMode',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'PaymentBank',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'Module',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'Branch',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'BranchId',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'DocId',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'CustomerId',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'CustomerName',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'Amount',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'TraDate',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'CorporateId',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'PaymentDate',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'Response',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'BankRRN',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'IFSCCode',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'BeneficiaryAccount',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'SendTransId',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'SequenceNo',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  ),
                                                                  DataColumn2(
                                                                    label: Center(
                                                                        child: Text(
                                                                            'BatchNo',
                                                                            style:
                                                                                _tableRowHead)),
                                                                    size:
                                                                        ColumnSize
                                                                            .S,
                                                                  )
                                                                ],
                                                                source: PayReportDataSource(
                                                                    provider
                                                                        .oglReport,
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
  final List<PayReportModel> data;
  final PayReportController provider;
  final BuildContext context;

  PayReportDataSource(this.data, this.provider, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow2(
      cells: [
        DataCell(
            Center(child: Text(item.pAYMODE ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.pAYBANK ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.mODULE ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bRANCHNAME ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.bRANCHID ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: InkWell(
                onTap: () {
                  if (item.dOCID != null) {
                    provider
                        .fetchDocId(docId: "${item.dOCID}", context: context)
                        .then(
                      (value) {
                        if (!context.mounted) return;
                        _showDocId(context, provider, 1000);
                      },
                    );
                  }
                },
                child: Text(item.dOCID ?? '_', style: _tableHighLiteTxt)))),
        DataCell(Center(
            child: InkWell(
                onTap: () {
                  if (item.cUSTID != null) {
                    provider.fetchCusId(
                        context: context, cusId: item.cUSTID.toString());
                  }
                },
                child: Text(item.cUSTID ?? '_', style: _tableHighLiteTxt)))),
        DataCell(Center(
            child: Text(item.cUSTNAME ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRADATE?.split('T').first ?? '_',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: InkWell(
                onTap: () {
                  if (item.cORPORATEID != null) {
                    provider
                        .fetchCorId(
                            corId: "${item.cORPORATEID}", context: context)
                        .then(
                      (value) {
                        if (!context.mounted) return;
                        _showCorId(context, provider, 1000);
                      },
                    );
                  }
                },
                child:
                    Text(item.cORPORATEID ?? '_', style: _tableHighLiteTxt)))),
        DataCell(Center(
            child: Text(
          item.pAYDATE?.split('T').first ?? '_',
          style: _tableRowTxtStyle,
        ))),
        DataCell(Center(
            child: Text(item.rESPONSE ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANKRRN ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.iFSCCODE ?? '_', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bENEFICIARYACCOUNT ?? '_',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text("${item.sENDTRANSID ?? '_'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.sEQNO ?? '_', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bATCHNO ?? '_', style: _tableRowTxtStyle))),
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

void _showDocId(
    BuildContext context, PayReportController provider, double width) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70,
              maxHeight: MediaQuery.of(context).size.height *
                  0.6, // More flexible height
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    PayDocIdWidget(
                      width: MediaQuery.of(context).size.width * 0.70,
                      height: 400,
                      provider: provider,
                      transDet: provider.transDet,
                      neftCusDet: provider.neftCusDet,
                    ),
                  ],
                ),
              ),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeyboardListener(
                  focusNode: provider.focusNode,
                  autofocus: true,
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.enter) {
                      provider.resetDocId();
                      Navigator.of(context).pop();
                    }
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.drawerImgTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      provider.resetDocId();
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void _showCorId(
    BuildContext context, PayReportController provider, double width) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70,
              maxHeight: MediaQuery.of(context).size.height *
                  0.6, // More flexible height
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    PayCorIdWidget(
                      width: MediaQuery.of(context).size.width * 0.70,
                      height: 400,
                      provider: provider,
                      impsResDet: provider.impsResDet,
                      impsSendDtl: provider.impsSendDtl,
                      neftSftDet: provider.neftSftDet,
                      SbiTransDet: provider.SbiTransDet,
                    )
                  ],
                ),
              ),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeyboardListener(
                  focusNode: provider.focusNode,
                  autofocus: true,
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.enter) {
                      provider.resetCorId();
                      Navigator.of(context).pop();
                    }
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.drawerImgTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      provider.resetCorId();
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
