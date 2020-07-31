import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tocep/widgets/card.dart';
import 'favorite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String resultJsonUf = '';
  String resultJsonRua = '';
  String resultJsonBairro = '';
  String resultJsonLocalidade = '';
  String resultJsonComplemento = '';
  var suffixIconFavorite = Icons.favorite_border;

  TextEditingController textField = TextEditingController();

  makeRequestApi() async {
    String cepRequested = textField.text.toString();
    String url = 'https://viacep.com.br/ws/' + cepRequested + '/json/';
    http.Response response = await http.get(url);
    Map<dynamic, dynamic> responseJson = json.decode(response.body);
    resultValidate(responseJson);
  }

  resultValidate(responseJson) {
    List listForValidation = [
      'uf',
      'logradouro',
      'bairro',
      'localidade',
      'complemento',
    ];
    listForValidation.forEach((item) {
      if (responseJson[item].isEmpty) {
        responseJson[item] = 'Não encontrado';
      }
    });
    showResponseApi(responseJson);
  }

  showResponseApi(responseJson) {
    setState(() {
      resultJsonUf = responseJson['uf'];
      resultJsonRua = responseJson['logradouro'];
      resultJsonBairro = responseJson['bairro'];
      resultJsonLocalidade = responseJson['localidade'];
      resultJsonComplemento = responseJson['complemento'];
    });
  }

  changeFavoriteIcon() {
    if (suffixIconFavorite == Icons.favorite_border) {
      setState(() {
        suffixIconFavorite = Icons.favorite;
      });
    } else if (suffixIconFavorite == Icons.favorite) {
      setState(() {
        suffixIconFavorite = Icons.favorite_border;
      });
    }
  }

  pushFavoritePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Favorite()));
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
                    labelText: 'Informe o CEP',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(suffixIconFavorite),
                      onPressed: changeFavoriteIcon,
                    ),
                  ),
                  maxLength: 8,
                  maxLengthEnforced: true,
                ),
                CardListTile('UF: ', resultJsonUf),
                CardListTile('Rua: ', resultJsonRua),
                CardListTile('Bairro: ', resultJsonBairro),
                CardListTile('Localidade: ', resultJsonLocalidade),
                CardListTile('Complemento: ', resultJsonComplemento),
              ],
            ),
          ),
        ),
      ),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: makeRequestApi,
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
                child: GestureDetector(
                  onTap: pushFavoritePage,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
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
