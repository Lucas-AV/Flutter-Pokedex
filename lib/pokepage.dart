import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'dart:async';
import 'dart:io';

class PokePage extends StatefulWidget {
  const PokePage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;
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
                    Container(),
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

class StatsBar extends StatelessWidget {
  const StatsBar({
    Key? key,
    required this.title,
    required this.attr,
    required this.color,
    required this.div,
    required this.por,
  }) : super(key: key);
  final String title;
  final int div;
  final bool por;
  final int attr;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            por? Text("[ ${((attr/div)*100).toStringAsFixed(2)}% ]",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)) : Text("[ $attr ]",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
          ],
        ),
        const SizedBox(height: 1),
        LinearProgressIndicator(
          value: attr/div,
          backgroundColor: Colors.black.withOpacity(0.1),
          color: color,
          minHeight: 12,
        ),
      ],
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  FutureOr verifyWifi() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return 1;
      }
    } on SocketException catch (_) {
      print('not connected');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Pokémon
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16,10,16,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        for(dynamic type in pokemons[widget.pokeName]["types"].keys.toList())
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.0),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                  )
                                ]
                            ),
                            child: Text(
                                type,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(1.0, 2.0)
                                      )
                                    ]
                                )
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "#${pokemons[widget.pokeName]["id"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(1.0, 2.0),
                              blurRadius: 10,
                            )
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [

                  PokeBall(
                      pokeColor: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                      scale: 280
                  ),
                  Center(
                    child:
                    verifyWifi() == 1 ?
                    Image.asset(
                      "assets/opt/${widget.pokeName}.png",
                      scale: 1.17,
                    ) :
                    CachedNetworkImage(
                        imageUrl: pokemons[widget.pokeName]["img"],
                        height: MediaQuery.of(context).size.height*0.365
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -1,
                    child: Image.asset(
                      "assets/mini/${widget.pokeName}.png",
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 1
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Description of ${widget.pokeName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${pokemons[widget.pokeName]['description']}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Generation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Generation details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "This pokémon belongs to Generation ${pokemons[widget.pokeName]['generation']['id']} that pass in ${pokemons[widget.pokeName]['generation']['region']} region with ${pokemons[widget.pokeName]['generation']['pokemons-count']} entrys in it pokédex.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Height and Weight

          // Encounters

          // Combat Base Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Combat base stats",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        StatsBar(
                          por: false,
                          title: "Health Points",
                          attr: pokemons[widget.pokeName]['hp'],
                          div: 150,
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                          por: false,
                          div: 150,
                          title: "Attack",
                          attr: pokemons[widget.pokeName]['attack'],
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                          por: false,
                          div: 150,
                          title: "Defense",
                          attr: pokemons[widget.pokeName]['defense'],
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                          por: false,
                          div: 150,
                          title: "Special Attack",
                          attr: pokemons[widget.pokeName]['special-attack'],
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                          por: false,
                          div: 150,
                          title: "Special Defense",
                          attr: pokemons[widget.pokeName]['special-defense'],
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                          por: false,
                          div: 150,
                          title: "Speed",
                          attr: pokemons[widget.pokeName]['speed'],
                          color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]],
                        ),
                        const SizedBox(height: 3),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Advantages
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "${widget.pokeName} Advantages",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${widget.pokeName} is strong against some pokémons types like ${typos[pokemons[widget.pokeName]["types"].keys.toList()[0]]['Advantage']}.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Weaknesses
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "${widget.pokeName} Weaknesses",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${widget.pokeName} are weak against ${typos[pokemons[widget.pokeName]["types"].keys.toList()[0]]['weak']} type attacks.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Abilites

          // Other Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Other stats",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StatsBar(
                            por: true,
                            div: 765,
                            title: "Capture Rate (Full HP)",
                            attr: pokemons[widget.pokeName]["capture_rate"],
                            color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]]
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                            por: false,
                            div: 350,
                            title: "Base XP",
                            attr: pokemons[widget.pokeName]["base_xp"],
                            color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]]
                        ),
                        const SizedBox(height: 8),
                        StatsBar(
                            por: false,
                            div: 100,
                            title: "Base Hapiness",
                            attr: pokemons[widget.pokeName]["base_happiness"],
                            color: typesColor[pokemons[widget.pokeName]["types"].keys.toList()[0]]
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          // Evolution chain
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "< Evolutions chain >",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        if (pokemons[widget.pokeName]["evolutions"].length == 1) Text(
                          "The pokémon ${widget.pokeName} don't have any evolutions.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ) else GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: pokemons[widget.pokeName]["evolutions"].length % 2 == 0? 2 : 3,
                          children: [
                            for(int i = 0; i < pokemons[widget.pokeName]["evolutions"].length; i++ )
                              RawMaterialButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PokePage(
                                            pokeName: pokemons[widget.pokeName]["evolutions"][i],
                                          ),
                                        )
                                    );
                                  });
                                },
                                child: Card(
                                  color: typesColor[pokemons[pokemons[widget.pokeName]["evolutions"][i]]["types"].keys.toList()[0]],
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width*0.925,
                                    child: Stack(
                                      children: [
                                        PokeBall(
                                          pokeColor: typesColor[pokemons[pokemons[widget.pokeName]["evolutions"][i]]["types"].keys.toList()[0]],
                                          scale: pokemons[widget.pokeName]["evolutions"].length % 2 == 0? 100:80,
                                        ),
                                        Center(
                                          child: Image.asset(
                                            "assets/opt/${pokemons[pokemons[widget.pokeName]["evolutions"][i]]["name"]}.png",
                                            scale:  pokemons[widget.pokeName]["evolutions"].length % 2 == 0?
                                            1.33 :
                                            1.78,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text("#${pokemons[pokemons[widget.pokeName]["evolutions"][i]]["id"]}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.black.withOpacity(0.7),
                                                        blurRadius: 10,
                                                        offset: Offset(1.0, 2.0)
                                                    )
                                                  ],
                                                  color: Colors.white,
                                                  fontSize: pokemons[widget.pokeName]["evolutions"].length % 2 == 0? 18:12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(pokemons[pokemons[widget.pokeName]["evolutions"][i]]["name"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black.withOpacity(0.7),
                                                          blurRadius: 10,
                                                          offset: const Offset(1.0, 2.0)
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                    fontSize: pokemons[widget.pokeName]["evolutions"].length % 2 == 0? 24:16,
                                                  ),
                                                ),
                                                const SizedBox(height: 2)
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 6,bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${widget.pokeName} Moves",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 10
                                  )
                                ]
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          spreadRadius: 1
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${widget.pokeName} Abilities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 10
                                )
                              ]
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
