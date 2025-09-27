import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/ch_branch_imps_bank_controller.dart';
import '../model/bank_drop_model.dart';
import '../model/table_model.dart';

class ChangeBranchImpsBranch extends StatelessWidget {
  const ChangeBranchImpsBranch({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isTablet = size.width >= 900;
    return ChangeNotifierProvider(
      create: (context) => ChangeBranchImpsController()
        ..changeBrIMPSBankAccess(context: context),
      child: Consumer<ChangeBranchImpsController>(
        builder: (context, provider, child) => Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            image: DecorationImage(
              image: AssetImage(AssetsPath.appBackground),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BreadCrumbs(
                  title: 'Change branch imps bank',
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
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
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: isTablet
                                    ? size.width * 0.75
                                    : size.width * 0.9,
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
                                      width: isTablet
                                          ? size.width * 0.75
                                          : size.width * 0.9,
                                      decoration: BoxDecoration(
                                        color: AppColor.drawerColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                      ),
                                      height: 45,
                                      child: Center(
                                        child: CustomText(
                                          text: 'CHANGE BRANCH IMPS/NEFT BANK',
                                          fontSize: 14,
                                          fontFamily: 'poppinsSemiBold',
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 600,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor.dividerColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildRadioButtonGroup(
                                                options: [
                                                  {
                                                    'title': 'IMPS Bank',
                                                    'value': 'IMPS_BANK'
                                                  },
                                                  {
                                                    'title': 'IMPS NEFT',
                                                    'value': 'NEFT_BANK'
                                                  },
                                                ],
                                                groupValue: provider
                                                    .selectedOptionPaymentMode,
                                                onChanged: (value) {
                                                  provider
                                                      .updateSelectedOptionPayMode(
                                                          value);
                                                  provider.fetchBankDrop(
                                                      context: context,
                                                      type: value);
                                                },
                                              ),
                                              Divider(
                                                color: AppColor.dividerColor,
                                              ),
                                              _buildRadioButtonGroup(
                                                options: [
                                                  {
                                                    'title': 'Region Wise',
                                                    'value': '1'
                                                  },
                                                  {
                                                    'title': 'State Wise',
                                                    'value': '2'
                                                  },
                                                  {
                                                    'title': 'All',
                                                    'value': '3'
                                                  },
                                                ],
                                                groupValue:
                                                    provider.selectedType,
                                                onChanged: (value) {
                                                  provider.updateSelectedType(
                                                      value);
                                                  provider.fetchTableData(
                                                      context: context,
                                                      type: provider
                                                          .selectedType);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    provider.selectedType != '3'
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFFCCC6C6)),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8.0),
                                                    ),
                                                    width: 600,
                                                    height: 250,
                                                    child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        cardTheme: CardTheme(
                                                          elevation: 0,
                                                          margin:
                                                              EdgeInsets.zero,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                        ),
                                                        dividerTheme:
                                                            const DividerThemeData(
                                                          space: 0,
                                                          thickness: 1,
                                                        ),
                                                      ),
                                                      child:
                                                          PaginatedDataTable2(
                                                        headingRowHeight:
                                                            35.0,
                                                        dataRowHeight: 40.0,
                                                        horizontalMargin: 0,
                                                        columnSpacing: 0,
                                                        minWidth: size.width,
                                                        wrapInCard: false,
                                                        headingRowColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          AppColor
                                                              .drawerColor,
                                                        ),
                                                        headingTextStyle:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13,
                                                        ),
                                                        dataTextStyle:
                                                            TextStyle(
                                                          color: Colors
                                                              .grey[800],
                                                          fontSize: 13,
                                                        ),
                                                        dividerThickness: 0.5,
                                                        rowsPerPage: provider
                                                            .rowsPerPage,
                                                        availableRowsPerPage: const [
                                                          10,
                                                          20,
                                                          50
                                                        ],
                                                        onRowsPerPageChanged:
                                                            (value) {
                                                          provider
                                                              .updateRowsPage(
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
                                                                    'ID',
                                                                    style:
                                                                        _tableRowHead),
                                                              ),
                                                              fixedWidth:
                                                                  200),
                                                          DataColumn2(
                                                              label: Center(
                                                                child: Text(
                                                                    'Name',
                                                                    style:
                                                                        _tableRowHead),
                                                              ),
                                                              fixedWidth:
                                                                  200),
                                                          DataColumn2(
                                                            fixedWidth: 200,
                                                            label: Center(
                                                              child: Text(
                                                                  'Select',
                                                                  style:
                                                                      _tableRowHead),
                                                            ),
                                                          ),
                                                        ],
                                                        source: PostDataSource(
                                                            provider
                                                                .tableDataList,
                                                            provider,
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: size.width * 0.30,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  text: 'Select Bank :',
                                                  fontSize: 13,
                                                  fontFamily:
                                                      'poppinsRegular',
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(width: 50)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child:
                                                  provider.bankDropList
                                                          .isNotEmpty
                                                      ? Row(
                                                          mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 35,
                                                              width:
                                                                  size.width *
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
                                                                  DropdownButtonHideUnderline(
                                                                child: DropdownButton2<
                                                                    BankDropModel>(
                                                                  isExpanded:
                                                                      true,
                                                                  value: provider
                                                                          .selectedBank
                                                                          .isNotEmpty
                                                                      ? provider
                                                                          .bankDropList
                                                                          .firstWhere(
                                                                          (item) =>
                                                                              item.id.toString() ==
                                                                              provider.selectedBank,
                                                                          orElse: () =>
                                                                              provider.bankDropList.first,
                                                                        )
                                                                      : provider.bankDropList.isNotEmpty
                                                                          ? provider.bankDropList.first
                                                                          : null,
                                                                  items: provider
                                                                      .bankDropList
                                                                      .map(
                                                                          (bank) {
                                                                    return DropdownMenuItem<
                                                                        BankDropModel>(
                                                                      value:
                                                                          bank,
                                                                      child:
                                                                          CustomText(
                                                                        text: bank.selectImpsBank ??
                                                                            '',
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'poppinsRegular',
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (BankDropModel?
                                                                          value) {
                                                                    if (value !=
                                                                        null) {
                                                                      provider.setSelectedBank(
                                                                          value:
                                                                              value.id.toString());
                                                                    }
                                                                  },
                                                                  buttonStyleData:
                                                                      const ButtonStyleData(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            8),
                                                                  ),
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
                                                                    ),
                                                                  ),
                                                                  menuItemStyleData:
                                                                      const MenuItemStyleData(
                                                                    height:
                                                                        40,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            8),
                                                                  ),
                                                                  dropdownSearchData:
                                                                      DropdownSearchData(
                                                                    searchController:
                                                                        provider
                                                                            .bankController,
                                                                    searchInnerWidgetHeight:
                                                                        50,
                                                                    searchInnerWidget:
                                                                        Container(
                                                                      height:
                                                                          50,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              8),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            provider.bankController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal: 10,
                                                                            vertical: 8,
                                                                          ),
                                                                          hintText:
                                                                              'Search bank...',
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 35,
                                                              width:
                                                                  size.width *
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
                                                                  const Center(
                                                                child:
                                                                    CustomText(
                                                                  text:
                                                                      'No banks available',
                                                                  fontSize:
                                                                      12,
                                                                  fontFamily:
                                                                      'poppinsRegular',
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                                text: 'Confirm',
                                                txtColor: Colors.white,
                                                btnColor:
                                                    AppColor.drawerColor,
                                                borderRadious: 8,
                                                progress: provider.isLoading
                                                    ? const SizedBox(
                                                        width: 10,
                                                        height: 10,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ))
                                                    : null,
                                                width: isTablet ? 120 : 100,
                                                height: 35,
                                                onPressed: () {
                                                  if (provider.selectedIndices
                                                      .isEmpty) {
                                                    if (provider
                                                            .selectedType !=
                                                        '3') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Please select at least one item'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    } else if (provider
                                                            .selectedBank
                                                            .isEmpty ||
                                                        provider.selectedBank ==
                                                            '-1') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Please select bank'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    } else {
                                                      provider.submitData(
                                                          context: context,
                                                          bankId: provider
                                                              .selectedBank,
                                                          payMode: provider
                                                              .selectedOptionPaymentMode,
                                                          vWise: provider
                                                              .selectedType);
                                                    }
                                                  } else if (provider
                                                          .selectedBank
                                                          .isEmpty ||
                                                      provider.selectedBank ==
                                                          '-1') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Please select bank'),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  } else {
                                                    provider.submitData(
                                                        context: context,
                                                        bankId: provider
                                                            .selectedBank,
                                                        payMode: provider
                                                            .selectedOptionPaymentMode,
                                                        vWise: provider
                                                            .selectedType);
                                                  }
                                                }),
                                            const SizedBox(width: 10),
                                            CustomButton(
                                              text: 'Exit',
                                              txtColor: Colors.white,
                                              btnColor: provider.hoverBtn
                                                  ? AppColor.card3Title
                                                  : AppColor.errorTxt,
                                              width: isTablet ? 120 : 100,
                                              height: 35,
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup({
    required List<Map<String, String>> options,
    required String groupValue,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: options.map((option) {
            return SizedBox(
              width: 150, // Fixed width for all radio buttons
              child: _customRadioTile(
                title: option['title']!,
                value: option['value']!,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value!),
              ),
            );
          }).toList(),
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
    return SizedBox(
      width: 130,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return AppColor.hdTxtColor;
              }
              return AppColor.cardTitleSubColor; // Default color
            }),
            activeColor: AppColor.hdTxtColor,
          ),
          SizedBox(
            width: 10,
          ),
          CustomText(
            text: title,
            fontSize: 12,
            fontFamily: 'poppinsRegular',
            color: AppColor.backBtn,
          ),
        ],
      ),
    );
  }
}

class PostDataSource extends DataTableSource {
  final List<TableModel> data;
  final ChangeBranchImpsController provider;
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
            child: Text("${item.iD ?? '-'}", style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(item.nAME ?? '-', style: _tableRowTxtStyle),
          ),
        ),
        DataCell(
          Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 0.7,
                child: Checkbox(
                  value: provider.isSelected(index),
                  checkColor: const Color(0xFF072243),
                  onChanged: (value) {
                    provider.toggleSelection(index, value ?? false);
                  },
                ),
              )),
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
