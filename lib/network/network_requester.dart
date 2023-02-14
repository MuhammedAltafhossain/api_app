import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/productClass.dart';
class NetworkRequester {
  Future<bool> deleteProduct(String productId) async {
    String url = 'https://crud.devnextech.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return true;

    } else {
      return false;
    }
  }

  Future getProductListFromApi() async {
    String url = 'https://crud.devnextech.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      return false;
    }
  }
}


