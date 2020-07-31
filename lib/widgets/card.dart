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
        title: RichText(
          text: TextSpan(
            text: widget.textTile,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 13,
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.textTileApi,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
