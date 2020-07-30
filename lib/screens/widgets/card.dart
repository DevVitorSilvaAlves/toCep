import 'package:flutter/material.dart';

class CardListTile extends StatefulWidget {
  String textTile;
  String textTileApi;
  CardListTile(this.textTile, this.textTileApi);
  @override
  _CardListTileState createState() => _CardListTileState();
}

class _CardListTileState extends State<CardListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.textTile + widget.textTileApi,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
