import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _valorBitcoin = "";

  Future<void> _atualizarPrecoBitcoin() async {
    var url = Uri.parse('https://blockchain.info/ticker');

    Map<String, dynamic> retorno;

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Se o servidor retornar um response OK, então parse a resposta
        print('Response data: ${response.body}');

        retorno = jsonDecode(response.body);


        setState(() {
          _valorBitcoin = retorno["BRL"]["buy"].toString();
        });
      } else {
        // Se o servidor não retornar um response OK, então lançar um erro
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Image.asset("images/bitcoin.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Text(
                "R\$ $_valorBitcoin",
                style: const TextStyle(fontSize: 38),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: TextButton(
                onPressed: _atualizarPrecoBitcoin,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffff9400), // Fundo amarelo
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Espaçamento
                  // Adiciona um estilo adicional, como bordas arredondadas, se desejado
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Atualizar",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
