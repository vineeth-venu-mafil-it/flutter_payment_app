import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class DebitAdviseBlockRepo {
  final _apiService = NetworkApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  ///Access
  Future<dynamic> debitAdviseBlockAccess() async {
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "DEBIT_ADVISE_BLOCK_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///get branch
  Future<dynamic> fetchBranch({required String type}) async {
    final p_pageval = type;
    String p_flag = "DEBIT_ADVISE_BLOCK_GET_BRANCH";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Transactions
  Future<dynamic> fetchTransDrop(
      {required String type, required String branchId}) async {
    final p_pageval = "$type*$branchId";
    String p_flag = "DEBIT_ADVISE_BLOCK_GET_TRANSACTIONS";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Transaction change
  Future<dynamic> changeTransaction(
      {required String type, required String seqNum}) async {
    final p_pageval = "$type*$seqNum";
    String p_flag = "DEBIT_ADVISE_BLOCK_GET_TRANSACTIONS_CHANGE";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Btn submit
  Future<dynamic> btnSubmit(
      {required String type, required String seqNum}) async {
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final decrptEmpId = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final encryptToken = await appCacheHelper.getData("token");
    var data = {
      "p_flag": "DEBIT_ADVISE_BLOCK_SUBMIT",
      "p_pageval": "$type*$seqNum*$decrptEmpId",
      "p_paraval": "1"
    };
    dynamic response = await _apiService.postApi(data, ApiEndPoints.baseUrlPost,
        token: encryptToken);
    return response;
  }
}
