import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class CusNEFTDetRepository {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

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


  ///Customer Neft details
  Future<dynamic> fetchCusNEFTdata({required String custId}) async {
    final encryptToken = await appCacheHelper.getData("token");
    String p_pageval = custId.trim();
    String p_flag = "CUSTOMER_NEFT_DATA";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  Future<dynamic> fetchCusNEFTidProof({required String cusId}) async {
    final encryptToken = await appCacheHelper.getData("token");
    String p_pageval = cusId.trim();
    String p_flag = "CUSTOMER_NEFT_IDPROOF";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }
}
