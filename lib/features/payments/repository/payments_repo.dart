import '../../../../../../core/helpers/network/network_api_services.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/network/api_endpoints.dart';

class PaymentsRepository {
  final _apiService = NetworkApiServices();
  final appCacheHelper = AppCacheHelper();
  final appDecryptHelper = AppEncryptionHelper();
  ///Payment Tab Menu
  Future<dynamic> getSubMenu({required String mainMenuId}) async {
    final _encrptEmpId = await appCacheHelper.getData("empCode");
    final _decrptEmpId = appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final encryptToken = await appCacheHelper.getData("token");
    String p_flag = "MENULOADPAYMENTS";
    final p_pageval = "GETPAYMENTSSUBMENU*$_decrptEmpId~$mainMenuId*1";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.menuBaseUrl}$p_flag/$p_pageval/$p_paraval");
    return response;
  }

  Future<dynamic> getChildMenu({required String mainMenuId,required String subMenuId}) async {
    final _encrptEmpId = await appCacheHelper.getData("empCode");
    final _decrptEmpId = appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final encryptToken = await appCacheHelper.getData("token");
    String p_flag = "MENULOADPAYMENTS";
    final p_pageval = "GETPAYMENTSCHILDMENU*$_decrptEmpId~$mainMenuId~$subMenuId*1";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.menuBaseUrl}$p_flag/$p_pageval/$p_paraval");
    return response;
  }


  Future<dynamic> chkImpsStatus() async {
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = appCacheHelper.getData("empCode");
    final decrptEmpId = await appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}${ApiEndPoints.impsAccess}$decrptEmpId/${1}");
    return response;
  }

  ///Customer Neft details
  Future<dynamic> chkCusNeftDetAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "CUSTOMER_NEFT_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Change debit advise branch
  Future<dynamic> changeDebitAdviseAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "BRANCH_CHANGE_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }
}
