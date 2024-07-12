import 'package:flutter/material.dart';
import 'second_page.dart';
import 'first_page.dart';
import 'style.dart';
import 'moves.dart';
class PokePage extends StatefulWidget {
  const PokePage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;
  @override
  State<PokePage> createState() => _PokePageState();
}

class _PokePageState extends State<PokePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              widget.pokeName,
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: RawMaterialButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.black,
                child: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("GENERAL",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("MOVES",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("IN-GAME",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FirstPage(pokeName: widget.pokeName),
                    SecondPage(pokeName: widget.pokeName),
                    const MovesPages()
                    // Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PokeBall extends StatelessWidget {
  const PokeBall({
    Key? key,
    required this.pokeColor,
    required this.scale
  }) : super(key: key);
  final Color pokeColor;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: scale,
              height: scale,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(200)
              ),
            ),
          ),

          Center(
            child: Container(
              width: scale/2,
              height: scale/2,
              decoration: BoxDecoration(
                color: pokeColor,
                borderRadius: BorderRadius.circular(200)
              ),
            ),
          ),

          Center(
            child: Container(
              width: scale,
              height: scale/16.66,
              color: pokeColor,
            ),
          ),
          Center(
            child: Container(
              width: scale/2.5,
              height: scale/2.5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(200)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

