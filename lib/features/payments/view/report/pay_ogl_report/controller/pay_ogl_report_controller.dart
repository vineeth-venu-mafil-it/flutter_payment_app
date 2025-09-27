import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';

import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../model/imps_snt_det_model.dart';
import '../model/module_model.dart';
import '../model/ogl_imps_res_det.dart';
import '../model/ogl_neft_cus_det.dart';
import '../model/ogl_report_model.dart';
import '../model/ogl_rpt_neft_sft_det.dart';
import '../model/ogl_rpt_sbi_trans_det.dart';
import '../model/ogl_trans_det.dart';
import '../model/pay_bank_model.dart';
import '../repository/pay_ogl_report_repo.dart';
import '../model/branch_model.dart';

class PaymentOGLReportController extends ChangeNotifier {
  final FocusNode focusNode = FocusNode();
  bool isLoading = false;
  final _api = PaymentOGLReportRepo();
  String selectedPayType = '';
  String selectedStatusWise = '';

  //Data table
  int _rowsPerPage = 10;

  int get rowsPerPage => _rowsPerPage;

  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  int _rowsPerPageTransDet = 10;

  int get rowsPerPageTransDet => _rowsPerPageTransDet;

  void updateRowsPageTransDet({required int data}) {
    _rowsPerPageTransDet = data;
    notifyListeners();
  }

  int _rowsPerPageNeftCusDet = 10;

  int get rowsPerPageNeftCusDet => _rowsPerPageNeftCusDet;

  void updateRowsPageNeftCusDet({required int data}) {
    _rowsPerPageNeftCusDet = data;
    notifyListeners();
  }

  int _rowsPerPageImpsSntDet = 10;

  int get rowsPerPageImpsSntDet => _rowsPerPageImpsSntDet;

  void updateRowsPageImpsSntDet({required int data}) {
    _rowsPerPageImpsSntDet = data;
    notifyListeners();
  }

  int _rowsPerPageImpsResDet = 10;

  int get rowsPerPageImpsResDet => _rowsPerPageImpsResDet;

  void updateRowsPageImpsResDet({required int data}) {
    _rowsPerPageImpsResDet = data;
    notifyListeners();
  }

  int _rowsPerPageneftSftDet = 10;

  int get rowsPerPageneftSftDet => _rowsPerPageneftSftDet;

  void updateRowsPageNeftSftDet({required int data}) {
    _rowsPerPageneftSftDet = data;
    notifyListeners();
  }

  int _rowsPerPageSbiTransDet = 10;

  int get rowsPerPageSbiTransDet => _rowsPerPageSbiTransDet;

  void updateRowsPageSbiTransDet({required int data}) {
    _rowsPerPageSbiTransDet = data;
    notifyListeners();
  }

  ///calender
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  void setSelectedPayType(String? value) {
    if (value != null) {
      selectedPayType = value;
      notifyListeners();
    }
  }

  void setToDate(String date) {
    toDateController.text = date;
    notifyListeners();
  }

  void setFromDt(String date) {
    fromDateController.text = date;
    notifyListeners();
  }

  void setSelectedStatusWise(String? value) {
    if (value != null) {
      selectedStatusWise = value;
      notifyListeners();
    }
  }

  final List<Map<String, dynamic>> payType = [
    {"Value": "1", "Text": "IMPS"},
    {"Value": "2", "Text": "SFTP"},
    {"Value": "3", "Text": "SBI"}
  ];

  final List<Map<String, dynamic>> statusWise = [
    {"Value": "1", "Text": "SUCCESS"},
    {"Value": "2", "Text": "RESPONSE PENDING"},
    {"Value": "3", "Text": "REJECTED WITH DEBIT ADVICE PENDING"},
    {"Value": "4", "Text": "REJECTED WITH DEBIT ADVICE RECEIVED"},
    {"Value": "5", "Text": "REJECTED WITH OUT DEBIT ADVICE"},
    {"Value": "6", "Text": "PAYMENT PENDING"}
  ];

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  ///Api
  ///Access

  Future<void> payOglReportAccess({required BuildContext context}) async {
    try {
      final response = await _api.payOglReportAccess();

      if (response != null && response['status'] == 200) {
        final splitResponse = response['data']['response'][0]['RES'].split('~');
        if (splitResponse[0].toString() == "0") {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Unauthorized',
              message: splitResponse[1].toString(),
              cancelText: 'Ok',
              onCancelPressed: () {
                context.pop();
                context.go('/home');
              },
            );
          });
        } else {
          if (!context.mounted) return;
          await fetchBranch(context: context);
          if (!context.mounted) return;
          await fetchModule(context: context);
        }
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///Branch
  TextEditingController branchController = TextEditingController();
  List<BranchModel> branch = [];
  int? selectedBranchId = -1;
  String? selectedBranch = '';
  void setSelectedBranch(
      {required String value, required BuildContext context}) {
    for (var e in branch) {
      if (e.BRANCH == value) {
        selectedBranchId = int.parse("${e.BRID}");
        selectedBranch = e.BRANCH;
      }
    }
    notifyListeners();
  }

  Future<void> fetchBranch({required BuildContext context}) async {
    try {
      final response = await _api.fetchBranch();

      if (response != null && response['status'] == 200) {
        branch = [];
        final items = (response['data']['RES'] as List)
            .map((item) => BranchModel.fromJson(item))
            .toList();
        branch = items;

        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///Module
  List<ModuleModel> module = [];
  String selectedModule = '';
  final TextEditingController moduleController = TextEditingController();

  void setSelectedModule(String value) {
    selectedModule = value;
    notifyListeners();
  }

  Future<void> fetchModule({required BuildContext context}) async {
    try {
      final response = await _api.fetchModule();

      if (response != null && response['status'] == 200) {
        module = [];
        final items = (response['data']['RES'] as List)
            .map((item) => ModuleModel.fromJson(item))
            .toList();
        module = items;

        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///bank
  List<PayBankModel> bank = [];
  String selectedBank = '';

  void setSelectedBank(String value) {
    selectedBank = value;
    notifyListeners();
  }

  Future<void> fetchBank(
      {required BuildContext context, required String payType}) async {
    try {
      final response = await _api.fetchBank(payType: payType);

      if (response != null && response['status'] == 200) {
        bank = [];
        final items = (response['data']['RES'] as List)
            .map((item) => PayBankModel.fromJson(item))
            .toList();
        bank = items;

        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///OGL report
  List<OGLReportModel> oglReport = [];

  Future<void> fetchOglReport(
      {required BuildContext context,
      required String modId,
      required String payType,
      required String payBank,
      required String brId,
      required String status,
      required String frmDate,
      required String toDate}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.fetchOglReport(
        modId: modId,
        payType: payType,
        payBank: payBank,
        brId: brId,
        status: status,
        frmDate: frmDate,
        toDate: toDate,
      );

      if (response != null && response['status'] == 200) {
        oglReport = [];
        final result = response['data']['result'];
        if (result != null && result is List && result.isNotEmpty) {
          final item = (response['data']['result'] as List)
              .map((item) => OGLReportModel.fromJson(item))
              .toList();
          oglReport = item;
          notifyListeners();
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No data found"),
            backgroundColor: Colors.red,
          ));
        }
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///get doc id
  List<OglTransDet> transDet = [];
  List<OglNeftCusDet> neftCusDet = [];

  Future<void> fetchDocId(
      {required BuildContext context, required String docId}) async {
    try {
      final response = await _api.fetchDocId(docId: docId);

      if (response != null && response['status'] == 200) {
        transDet = [];
        final items = (response['data']['response'][0]['trans_detail'] as List)
            .map((item) => OglTransDet.fromJson(item))
            .toList();
        transDet = items;

        neftCusDet = [];
        final items1 =
            (response['data']['response'][0]['neft_cust_details'] as List)
                .map((item) => OglNeftCusDet.fromJson(item))
                .toList();
        neftCusDet = items1;

        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///get CusId
  Future<void> fetchCusId(
      {required BuildContext context, required String cusId}) async {
    try {
      final response = await _api.fetchCusId(cusId: cusId);

      if (response != null && response['status'] == 200) {
        if (context.mounted) {
          final value = response['data']['RES'][0]['ID_PROOF'];
          if (value != null) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.memory(base64Decode(
                              "${response['data']['RES'][0]['ID_PROOF']}"))
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardListener(
                          focusNode: focusNode,
                          autofocus: true,
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey == LogicalKeyboardKey.enter) {
                              context.pop();
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
                              context.pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Ok',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("No data found"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  ///get cor id
  List<OglReImpSendDet> impsSendDtl = [];
  List<OglRptImpsResDt> impsResDet = [];
  List<OglRptneftSftDet> neftSftDet = [];
  List<OglRptSbiTransDet> SbiTransDet = [];
  bool isLoadingCorId = false;
  Future<void> fetchCorId(
      {required BuildContext context, required String corId}) async {
    try {
      final response = await _api.fetchCorId(corId: corId);
      isLoadingCorId = true;
      notifyListeners();
      if (response != null && response['status'] == 200) {
        impsSendDtl = [];
        final items = (response['data']['response'][0]['imps_send_dtl'] as List)
            .map((item) => OglReImpSendDet.fromJson(item))
            .toList();
        impsSendDtl = items;
        impsResDet = [];
        final items1 = (response['data']['response'][0]['imps_res_det'] as List)
            .map((item) => OglRptImpsResDt.fromJson(item))
            .toList();
        impsResDet = items1;
        neftSftDet = [];
        final items2 = (response['data']['response'][0]['neft_sft_det'] as List)
            .map((item) => OglRptneftSftDet.fromJson(item))
            .toList();
        neftSftDet = items2;

        SbiTransDet = [];
        final items3 =
            (response['data']['response'][0]['sbi_trans_det'] as List)
                .map((item) => OglRptSbiTransDet.fromJson(item))
                .toList();
        SbiTransDet = items3;
        isLoadingCorId = false;
        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoadingCorId = false;
      notifyListeners();
    }
  }

  ///excel
  Future<void> exportToExcel(
      List<OGLReportModel> reportData, BuildContext context) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'PaymentMode',
        'PaymentBank',
        'Module',
        'Branch',
        'BranchId',
        'DocId',
        'CustomerId',
        'CustomerName',
        'Amount',
        'TraDate',
        'CorporateId',
        'PaymentDate',
        'Response',
        'BankRRN',
        'IFSCCode',
        'BeneficiaryAccount',
        'SendTransId',
        'SequenceNo',
        'BatchNo'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < reportData.length; i++) {
        final item = reportData[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.pAYMODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.pAYBANK ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.mODULE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue("${item.bRANCHID ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.bRANCHNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.dOCID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue('${item.cUSTID ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTNAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = TextCellValue("${item.aMOUNT ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = TextCellValue(item.tRADATE?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = TextCellValue(item.cORPORATEID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = TextCellValue(item.pAYDATE?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
            .value = TextCellValue(item.rESPONSE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
            .value = TextCellValue(item.bANKRRN ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1))
            .value = TextCellValue(item.iFSCCODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: i + 1))
            .value = TextCellValue(item.bENEFICIARYACCOUNT ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: i + 1))
            .value = TextCellValue("${item.sENDTRANSID ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 17, rowIndex: i + 1))
            .value = TextCellValue(item.sEQNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 18, rowIndex: i + 1))
            .value = TextCellValue(item.bATCHNO ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'ogl_report$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excel file downloaded: $fileName')),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = await excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    }
  }

  Future<void> exportToExcelImpsSntDt(
      List<OglReImpSendDet> reportData, BuildContext context) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = ['ImpsTransNo', 'TraDate', 'Bank'];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < reportData.length; i++) {
        final item = reportData[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.cORPORATEID ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.tRADT?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.bANK ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'imps_snt_det$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
        final bytes = await excel.encode();
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excel file downloaded: $fileName')),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = await excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    }
  }

  Future<void> exportToExcelImpsResDt(
      List<OglRptImpsResDt> reportData, BuildContext context) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'CorporateId',
        'TraDate',
        'ResponseCode',
        'Response',
        'BankRRN',
        'BankRefNum',
        'TransId',
        'Bank',
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < reportData.length; i++) {
        final item = reportData[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.tRANREFNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.tRADT?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.aCTCODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.rESPONSE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.bANKRRN ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.bANKREFNUM ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue('${item.tRANSID ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue(item.bANK ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'imps_res_det$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excel file downloaded: $fileName')),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = await excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    }
  }

  Future<void> exportToExcelneftSftDet(
      List<OglRptneftSftDet> reportData, BuildContext context) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'CorporateId',
        'PayDate',
        'TraUTR_No',
        'ChqNo',
        'Status',
        'StatusDesc',
        'BankRefNo',
        'Amount',
        'BeneAccountNo'
            'TraDate',
        'TransId',
        'BatchNo'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < reportData.length; i++) {
        final item = reportData[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.uNIQUEREFNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.pAYDATE?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue(item.tRAUTRNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.cHQNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.sTATUS ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.sTATUSDESC ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue('${item.bANKREFNO ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue('${item.aMOUNT ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = TextCellValue(item.bENEFICIARYACCNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = TextCellValue(item.tRADATE?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = TextCellValue('${item.tRANSID ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = TextCellValue('${item.bATCHNO ?? ''}');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'neft_sftp_details_$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName)
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excel file downloaded: $fileName')),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = await excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    }
  }

  Future<void> exportToExcelSbiTransDet(
      List<OglRptSbiTransDet> reportData, BuildContext context) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        'CorporateId',
        'InstrumentValueDate',
        'Amount',
        'BeneName',
        'IFSCCode',
        'BeneAccountNo',
        'LoanNo',
        'PayDate',
        'Status',
        'BanRefNo',
        'TransId',
        'Description',
        'BatchNo'
      ];

      // Add headers
      for (int i = 0; i < headers.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = TextCellValue(headers[i]);
      }

      // Add data
      for (int i = 0; i < reportData.length; i++) {
        final item = reportData[i];

        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = TextCellValue(item.cUSTOMERREFNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = TextCellValue(item.iNSTRUMENTVALUEDATE
                ?.split('T')
                .first ??
            '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = TextCellValue("${item.aMOUNT ?? ''}");
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = TextCellValue(item.bENENAME ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = TextCellValue(item.iFSCCODE ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = TextCellValue(item.bENEACCNUMBER ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = TextCellValue(item.lOANNO ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = TextCellValue('${item.aMOUNT ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = TextCellValue(item.pAYDATE?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = TextCellValue(item.pAYSTATUS ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = TextCellValue(item.bANKREFNO?.split('T').first ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = TextCellValue('${item.tRANSID ?? ''}');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
            .value = TextCellValue(item.dESCRIPTION ?? '');
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
            .value = TextCellValue(item.bATCHNO ?? '');
      }
      String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
      String fileName = 'sbi_trans_det$formattedDate.xlsx';

      if (kIsWeb) {
        // Web: Trigger browser download
        final bytes = await excel.encode(); // Get the bytes of the Excel file
        if (bytes != null) {
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", fileName) // Use filename variable
            ..click();
          html.Url.revokeObjectUrl(url);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excel file downloaded: $fileName')),
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to generate Excel file')),
            );
          });
        }
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          Directory? downloadsDirectory = await getExternalStorageDirectory();
          String filePath = '${downloadsDirectory!.path}/Download/$fileName';
          File file = File(filePath);
          await file.create(recursive: true);
          final bytes = await excel.encode();
          if (bytes != null) {
            await file.writeAsBytes(bytes);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excel file saved to: $filePath')),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to generate Excel file')),
              );
            });
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Storage permission denied')),
            );
          });
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting to Excel: $e')),
        );
      });
    }
  }

  ///pdf
  Future<void> savePdfOglReport(
      List<OGLReportModel> reportData, BuildContext context) async {
    final pdf = pw.Document();
    final ByteData imageData = await rootBundle.load(
      AssetsPath.appLogo,
    );
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);
    final fontDataBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    final poppinsBold = pw.Font.ttf(fontDataBold);
    final fontDataSemiBold =
        await rootBundle.load("assets/fonts/Poppins-SemiBold.ttf");
    final poppinsSemiBold = pw.Font.ttf(fontDataSemiBold);
    final fontDataRegular =
        await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final poppinsRegular = pw.Font.ttf(fontDataRegular);
    List<String> headers = [
      'PaymentMode',
      'PaymentBank',
      'Module',
      'Branch',
      'BranchId',
      'DocId',
      'CustomerId',
      'CustomerName',
      'Amount',
      'TraDate',
      'CorporateId',
      'PaymentDate',
      'Response',
      'BankRRN',
      'IFSCCode',
      'BeneficiaryAccount',
      'SendTransId',
      'SequenceNo',
      'BatchNo'
    ];

    List<List<String>> tableData = reportData.map((item) {
      return [
        item.pAYMODE ?? '_',
        item.pAYBANK ?? '_',
        item.mODULE ?? '_',
        item.bRANCHNAME ?? '_',
        "${item.bRANCHID ?? '_'}",
        item.dOCID ?? '_',
        item.cUSTID ?? '_',
        item.cUSTNAME ?? '_',
        "${item.aMOUNT ?? '_'}",
        item.tRADATE?.split('T').first ?? '_',
        item.cORPORATEID ?? '_',
        item.pAYDATE?.split('T').first ?? '_',
        item.rESPONSE ?? '_',
        item.bANKRRN ?? '_',
        item.iFSCCODE ?? '_',
        item.bENEFICIARYACCOUNT ?? '_',
        "${item.sENDTRANSID ?? '_'}",
        "${item.sEQNO ?? '_'}",
        "${item.bATCHNO ?? '_'}",
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        header: (pw.Context context) {
          return pw.Column(children: [
            pw.Text(
              "Payments OGL Report",
              style: pw.TextStyle(
                  fontSize: 6,
                  color: const PdfColor.fromInt(0xFF051645),
                  fontWeight: pw.FontWeight.bold,
                  font: poppinsRegular),
            ),
            pw.SizedBox(height: 5)
          ]);
        },
        footer: (pw.Context context) {
          return pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(fontSize: 10, font: poppinsRegular),
            textAlign: pw.TextAlign.right,
          );
        },
        build: (pw.Context context) => [
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: tableData,
            cellAlignment: pw.Alignment.center,
            headerStyle: pw.TextStyle(
                fontSize: 6,
                color: const PdfColor.fromInt(0xFF051645),
                fontWeight: pw.FontWeight.bold,
                font: poppinsRegular),
            cellStyle: pw.TextStyle(
              fontSize: 6,
              font: poppinsRegular,
            ),
            border: pw.TableBorder.all(width: 0.5),
          ),
        ],
      ),
    );

    String formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    String fileName = 'ogl_report_$formattedDate.pdf';

    if (kIsWeb) {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'PDF file downloaded: $fileName',
            style: const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
          )),
        );
      });
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        String filePath = '/storage/emulated/0/Download/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              'PDF file saved to: $filePath',
              style:
                  const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
            )),
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Storage permission denied',
              style:
                  const TextStyle(fontSize: 12, fontFamily: 'poppinsRegular'),
            )),
          );
        });
      }
    }
  }

  ///reset selection
  void resetDocId() {
    transDet = [];
    neftCusDet = [];
  }

  void resetCorId() {
    impsSendDtl = [];
    impsResDet = [];
    neftSftDet = [];
    SbiTransDet = [];
  }

  void resetSelection() {
    isLoading = false;
    selectedPayType = '';
    selectedStatusWise = '';
    selectedBranch = '';
    selectedModule = '';
    oglReport = [];
    transDet = [];
    neftCusDet = [];
    impsSendDtl = [];
    impsResDet = [];
    neftSftDet = [];
    SbiTransDet = [];
    branchController.clear();
    branch = [];
    selectedBranchId = -1;
  }

  @override
  void dispose() {
    resetSelection();
    super.dispose();
  }
}
