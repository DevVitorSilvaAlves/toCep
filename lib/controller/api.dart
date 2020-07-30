import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  int cep;
  String url;
  createConnection(cep) async {
    url = 'http://viacep.com.br/ws/' + cep + '/json';
    http.Response response = await http.get(url);
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;
  }
}
