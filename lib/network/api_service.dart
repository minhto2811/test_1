
import 'package:dio/dio.dart';
import 'package:test_1/contants/constants.dart';
import 'package:test_1/network/address_model.dart';

abstract interface class ApiService{
  Future<List<AddressModel>> searchByText(String text);
}


class ApiServiceIpml extends ApiService {
  final Dio _dio;

  ApiServiceIpml(this._dio);

  @override
  Future<List<AddressModel>> searchByText(String text) async {
    final response = await _dio.get(Constants.API, queryParameters: {"q": text});
    if (response.statusCode == 200) {
      return (response.data['items'] as List).map((e) => AddressModel.fromJson(e)).toList();
    }
    return [];
  }


}