import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/network/api_endpoints.dart';
import '../../../core/helpers/network/network_api_services.dart';

class DrawerRepository {
  final _apiService = NetworkApiServices();
  final _appCacheHelper = AppCacheHelper();
  final _appDecryptHelper = AppEncryptionHelper();
  Future<dynamic> getMainMenu() async {
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final encryptToken = await _appCacheHelper.getData("token");
    String p_flag = "MENULOADPAYMENTS";
    final p_pageval = "GETPAYMENTSMAINMENU*$_decrptEmpId*1";
    String p_paraval = "1";
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.menuBaseUrl}$p_flag/$p_pageval/$p_paraval",
        );
    return response;
  }
}
