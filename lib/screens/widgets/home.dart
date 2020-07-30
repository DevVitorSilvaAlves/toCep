import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tocep/screens/widgets/card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cep;
  String resultJsonUf = '';
  String resultJsonRua = '';
  String resultJsonBairro = '';
  String resultJsonLocalidade = '';
  String resultJsonComplemento = '';
  TextEditingController textField = TextEditingController();

  getTextInputField() {
    String cepRequested = textField.text;
    makeRequestApi(cepRequested);
  }

  makeRequestApi(cepRequested) async {
    String url = 'https://viacep.com.br/ws/${cepRequested}/json/';
    http.Response response = await http.get(url);
    decodesJsonToMap(response);
  }

  decodesJsonToMap(response) {
    Map<dynamic, dynamic> responseJson = json.decode(response.body);
    showResponseApi(responseJson);
  }

  void showResponseApi(responseJson) {
    resultJsonUf = responseJson['uf'];
    resultJsonRua = responseJson['logradouro'];
    resultJsonBairro = responseJson['bairro'];
    resultJsonLocalidade = responseJson['localidade'];
    resultJsonComplemento = responseJson['complemento'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textField,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    CardListTile('Rua: ', resultJsonRua),
                    CardListTile('Bairro: ', resultJsonBairro),
                    CardListTile('Localidade: ', resultJsonLocalidade),
                    CardListTile('Complemento: ', resultJsonComplemento),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: getTextInputField,
        child: Icon(
          Icons.search,
          size: 28,
        ),
        elevation: 4,
      ),
      //
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
