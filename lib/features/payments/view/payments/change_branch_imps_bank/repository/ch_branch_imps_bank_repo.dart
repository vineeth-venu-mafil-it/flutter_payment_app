import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class ChangeBranchImpsRepo {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  ///Change debit advise branch
  Future<dynamic> changeBrIMPSBankAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "CHANGE_BRANCH_IMPS_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Fetch table data
  Future<dynamic> fetchTableData({String? type}) async {
    final p_pageval = type;
    String p_flag = "CHANGE_BRANCH_IMPS_GET_TABLE_DATA";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///fetch bank drop
  Future<dynamic> fetchBankDrop({String? type}) async {
    final p_pageval = type;
    String p_flag = "CHANGE_BRANCH_IMPS_GET_BANK_DROP";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }
  ///submit data
  Future<dynamic> submitData({String? value}) async {
    final p_pageval = value;
    String p_flag = "CHANGE_BRANCH_IMPS_CONFIRM";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }
}
