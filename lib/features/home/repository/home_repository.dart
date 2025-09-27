import '../../../../../../core/helpers/network/network_api_services.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/network/api_endpoints.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();
  final appCacheHelper = AppCacheHelper();
  final appDecryptHelper = AppEncryptionHelper();
  Future<dynamic> sessionApi(var data) async {
    dynamic response = await _apiService.postApi(data, ApiEndPoints.portalURL);
    return response;
  }

  Future<dynamic> employeeDetails() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    final encryptToken = await appCacheHelper.getData("token");
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseUrlGet}${ApiEndPoints.empDetails}$_decrptEmpId/${1}",
        token: encryptToken);
    return response;
  }

  Future<dynamic> validateToken(var data) async {
    dynamic response =
        await _apiService.postApi(data, ApiEndPoints.validateToken);
    return response;
  }
}
