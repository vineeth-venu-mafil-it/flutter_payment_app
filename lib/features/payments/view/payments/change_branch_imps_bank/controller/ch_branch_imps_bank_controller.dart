import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/bank_drop_model.dart';
import '../model/table_model.dart';
import '../repository/ch_branch_imps_bank_repo.dart';

class ChangeBranchImpsController extends ChangeNotifier {
  TextEditingController bankController = TextEditingController();
  bool isLoading = false;
  final _api = ChangeBranchImpsRepo();
  final appCacheHelper = AppCacheHelper();
  final appDecryptHelper = AppEncryptionHelper();

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  ///Radio -- IMPS, NEFT
  String selectedOptionPaymentMode = 'IMPS_BANK';
  void updateSelectedOptionPayMode(String value) {
    selectedOptionPaymentMode = value;
    notifyListeners();
  }

  ///Radio -- region,state,all
  String selectedType = '1';
  void updateSelectedType(String value) {
    selectedType = value;
    if (selectedType == '3') {
      tableDataList = [];
    }
    notifyListeners();
  }

  ///Api call
  Future<void> changeBrIMPSBankAccess({required BuildContext context}) async {
    try {
      final response = await _api.changeBrIMPSBankAccess();

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

          await fetchTableData(context: context, type: "1");
          if (!context.mounted) return;
          await fetchBankDrop(context: context, type: "IMPS_BANK");
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

  ///fetch table data
  List<TableModel> tableDataList = [];
  int _rowsPerPage = 10;
  int get rowsPerPage => _rowsPerPage;
  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  // Check box functionality
  List<int> selectedIndices = [];
  bool selectAll = false;

  bool isSelected(int index) {
    return selectedIndices.contains(index);
  }

  void toggleSelection(int index, bool isSelected) {
    if (isSelected) {
      selectedIndices.add(index);
    } else {
      selectedIndices.remove(index);
    }
    selectAll = selectedIndices.length == tableDataList.length;
    notifyListeners();
  }

  Future<void> fetchTableData(
      {required BuildContext context, String? type}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.fetchTableData(type: type);

      if (response != null && response['status'] == 200) {
        isLoading = false;
        tableDataList = [];
        selectedIndices = [];
        final items = (response['data']['response'] as List)
            .map((item) => TableModel.fromJson(item))
            .toList();
        tableDataList = items;
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
      isLoading = false;
      notifyListeners();
    }
  }

  ///submit data
  Future<void> submitData(
      {required BuildContext context,
      String? bankId,
      String? vWise,
      String? payMode}) async {
    try {
      final encrptEmpId = await appCacheHelper.getData("empCode");
      final decrptEmpId = appDecryptHelper.decryptData(
          data: encrptEmpId.toString(),
          baseKey: EncryptionValue.keyAsString,
          ivKey: EncryptionValue.ivAsString);
      String data = '';
      if (selectedType != '3') {
        for (int i = 0; i < selectedIndices.length; i++) {
          final index = selectedIndices[i];
          final item = tableDataList[index];
          data += '${item.iD}';

          if (i < selectedIndices.length - 1) {
            data += ',';
          }
        }
      } else {
        data = "0,0";
      }

      final String value = "$data*$bankId*$vWise*$decrptEmpId*$payMode";
      final response = await _api.submitData(value: value);

      if (response != null && response['status'] == 200) {
        if (!context.mounted) return;
        await fetchTableData(context: context, type: selectedType);
        selectedBank='';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Success',
            message: "${response['data']['response'][0]['RES']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              context.pop();
            },
          );
        });

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

  ///fetch bank dropdown
  List<BankDropModel> bankDropList = [];
  String selectedBank = '';

  void setSelectedBank({required String value}) {
    selectedBank = value;
    notifyListeners();
  }

  Future<void> fetchBankDrop(
      {required BuildContext context, String? type}) async {
    try {
      final response = await _api.fetchBankDrop(type: type);

      if (response != null && response['status'] == 200) {
        bankDropList = [];
        bankDropList = (response['data']['response'] as List)
            .map((item) => BankDropModel.fromJson(item))
            .toList();

        notifyListeners();
      } else {
        if (response != null && response['status'] == 500) {
          CustomToast.showCustomErrorToast(message: "${response['data']}");
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
        } else {
          CustomToast.showCustomErrorToast(
              message: "Unexpected error occurred");
        }
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    }
  }

  @override
  void dispose() {
    selectedType = '1';
    selectedBank='';
    tableDataList = [];
    selectedIndices = [];
    bankDropList = [];
    super.dispose();
  }
}
