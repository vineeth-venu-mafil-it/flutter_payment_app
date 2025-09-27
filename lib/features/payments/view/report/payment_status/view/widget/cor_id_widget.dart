import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/config/styles/colors.dart';
import '../../controller/payment_status_controller.dart';
import '../../model/cor_id_model1.dart';
import '../../model/cor_id_model2.dart';
import '../../model/cor_id_model3.dart';

class CorIdWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final PaymentStatusProvider? provider;
  const CorIdWidget({super.key, this.width, this.height, this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFCCC6C6)),
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
                        minWidth: 600, // Adjusted based on column requirements
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
                        rowsPerPage: provider!.rowsPerPageSeq1,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('ImpsTransNo', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TraDate', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: CorIdDataSource1(
                            provider!.corId1DataList ?? [], provider, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFCCC6C6)),
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
                        minWidth: 2000, // Adjusted based on column requirements
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
                        rowsPerPage: provider!.rowsPerPageSeq1,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('Corporate ID', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction Date',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Response Code',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Response', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank RRN', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank Reference Number',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Transaction ID',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('Bank', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: CorIdDataSource2(
                            provider!.corId2DataList ?? [], provider, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFFCCC6C6)),
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
                        minWidth: 2000, // Adjusted based on column requirements
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
                        rowsPerPage: provider!.rowsPerPageSeq1,
                        availableRowsPerPage: const [10, 20, 50],
                        onRowsPerPageChanged: (value) {
                          provider!.updateRowsPageSeq1(data: value!);
                        },
                        showFirstLastButtons: true,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn2(
                            label: Center(
                                child: Text('UNIQUE_REF_NO',
                                    style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('PAY_DATE', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('TRA_UTR_NO', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('CHQ_NO', style: _tableRowHead)),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('STATUS', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('STATUS_DESC', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child:
                                    Text('BANK_REF_NO', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('AMOUNT', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('BENEFICIARY_ACC_NO',
                                    style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TRA_DATE', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('TRANSID', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(
                                child: Text('BATCH_NO', style: _tableRowHead)),
                            size: ColumnSize.S,
                          ),
                        ],
                        source: CorIdDataSource3(
                            provider!.corId3DataList ?? [], provider, context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}

class CorIdDataSource1 extends DataTableSource {
  final List<CorIdResponse1> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  CorIdDataSource1(this.data, this.provider, this.context);
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
        DataCell(
            Center(child: Text(item.tRADT ?? '-', style: _tableRowTxtStyle))),
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

class CorIdDataSource2 extends DataTableSource {
  final List<CorIdResponse2> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  CorIdDataSource2(this.data, this.provider, this.context);
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
        DataCell(
            Center(child: Text(item.tRADT ?? '-', style: _tableRowTxtStyle))),
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

class CorIdDataSource3 extends DataTableSource {
  final List<CorIdResponse3> data;
  final PaymentStatusProvider? provider;
  final BuildContext context;

  CorIdDataSource3(this.data, this.provider, this.context);
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
        DataCell(
            Center(child: Text(item.pAYDATE ?? '-', style: _tableRowTxtStyle))),
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
        DataCell(
            Center(child: Text(item.aMOUNT ?? '-', style: _tableRowTxtStyle))),
        DataCell(Center(
            child: Text("${item.bENEFICIARYACCNO ?? '-'}", style: _tableRowTxtStyle))),
        DataCell(
            Center(child: Text(item.tRADATE ?? '-', style: _tableRowTxtStyle))),
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

const _tableRowTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: AppColor.cardTitleSubColor,
);
const _tableRowHead = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 12,
  color: Colors.white,
);
