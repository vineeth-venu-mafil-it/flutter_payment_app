import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_payment_app/features/payments/view/payments/reini_sus_pay_req/model/trans_status.dart';
import 'package:go_router/go_router.dart';
import 'package:xml/xml.dart';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/bank_model.dart';
import '../model/branch_model.dart';
import '../model/cust_details.dart';
import '../model/trans_details.dart';
import '../model/trans_model.dart';
import '../model/transaction_model.dart';
import '../repository/reini_sus_pay_req_repo.dart';

class ReiniSusPayReqProvider extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController docTypeController = TextEditingController();
  final TextEditingController transController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final _api = ReiniSusPayReqRepo();

  ///Radio -- select,search
  String selectedType = '1';
  void updateSelectedType(String value, BuildContext context) {
    selectedType = value;
    if (value == '1') {
      bankList = [];
    } else if (value == '2') {
      curDate = 'Select date';

      fetchBank(context: context, payMode: selectedPayMode);
    }
    notifyListeners();
  }

  String selectedPayMode = '1';
  void updateSelectedPayMode(String value, BuildContext context) {
    selectedPayMode = value;
    if (value == '1' && selectedType == '2') {
      selectedBank = '';
      fetchBank(context: context, payMode: selectedPayMode);
    } else if (value == '2' && selectedType == '2') {
      selectedBank = '';
      fetchBank(context: context, payMode: selectedPayMode);
    }
    notifyListeners();
  }

  String selectedDocType = '1';
  void updateSelectedDocType(String value) {
    selectedDocType = value;
    notifyListeners();
  }

  ///reset selection
  void resetSelection() {
    docTypeController.clear();
    curDate = 'Select date';
    selectedBank = '';
    bankList = [];
    selectedBranch = '';
    branchList = [];
    selectedTrans = '';
    transList = [];
    resetTableData();

    notifyListeners();
  }

  Future<void> setData({required BuildContext context}) async {
    try {
      await reIniSusPayReqAccess(context: context);
      // if (!context.mounted) return;
      // await fetchBranch(context: context);
    } catch (e) {
      if (kDebugMode) {
        print("Error in setData: $e");
      }
      if (context.mounted) {
        CustomToast.showCustomErrorToast(message: "Failed to load data");
      }
    }
  }

  ///Select date
  String curDate = 'Select date';
  void updateDate({required String date}) {
    curDate = date;
    notifyListeners();
  }

  ///Api call
  ///Access
  Future<void> reIniSusPayReqAccess({required BuildContext context}) async {
    try {
      final response = await _api.reIniSusPayReqAccess();

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

  ///Transactions
  List<TransModel> transList = [];
  String? selectedTrans = '';
  void setTransaction({required String value}) {
    selectedTrans = value;
    notifyListeners();
  }

  Future<void> fetchTransDrop({required BuildContext context}) async {
    try {
      final data = selectedType == '1'
          ? "search~$selectedPayMode*$selectedDocType*${docTypeController.text.trim()}"
          : "select~$selectedPayMode*$selectedBank*$selectedBranch*$curDate";
      final flag = selectedType == '1'
          ? "PAYMENTS_REN_RQ_GET_TRANS_SEARCH"
          : "PAYMENTS_REN_RQ_GET_TRANS_SELECT";
      final response = await _api.fetchTransDrop(mode: data, flag: flag);

      if (response != null && response['status'] == 200) {
        transList = [];
        final items = (response['data']['RES'] as List)
            .map((item) => TransModel.fromJson(item))
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

  ///Bank
  List<BankModel> bankList = [];
  String? selectedBank = '';
  void setBank({required String value}) {
    selectedBranch = '';
    branchList = [];
    selectedTrans = '';
    transList = [];
    resetTableData();
    selectedBank = value;

    notifyListeners();
  }

  void resetTableData() {
    payBankId = '';
    custDetails = [];
    transDetails = [];
    transStatus = [];
    iciciBank = [];
  }

  Future<void> fetchBank(
      {required BuildContext context, String? payMode}) async {
    try {
      final response = await _api.fetchBank(payMode: payMode);

      if (response != null && response['status'] == 200) {
        bankList = [];
        final items = (response['data']['RES'] as List)
            .map((item) => BankModel.fromJson(item))
            .toList();
        bankList = items;
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

  ///Branch
  List<BranchModel> branchList = [];
  String? selectedBranch = '';
  void setBranch({required String value}) {
    selectedTrans = '';
    transList = [];
    resetTableData();
    selectedBranch = value;
    notifyListeners();
  }

  Future<void> fetchBranch(
      {required BuildContext context,
      String? payMode,
      String? bankId,
      String? frmDate}) async {
    try {
      final response = await _api.fetchBranch(
          payMode: payMode, bankId: bankId, frmDate: frmDate);

      if (response != null && response['status'] == 200) {
        branchList = [];
        final items = (response['data']['RES'] as List).map((item) {
          return BranchModel.fromJson(item);
        }).toList();
        branchList = items;

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
  List<CustDetails> custDetails = [];
  List<TransDetails> transDetails = [];
  List<TransStatus> transStatus = [];
  String payBank = '';
  Future<void> changeTransaction(
      {required BuildContext context,
      String? payMode,
      String? transNum}) async {
    try {
      final response =
          await _api.changeTransaction(payMode: payMode, transNum: transNum);

      if (response != null && response['status'] == 200) {
        if (response['data']['cust_details'] != null &&
            (response['data']['cust_details'] as List).isNotEmpty) {
          custDetails = [];
          final items = (response['data']['cust_details'] as List).map((item) {
            return CustDetails.fromJson(item);
          }).toList();
          custDetails = items;
        }

        if (response['data']['trans_details'] != null &&
            (response['data']['trans_details'] as List).isNotEmpty) {
          transDetails = [];
          final items2 =
              (response['data']['trans_details'] as List).map((item) {
            return TransDetails.fromJson(item);
          }).toList();
          transDetails = items2;
        }

        if (response['data']['trans_status'] != null &&
            (response['data']['trans_status'] as List).isNotEmpty) {
          transStatus = [];
          final items2 = (response['data']['trans_status'] as List).map((item) {
            return TransStatus.fromJson(item);
          }).toList();
          transStatus = items2;
        }
        if (response['data']['RES'] != null &&
            (response['data']['RES']).isNotEmpty) {
          final cor_id = response['data']['RES'].split('~')[1];
          payBank = response['data']['RES'].split('~')[0];

          if (selectedType == '2' && payBank == '1') {
            final bankService = response['data']['bankService'];
            List<String?> parts = bankService.split('~');
            iciciBank = [];
            transaction = Transaction(
              actCode: parts[2],
              response: parts[3],
              bankRRN: parts[4],
              tranRefNo: parts[1],
              paymentRef: parts[5],
              tranDateTime: parts[6],
              amount: parts[7],
              beneMMID: parts[8],
              beneMobile: parts[9],
              beneAccNo: parts[10],
              beneIFSC: parts[12],
              beneName: parts[11],
              remMobile: parts[14],
              remName: parts[13],
              retailerCode: parts[15],
            );
            iciciBank.add(transaction);
          }
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

  ///ICICI Imps status webservice --iciciimpsstatus
  String? resultWebService;
  Transaction transaction = Transaction();
  List<Transaction> iciciBank = [];
  int _rowsPerPage = 10;
  int get rowsPerPage => _rowsPerPage;
  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  String payBankId = '';
  Future<void> iciciImpsStatusWebService({
    required BuildContext context,
    required dynamic corId,
  }) async {
    try {
      final cor_Id = corId;
      String soapBody = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <iciciimpsstatus xmlns="http://tempuri.org/">
      <transRefNo>$cor_Id</transRefNo>
    </iciciimpsstatus>
  </soap:Body>
</soap:Envelope>
''';
      final response = await _api.iciciImpsStatusWebService(soapBody: soapBody);

      if (response != null && response['status'] == 200) {
        final document = XmlDocument.parse(response['data']);

        final result = document
            .findAllElements('iciciimpsstatusResult',
                namespace: 'http://tempuri.org/')
            .map((element) => element.text)
            .first;
        final values = result.split('~');
        payBankId = values[0];
        if (values[0] == "1") {
          resultWebService = result;
          List<String?> parts = resultWebService!.split('~');
          iciciBank = [];
          transaction = Transaction(
            actCode: parts[2],
            response: parts[3],
            bankRRN: parts[4],
            tranRefNo: parts[1],
            paymentRef: parts[5],
            tranDateTime: parts[6],
            amount: parts[7],
            beneMMID: parts[8],
            beneMobile: parts[9],
            beneAccNo: parts[10],
            beneIFSC: parts[12],
            beneName: parts[11],
            remMobile: parts[14],
            remName: parts[13],
            retailerCode: parts[15],
          );
          iciciBank.add(transaction);
          notifyListeners();
        } else if (values[0] == "1") {
          resultWebService = null;
          notifyListeners();
        }
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    }
  }
}
