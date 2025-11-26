import 'package:payments_application/core/helpers/network/api_endpoints.dart';

import '../../../../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/helpers/network/network_api_services.dart';

class PaymentStatusRepository {
  final _apiService = NetworkApiServices();

  ///Repo for payment status
  Future<dynamic> fetchPayStatusData(
      {required String ckBoxId, required String id}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentData}$ckBoxId*$id/1");
    return response;
  }

  ///Repo for RRNum status
  Future<dynamic> chkRRNumStatus() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptEmpId = await appCacheHelper.getData("empCode");
    final decrptEmpId = appDecryptHelper.decryptData(
        data: encrptEmpId.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentRadio}$decrptEmpId/1");
    return response;
  }

  ///Repo for  DocId1
  Future<dynamic> fetchDocIdData1({required String docId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport1}$docId/1");
    return response;
  }

  ///Repo for DocId2
  Future<dynamic> fetchDocIdData2({required String docId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport2}$docId/1");
    return response;
  }

  ///Repo for CorId1
  Future<dynamic> fetchCorIdData1({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport3}$corId/1");
    return response;
  }

  ///Repo for CorId2
  Future<dynamic> fetchCorIdData2({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport4}$corId/1");
    return response;
  }

  ///Repo for CorId3
  Future<dynamic> fetchCorIdData3({required String corId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentReport}${ApiEndPoints.getPaymentReport5}$corId/1");
    return response;
  }

  ///Repo for Customer id
  Future<dynamic> fetchCusIdImg({required String custId}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusCustId}$custId*1/1");
    return response;
  }

  ///Repo for SeqId1
  Future<dynamic> fetchSeqData1({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq1}$seqNo*1/1");
    return response;
  }

  ///Repo for SeqId2
  Future<dynamic> fetchSeqData2({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq2}$seqNo*1/1");
    return response;
  }

  ///Repo for SeqId3
  Future<dynamic> fetchSeqData3({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq3}$seqNo*1/1");
    return response;
  }

  ///Repo for SeqId4
  Future<dynamic> fetchSeqData4({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq4}$seqNo*1/1");
    return response;
  }

  ///Repo for SeqId5
  Future<dynamic> fetchSeqData5({required String seqNo}) async {
    dynamic response = await _apiService.getApi(
        "${ApiEndPoints.baseURL}${ApiEndPoints.paymentStatusSeq5}$seqNo*1/1");
    return response;
  }
}
