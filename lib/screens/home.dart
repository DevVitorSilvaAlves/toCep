import 'package:flutter/material.dart';
import 'package:tocep/controller/api.dart';
import 'package:tocep/screens/widgets/card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textField = TextEditingController();
  var instanceApi = Api();
  var _textContainer = '';
  var _resultJsonUf = '';
  var _resultJsonRua = '';
  var _resultJsonBairro = '';
  var _resultJsonLocalidade = '';
  var _resultJsonComplemento = '';

  setStateResponseApi() {
    var getTextField = textField.text.toString();
    var getResultApi = instanceApi.createConnection(getTextField);
    setState(() {
      _resultJsonUf = getResultApi['uf'].toString();
      _resultJsonRua = getResultApi['logradouro'].toString();
      _resultJsonBairro = getResultApi['bairro'].toString();
      _resultJsonLocalidade = getResultApi['localidade'].toString();
      _resultJsonComplemento = getResultApi['complemento'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: SingleChildScrollView(
        child: SafeArea(
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
                CardListTile('UF: ', _resultJsonUf),
                CardListTile('Rua: ', _resultJsonRua),
                CardListTile('Bairro: ', _resultJsonBairro),
                CardListTile('Localidade: ', _resultJsonLocalidade),
                CardListTile('Complemento: ', _resultJsonComplemento),
                Text(
                  _resultJsonBairro,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: setStateResponseApi,
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
