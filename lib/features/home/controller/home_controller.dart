import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/routes/app_route_name.dart';

import '../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/emp_detail_model.dart';
import '../repository/home_repository.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  HomeProvider() {
    TimeProvider();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  ///date and time

  String _currentTime = '';
  late Timer _timer;

  String get currentTime => _currentTime;

  TimeProvider() {
    _updateTime();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    _currentTime = DateFormat('h:mm a').format(now);
    notifyListeners();
  }

  ///Api calls
  //handle session

  final _api = HomeRepository();
  final appCacheHelper = AppCacheHelper();
  final appEncryptionHelper = AppEncryptionHelper();
  Future<void> sessionApi(
      {required BuildContext context,
      required String curSession,
      required String token}) async {
    try {
      isLoading = true;
      notifyListeners();
      var data = {"data": curSession.trim()};
      final response = await _api.sessionApi(data);

      if (response != null && response['status'] == 200) {
        if (response['data']['response'] != null) {
          final splitRes = "${response['data']['response']}".split('|');
          final empCode = splitRes[2].split('!');

          final encryptEmpCode = appEncryptionHelper.encryptData(
              data: empCode[0].toString(),
              baseKey: EncryptionValue.keyAsString,
              ivKey: EncryptionValue.ivAsString);
          appCacheHelper.saveData(key: 'empCode', value: encryptEmpCode);

          if (context.mounted) {
            await validateToken(token: token, context: context);
          }
          notifyListeners();
        } else {
          CustomToast.showCustomToast(message: "Unexpected error occurred");
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
        print("Error $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  var empDetailModel = EmpDetailModel();
  Future<void> employeeDetails({required BuildContext context}) async {
    try {
      final response = await _api.employeeDetails();

      if (response != null && response['status'] == 200) {
        empDetailModel = EmpDetailModel.fromJson(response['data']);
        final encryptBranchId = appEncryptionHelper.encryptData(
            data: "${empDetailModel.response!.first.bRANCHID}",
            baseKey: EncryptionValue.keyAsString,
            ivKey: EncryptionValue.ivAsString);
        final encryptBranchName = appEncryptionHelper.encryptData(
            data: "${empDetailModel.response!.first.bRANCHNAME}",
            baseKey: EncryptionValue.keyAsString,
            ivKey: EncryptionValue.ivAsString);
        appCacheHelper.saveData(key: 'branchID', value: encryptBranchId);
        appCacheHelper.saveData(key: 'branchName', value: encryptBranchName);
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

  Future<void> validateToken(
      {required String? token, required BuildContext context}) async {
    try {
      var data = {"Indata": token};
      final response = await _api.validateToken(data);
      if (response != null && response['status'] == 200) {
        String data = "${response['data']['response']}";
        final token = await decryption(data);
        appCacheHelper.saveData(
            key: 'token',
            value:
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJtYW5hcHB1cmFtIiwianRpIjoiNmMyMGYwMmMtMTIwYy00MDQxLWE1YmUtZmM5NTQ1ZTA2YWQ4IiwiaWF0IjoxNzU4OTU0NDgxLCJlbXBDb2RlIjoiNjAwNDkiLCJlbXBOYW1lIjoiUFJBVkVFTiBQIiwiam9pbkR0IjoiMDIvMTQvMjAxMSAwMDowMDowMCIsIm5iZiI6MTc1ODk1NDQ4MSwiZXhwIjoxNzU4OTU2MjgxfQ.U3Mq_PiZG1wzzm1NUP5JBVzoCeW5rj6R4koS_bib_wc');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.goNamed(RoutesName.home);
        });
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

  Future<String?> decryption(String text) async {
    final key = encrypt.Key.fromUtf8("8080808080808080");
    final iv = encrypt.IV.fromUtf8("8080808080808080");
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
    return encrypted;
  }

  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;

  set loadingIndex(int value) {
    _loadingIndex = value;
  }

  @override
  void dispose() {
    _timer.cancel();
    searchController.clear();
    super.dispose();
  }
}
