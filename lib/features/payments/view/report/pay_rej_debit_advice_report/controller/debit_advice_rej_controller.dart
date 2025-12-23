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
import 'package:pdf/widgets.dart' as pw;
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';

import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../report/pay_rej_debit_advice_report/model/branch_model.dart';

import '../../../report/pay_rej_debit_advice_report/model/pay_report_model.dart';

import '../repository/debit_advice_repo.dart';

class PayRejDebitAdviceRptController extends ChangeNotifier {
  final FocusNode focusNode = FocusNode();
  bool isLoading = false;
  final _api = DebitAdviceRepo();
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
    {"Value": "-1", "Text": "-----ALL-----"},
    {"Value": "2", "Text": "PENDING"},
    {"Value": "3", "Text": "PAID"},
  ];

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  ///Api
  ///Access

  Future<void> PayRejDebitAdviceRptAccess(
      {required BuildContext context}) async {
    try {
      final response = await _api.PayRejDebitAdviceAccess();

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
  int? selectedBranchId;
  String? selectedBranch = '';
  void setSelectedBranch(
      {required String value, required BuildContext context}) {
    for (var e in branch) {
      if (e.bRANCH == value) {
        selectedBranchId = int.parse("${e.bRANCHID}");
        selectedBranch = e.bRANCH;
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

  ///DebitAdviceReportModel report
  List<DebitAdviceReportModel> debitAdviceReport = [];

  Future<void> fetchdebitAdviceReport(
      {required BuildContext context,
      required String brId,
      required String status,
      required String frmDate,
      required String toDate}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.fetchDebitAdviceReport(
        brId: brId,
        status: status,
        frmDate: frmDate,
        toDate: toDate,
      );

      if (response != null && response['status'] == 200) {
        debitAdviceReport = [];
        print(response['data']['response'][0]['neft_det']);
        final result = response['data']['response'][0]['neft_det'];
        if (result != null && result is List && result.isNotEmpty) {
          final item = (response['data']['response'][0]['neft_det'] as List)
              .map((item) => DebitAdviceReportModel.fromJson(item))
              .toList();
          debitAdviceReport = item;
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

  void resetSelection() {
    isLoading = false;
    selectedStatusWise = '';
    selectedBranch = '';
    debitAdviceReport = [];

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
