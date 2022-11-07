import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'pokepage.dart';
import 'dart:convert';
import 'dart:async';
import 'style.dart';


class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  bool searching = false;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff212121),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Pokédex",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: (){
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        )
                    );
                  });
                },
                child: const Icon(
                  Icons.search,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  for(String pkn in pokemons.keys)
                    PokeBox(context, pkn),
                ],
              ),
            ],
          ),
        )
    );
  }

  RawMaterialButton PokeBox(BuildContext context, String pkn) {
    return RawMaterialButton(
      onPressed: (){
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokePage(
                  pokeName: pkn,
                ),
              )
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: typesColor[pokemons[pkn]['types'].keys.toList()[0]],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2
              )
            ]
        ),
        child: Stack(
            children: [
              PokeBall(
                pokeColor: typesColor[pokemons[pkn]['types'].keys.toList()[0]],
                scale: 150,
              ),
              Center(
                child: Image.asset(
                  "assets/opt/$pkn.png",
                  scale: 1.17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "#${pokemons[pkn]["id"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(1.0, 2.0)
                          )
                        ],
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          pkn,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(1.0, 2.0)
                              )
                            ],
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ]
        ),
      ),
    );
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/new_pokedex.json');
    final data = await json.decode(response);
    setState(() {
      pokemons = data;
    });
  }
}

