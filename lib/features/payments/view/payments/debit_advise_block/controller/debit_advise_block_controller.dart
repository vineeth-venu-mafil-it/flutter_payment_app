import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/payments/debit_advise_block/model/cust_acc_det_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/branch_model.dart';
import '../model/trans_det.dart';
import '../model/trans_det_model.dart';
import '../model/transaction_model.dart';
import '../repository/debit_advise_block_repo.dart';

class DebitAdviseBlockProvider extends ChangeNotifier {
  final TextEditingController branchController = TextEditingController();
  final TextEditingController transController = TextEditingController();
  final _api = DebitAdviseBlockRepo();
  bool isLoading = false;

  ///Radio -- block,release
  String selectedType = '1';
  void updateSelectedType(String value, BuildContext context) {
    selectedType = value;
    if (value == '1') {
      resetSelection();
      fetchBranch(context: context, type: selectedType);
    } else if (value == '2') {
      resetSelection();
      fetchBranch(context: context, type: selectedType);
    }
    notifyListeners();
  }

  void resetSelection() {
    selectedBranch = '';
    selectedTrans = '';
    transList = [];
    branch = [];
    transDet = [];
    custAccDetails = [];
  }

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  ///Api call
  ///Access
  Future<void> debitAdviseBlockAccess({required BuildContext context}) async {
    try {
      final response = await _api.debitAdviseBlockAccess();

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
          await fetchBranch(context: context, type: selectedType);
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

  ///get branch
  List<BranchModel> branch = [];
  String? selectedBranch = '';
  void setBranch({required String value}) {
    selectedBranch = value;
    selectedTrans = '';
    transList = [];
    transDet = [];
    custAccDetails = [];
    notifyListeners();
  }

  Future<void> fetchBranch(
      {required BuildContext context, required String type}) async {
    try {
      final response = await _api.fetchBranch(type: type);

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

  ///Transactions
  List<TransactionModel> transList = [];
  String? selectedTrans = '';
  void setTransaction({required String value}) {
    selectedTrans = value;
    notifyListeners();
  }

  Future<void> fetchTransaction(
      {required BuildContext context,
      required String type,
      required String branchId}) async {
    try {
      final response =
          await _api.fetchTransDrop(type: type, branchId: branchId);

      if (response != null && response['status'] == 200) {
        transList = [];
        final items = (response['data']['RES'] as List)
            .map((item) => TransactionModel.fromJson(item))
            .toList();
        transList = items;

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

  ///Transaction change
  List<TransDetailsModel> transStatus = [];
  List<TransDet> transDet = [];
  List<CustAccModel> custAccDetails = [];
  TransDet transaction = TransDet();
  Future<void> changeTransaction(
      {required BuildContext context,
      required String type,
      required String seqNum}) async {
    try {
      final response = await _api.changeTransaction(type: type, seqNum: seqNum);

      if (response != null && response['status'] == 200) {
        if (response['data']['trans_details'] != null &&
            (response['data']['trans_details'] as List).isNotEmpty) {
          transStatus = [];
          final items = (response['data']['trans_details'] as List)
              .map((item) => TransDetailsModel.fromJson(item))
              .toList();
          transStatus = items;
          final data = transStatus.first.tRANSDETAILS;
          List<String?> parts = data!.split('~');
          transDet = [];
          transaction = TransDet(
              docId: parts[0],
              amount: parts[1],
              corporateId: parts[3],
              custName: parts[4],
              settlTransId: parts[5],
              valueDate: parts[2]);
          transDet.add(transaction);
        }

        if (response['data']['cust_acc_details'] != null &&
            (response['data']['cust_acc_details'] as List).isNotEmpty) {
          custAccDetails = [];
          final items2 =
              (response['data']['cust_acc_details'] as List).map((item) {
            return CustAccModel.fromJson(item);
          }).toList();
          custAccDetails = items2;
        }

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

  ///btn submit
  Future<void> btnSubmit({
    required BuildContext context,
    required String type,
    required String seqNum,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.btnSubmit(type: type, seqNum: seqNum);

      if (response != null && response['status'] == 200) {
        resetSelection();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Success',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              context.pop();
            },
          );
        });
        if (!context.mounted) return;
        await fetchBranch(context: context, type: selectedType);
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

  @override
  void dispose() {
    resetSelection();
    super.dispose();
  }
}
