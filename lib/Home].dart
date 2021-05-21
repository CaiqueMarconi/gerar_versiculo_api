import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String verse;


  void ApiRandom() async{

    var ListVerse = [
      "gn", "ex", "lv", "nm", "dt"
    ];

    var numero = Random().nextInt(ListVerse.length);
    var resultado = ListVerse[numero];

    String url = "https://www.abibliadigital.com.br/api/verses/acf/${resultado}/random";
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    String name = retorno ["book"]["name"];
    String chapter = retorno["chapter"].toString();
    String number = retorno["number"].toString();
    String text = retorno["text"];
    print(retorno["text"]);

    setState(() {
    verse = "${text},\n\n${name},\ncapitulo: ${chapter},\nversiculo: ${number}";
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: AutoSizeText(verse.toString(),minFontSize: 16,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
              ),
            ),
            RaisedButton(onPressed: ApiRandom,
              child: Text("Atualizar"),
              color: Colors.orange,
            )
          ],
        ),
      ),

    );
  }
}
