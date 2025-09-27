import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/api_endpoints.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';
import '../../../../../../core/helpers/network/network_soap_api_service.dart';

class ReiniSusPayReqRepo {
  final _apiService = NetworkApiServices();
  final _apiSoapService = NetworkSoapApiServices();
  final appDecryptHelper = AppEncryptionHelper();
  final appCacheHelper = AppCacheHelper();

  Future<dynamic> reIniSusPayReqAccess() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final encryptToken = await appCacheHelper.getData("token");
    final p_pageval = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    String p_flag = "PAYMENTS_REN_RQ_ACCESS";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Transactions
  Future<dynamic> fetchTransDrop({String? mode, String? flag}) async {
    final p_pageval = mode!.split('~')[1];
    String p_flag = "$flag";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Bank
  Future<dynamic> fetchBank({String? payMode}) async {
    final p_pageval = payMode;
    String p_flag = "PAYMENTS_REN_GET_BANK";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;

  }

  ///Branch
  Future<dynamic> fetchBranch(
      {String? payMode, String? bankId, String? frmDate}) async {
    final p_pageval = "$payMode*$bankId*$frmDate";
    String p_flag = "PAYMENTS_REN_GET_BRANCH";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///Transaction change
  Future<dynamic> changeTransaction({String? payMode, String? transNum}) async {
    final p_pageval = "$payMode*$transNum";
    String p_flag = "PAYMENTS_REN_RQ_GET_TRANS_CHANGE";
    String p_paraval = "1";
    final encryptToken = await appCacheHelper.getData("token");

    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}$p_flag/$p_pageval/$p_paraval",
        token: encryptToken);
    return response;
  }

  ///ICICI Imps status webservice --iciciimpsstatus
  Future<dynamic> iciciImpsStatusWebService({String? soapBody}) async {
    String pFlag = "iciciimpsstatus";

    dynamic response = await _apiSoapService.postSoapRequest(
        "${ApiEndPoints.webServiceUrl}$pFlag", soapBody ?? '');

    return response;
  }
}
