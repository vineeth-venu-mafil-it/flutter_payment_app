import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../../core/utils/shared/component/widgets/custom_button.dart';
import '../../../../../../../core/utils/shared/component/widgets/custom_text.dart';
import '../../controller/pay_ogl_report_controller.dart';
import '../../model/imps_snt_det_model.dart';
import '../../model/ogl_imps_res_det.dart';
import '../../model/ogl_neft_cus_det.dart';
import '../../model/ogl_rpt_neft_sft_det.dart';
import '../../model/ogl_rpt_sbi_trans_det.dart';

class CorIdWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final List<OglReImpSendDet>? impsSendDtl;
  final List<OglRptImpsResDt>? impsResDet;
  final List<OglRptneftSftDet>? neftSftDet;
  final List<OglRptSbiTransDet>? SbiTransDet;
  final PaymentOGLReportController? provider;
  const CorIdWidget(
      {super.key,
      this.width,
      this.height,
      this.impsSendDtl,
      this.SbiTransDet,
      this.impsResDet,
      this.neftSftDet,
      this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: 'IMPS Sending details ',
                  fontSize: 14,
                  fontFamily: 'poppinsSemiBold',
                  color: AppColor.drawerColor),
              impsSendDtl!.isEmpty
                  ? SizedBox.shrink()
                  : CustomButton(
                      text: 'Excel',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 100,
                      height: 25,
                      onPressed: () {
                        if (impsSendDtl != null || impsSendDtl!.isNotEmpty) {
                          provider!.exportToExcelImpsSntDt(
                              impsSendDtl ?? [], context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("No data found"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
            ],
          ),
        ),
        impsSendDtl!.isEmpty
            ? CustomText(
                text: 'No data found',
                fontSize: 12,
                fontFamily: 'poppinsRegular',
                color: Colors.black)
            : SizedBox(
                width: width,
                height: 270,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 220,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xFFCCC6C6)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardTheme: CardTheme(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: PaginatedDataTable2(
                              scrollController:
                                  ScrollController(), // Enable scrolling
                              minWidth: 800,
                              headingRowHeight: 35.0,
                              dataRowHeight: 40.0,
                              horizontalMargin: 16,
                              columnSpacing: 16,
                              wrapInCard: false,
                              headingRowColor: WidgetStateProperty.all(
                                const Color(0xFF112D4E),
                              ),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              dataTextStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 13,
                              ),
                              dividerThickness: 0.5,
                              rowsPerPage: provider!.rowsPerPageImpsSntDet,
                              availableRowsPerPage: const [10, 20, 50],
                              onRowsPerPageChanged: (value) {
                                provider!
                                    .updateRowsPageImpsSntDet(data: value!);
                              },
                              showFirstLastButtons: true,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn2(
                                  label: Center(
                                      child: Text('ImpsTransNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TraDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Bank', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                              ],
                              source: DocIdDataSource1(
                                  impsSendDtl ?? [], provider, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: 'IMPS Response details',
                  fontSize: 14,
                  fontFamily: 'poppinsSemiBold',
                  color: AppColor.drawerColor),
              impsResDet!.isEmpty
                  ? SizedBox.shrink()
                  : CustomButton(
                      text: 'Excel',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 100,
                      height: 25,
                      onPressed: () {
                        if (impsResDet != null || impsResDet!.isNotEmpty) {
                          provider!.exportToExcelImpsResDt(
                              impsResDet ?? [], context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("No data found"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
            ],
          ),
        ),
        impsResDet!.isEmpty
            ? CustomText(
                text: 'No data found',
                fontSize: 12,
                fontFamily: 'poppinsRegular',
                color: Colors.black)
            : SizedBox(
                width: width,
                height: 270,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 220,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xFFCCC6C6)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardTheme: CardTheme(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: PaginatedDataTable2(
                              scrollController:
                                  ScrollController(), // Enable scrolling
                              minWidth:
                                  2000, // Adjusted based on column requirements
                              headingRowHeight: 35.0,
                              dataRowHeight: 40.0,
                              horizontalMargin: 16,
                              columnSpacing: 16,
                              wrapInCard: false,
                              headingRowColor: WidgetStateProperty.all(
                                const Color(0xFF112D4E),
                              ),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              dataTextStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 13,
                              ),
                              dividerThickness: 0.5,
                              rowsPerPage: provider!.rowsPerPageImpsResDet,
                              availableRowsPerPage: const [10, 20, 50],
                              onRowsPerPageChanged: (value) {
                                provider!
                                    .updateRowsPageImpsResDet(data: value!);
                              },
                              showFirstLastButtons: true,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn2(
                                  label: Center(
                                      child: Text('CorporateId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TraDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('ResponseCode',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('Response',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BankRRN',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BankRefNum',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TransId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Bank', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                              ],
                              source: DocIdDataSource2(
                                  impsResDet ?? [], provider, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: 'Neft SFTP Details',
                  fontSize: 14,
                  fontFamily: 'poppinsSemiBold',
                  color: AppColor.drawerColor),
              neftSftDet!.isEmpty
                  ? SizedBox.shrink()
                  : CustomButton(
                      text: 'Excel',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 100,
                      height: 25,
                      onPressed: () {
                        if (neftSftDet != null || neftSftDet!.isNotEmpty) {
                          provider!.exportToExcelneftSftDet(
                              neftSftDet ?? [], context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("No data found"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
            ],
          ),
        ),
        neftSftDet!.isEmpty
            ? CustomText(
                text: 'No data found',
                fontSize: 12,
                fontFamily: 'poppinsRegular',
                color: Colors.black)
            : SizedBox(
                width: width,
                height: 270,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 220,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xFFCCC6C6)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardTheme: CardTheme(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: PaginatedDataTable2(
                              scrollController:
                                  ScrollController(), // Enable scrolling
                              minWidth:
                                  2000, // Adjusted based on column requirements
                              headingRowHeight: 35.0,
                              dataRowHeight: 40.0,
                              horizontalMargin: 16,
                              columnSpacing: 16,
                              wrapInCard: false,
                              headingRowColor: WidgetStateProperty.all(
                                const Color(0xFF112D4E),
                              ),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              dataTextStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 13,
                              ),
                              dividerThickness: 0.5,
                              rowsPerPage: provider!.rowsPerPageneftSftDet,
                              availableRowsPerPage: const [10, 20, 50],
                              onRowsPerPageChanged: (value) {
                                provider!
                                    .updateRowsPageNeftSftDet(data: value!);
                              },
                              showFirstLastButtons: true,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn2(
                                  label: Center(
                                      child: Text('CorporateId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('PayDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TraUTR_No',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('ChqNo', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Status', style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('StatusDesc',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BankRefNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Amount', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BeneAccountNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TraDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TransId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BatchNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                              ],
                              source: DocIdDataSource3(
                                  neftSftDet ?? [], provider, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: 'SBI Transaction details',
                  fontSize: 14,
                  fontFamily: 'poppinsSemiBold',
                  color: AppColor.drawerColor),
              SbiTransDet!.isEmpty
                  ? SizedBox.shrink()
                  : CustomButton(
                      text: 'Excel',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 100,
                      height: 25,
                      onPressed: () {
                        if (SbiTransDet != null || SbiTransDet!.isNotEmpty) {
                          provider!.exportToExcelSbiTransDet(
                              SbiTransDet ?? [], context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("No data found"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
            ],
          ),
        ),
        SbiTransDet!.isEmpty
            ? CustomText(
                text: 'No data found',
                fontSize: 12,
                fontFamily: 'poppinsRegular',
                color: Colors.black)
            : SizedBox(
                width: width,
                height: 270,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 220,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xFFCCC6C6)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardTheme: CardTheme(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: PaginatedDataTable2(
                              scrollController:
                                  ScrollController(), // Enable scrolling
                              minWidth:
                                  2500, // Adjusted based on column requirements
                              headingRowHeight: 35.0,
                              dataRowHeight: 40.0,
                              horizontalMargin: 16,
                              columnSpacing: 16,
                              wrapInCard: false,
                              headingRowColor: WidgetStateProperty.all(
                                const Color(0xFF112D4E),
                              ),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              dataTextStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 13,
                              ),
                              dividerThickness: 0.5,
                              rowsPerPage: provider!.rowsPerPageSbiTransDet,
                              availableRowsPerPage: const [10, 20, 50],
                              onRowsPerPageChanged: (value) {
                                provider!
                                    .updateRowsPageSbiTransDet(data: value!);
                              },
                              showFirstLastButtons: true,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn2(
                                  label: Center(
                                      child: Text('CorporateId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('InstrumentValueDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Amount', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BeneName',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('IFSCCode',
                                          style: _tableRowHead)),
                                  size: ColumnSize.M,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BeneAccountNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('LoanNo', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('PayDate',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child:
                                          Text('Status', style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BanRefNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('TransId',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('Description',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                                DataColumn2(
                                  label: Center(
                                      child: Text('BatchNo',
                                          style: _tableRowHead)),
                                  size: ColumnSize.S,
                                ),
                              ],
                              source: DocIdDataSource4(
                                  SbiTransDet ?? [], provider, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              )
      ],
    );
  }
}

class DocIdDataSource1 extends DataTableSource {
  final List<OglReImpSendDet> data;
  final PaymentOGLReportController? provider;
  final BuildContext context;

  DocIdDataSource1(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.cORPORATEID ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRADT?.split('T')[0] ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANK ?? '-', style: _tableRowTxtStyle))),
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

class DocIdDataSource2 extends DataTableSource {
  final List<OglRptImpsResDt> data;
  final PaymentOGLReportController? provider;
  final BuildContext context;

  DocIdDataSource2(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.tRANREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRADT?.split('T').first ?? '_',
                style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.aCTCODE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.rESPONSE ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANKRRN ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKREFNUM ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bANK ?? '-', style: _tableRowTxtStyle))),
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

class DocIdDataSource3 extends DataTableSource {
  final List<OglRptneftSftDet> data;
  final PaymentOGLReportController? provider;
  final BuildContext context;

  DocIdDataSource3(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.uNIQUEREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.pAYDATE?.split('T').first ?? '_',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRAUTRNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.cHQNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.sTATUS ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.sTATUSDESC ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child:
                Text(item.bENEFICIARYACCNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.tRADATE?.split('T').first ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bATCHNO ?? '-', style: _tableRowTxtStyle))),
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

class DocIdDataSource4 extends DataTableSource {
  final List<OglRptSbiTransDet> data;
  final PaymentOGLReportController? provider;
  final BuildContext context;

  DocIdDataSource4(this.data, this.provider, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    Color rowColor = index.isEven ? Colors.white : AppColor.tableRowColor;
    return DataRow2(
      color: WidgetStateProperty.all(rowColor),
      cells: [
        DataCell(Center(
            child: Text(item.cUSTOMERREFNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.iNSTRUMENTVALUEDATE?.split('T').first ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.aMOUNT ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bENENAME ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.iFSCCODE ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bENEACCNUMBER ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.lOANNO ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.pAYDATE?.split('T').first ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.pAYSTATUS ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.bANKREFNO?.split('T').first ?? '-',
                style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.tRANSID ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text(item.dESCRIPTION ?? '-', style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.bATCHNO ?? '-', style: _tableRowTxtStyle))),
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
  color: Colors.white,
);
