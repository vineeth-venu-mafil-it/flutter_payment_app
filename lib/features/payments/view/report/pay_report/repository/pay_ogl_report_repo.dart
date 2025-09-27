import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class PayReportRepo {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  ///access
  Future<dynamic> payReportAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "PAY_REPORT_ACCESS";
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
    String p_flag = "PAY_REPORT_GET_BRANCH";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get module
  Future<dynamic> fetchModule() async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = "1";
    String p_flag = "PAY_REPORT_GET_MODULE";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get bank
  Future<dynamic> fetchBank({required String payType}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = payType;
    String p_flag = "PAY_REPORT_GET_BANK";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///OGL report
  Future<dynamic> fetchOglReport(
      {required String modId,
      required String payType,
      required String payBank,
      required String brId,
      required String status,
      required String frmDate,
      required String toDate}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = "$modId*$payType*$payBank*$brId*$status*$frmDate*$toDate";
    String p_flag = "PAYMENT_REPORT_GENERATE";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get doc id
  Future<dynamic> fetchDocId({required String docId}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = docId;
    String p_flag = "PAYMENT_REPORT_GET_DOCID";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get doc id
  Future<dynamic> fetchCusId({required String cusId}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = cusId;
    String p_flag = "PAYMENT_REPORT_GET_CUSID";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get cor id
  Future<dynamic> fetchCorId({required String corId}) async {
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = corId;
    String p_flag = "PAYMENT_REPORT_GET_COPID";
    String p_paraval = "1";

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }
}
