import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Favorite extends StatefulWidget {
  Favorite();
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var leadingFavorite = Icons.favorite;
  var favorites;

  removeFavorite(index) {
    setState(() {
      favorites.removeAt(index);
      saveFile();
    });
  }

  Future<String> readFile() async {
    try {
      final _directory = await getApplicationDocumentsDirectory();
      final _file = File('${_directory.path}/datafavorites.json');
      return _file.readAsString();
    } catch (error) {
      return null;
    }
  }

  Future<File> saveFile() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _file = File('${_directory.path}/datafavorites.json');
    String dataJson = json.encode(favorites);
    return _file.writeAsString(dataJson);
  }

  @override
  void initState() {
    super.initState();
    readFile().then((data) {
      setState(() {
        favorites = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Favoritos'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                child: ListTile(
                  title: Text(
                    favorites[index]['title'],
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                  trailing: IconButton(
                    onPressed: () => removeFavorite(index),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
