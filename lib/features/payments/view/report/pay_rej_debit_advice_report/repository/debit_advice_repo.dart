import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class DebitAdviceRepo {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  ///access
  Future<dynamic> PayRejDebitAdviceAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "PAY_REJ_DEBIT_ADVISE_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get branch
  Future<dynamic> fetchBranch() async {
    final encryptToken = await appCacheHelper.getData("token");
    final branchId = await appCacheHelper.getData("branchID");

    final p_pageval = appDecryptHelper.decryptData(
        data: branchId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "PAY_REJ_DEBIT_ADVISE_GET_BRANCH";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }



  ///OGL report
  Future<dynamic> fetchDebitAdviceReport(
      {
        required String brId,
        required String status,
        required String frmDate,
        required String toDate}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = "$brId*$status*$frmDate*$toDate";
    String p_flag = "PAY_REJ_DEBIT_ADVISE_GEN_REPORT";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }




}
