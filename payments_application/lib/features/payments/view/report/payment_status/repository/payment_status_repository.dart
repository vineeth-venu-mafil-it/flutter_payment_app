import 'package:payments_application/core/helpers/network/api_endpoints.dart';

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class PaymentStatusRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> fetchPayStatusData(
      {required String ckBoxId, required String id}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentData}$ckBoxId*$id/1");
    return response;
  }

  Future<dynamic> chkRRNumStatus() async {
    final _appCacheHelper = AppCacheHelper();
    final _appDecryptHelper = AppEncryptionHelper();
    final _encrptEmpId = await _appCacheHelper.getData("empCode");
    final _decrptEmpId = _appDecryptHelper.decryptData(
        data: _encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentRadio}$_decrptEmpId/1");
    return response;
  }

  Future<dynamic> fetchDocIdData1({required String docId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport1}$docId/1");
    return response;
  }

  Future<dynamic> fetchDocIdData2({required String docId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport2}$docId/1");
    return response;
  }

  Future<dynamic> fetchCorIdData1({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport3}$corId/1");
    return response;
  }

  Future<dynamic> fetchCorIdData2({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport4}$corId/1");
    return response;
  }

  Future<dynamic> fetchCorIdData3({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport5}$corId/1");
    return response;
  }

  Future<dynamic> fetchCusIdImg({required String custId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusCustId}$custId*1/1");
    return response;
  }

  Future<dynamic> fetchSeqData1({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq1}$seqNo*1/1");
    return response;
  }

  Future<dynamic> fetchSeqData2({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq2}$seqNo*1/1");
    return response;
  }

  Future<dynamic> fetchSeqData3({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq3}$seqNo*1/1");
    return response;
  }

  Future<dynamic> fetchSeqData4({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq4}$seqNo*1/1");
    return response;
  }

  Future<dynamic> fetchSeqData5({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq5}$seqNo*1/1");
    return response;
  }
}
