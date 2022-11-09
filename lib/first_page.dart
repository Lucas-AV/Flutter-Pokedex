import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'pokepage.dart';
import 'style.dart';
import 'dart:async';
import 'dart:io';

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
                          PillType(type: type),
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
          ContentSection(
            title: "Description of ${widget.pokeName}",
            body: Text(
              "${pokemons[widget.pokeName]['description']}",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Generation
          ContentSection(
            title: "Generation details",
            body: Text(
              "This pokémon belongs to Generation ${pokemons[widget.pokeName]['generation']['id']} that pass in ${pokemons[widget.pokeName]['generation']['region']} region with ${pokemons[widget.pokeName]['generation']['pokemons-count']} entrys in it pokédex.",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ),

          // Combat Base Stats
          ContentSection(
            title: "Combat base stats",
            body: Column(
              children: [
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
            )
          ),

          // Advantages
          ContentSection(
            title: "${widget.pokeName} Advantages",
            body: Text(
              "${widget.pokeName} is strong against some pokémons types like ${typos[pokemons[widget.pokeName]["types"].keys.toList()[0]]['Advantage']}.",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Weaknesses
          ContentSection(
            title: "${widget.pokeName} Weaknesses",
            body: Text(
              "${widget.pokeName} are weak against ${typos[pokemons[widget.pokeName]["types"].keys.toList()[0]]['weak']} type attacks.",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ),

          // Other Stats
          ContentSection(
            title: "Other stats",
            body: Column(
              children: [
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
            )
          ),

          // Evolution chain
          ContentSection(
            title: "< Evolutions chain >",
            body: Column(
              children: [
                if (pokemons[widget.pokeName]["evolutions"].length == 1)
                  Text(
                    "The pokémon ${widget.pokeName} don't have any evolutions.",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ) else
                  GridView.count(
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
                                                  offset: const Offset(1.0, 2.0)
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
            )
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(15),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.2),
          //           blurRadius: 3,
          //           spreadRadius: 1
          //         )
          //       ]
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
          //       child: Column(
          //         children: [
          //           Column(
          //             children: [
          //
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 12,
          // ),
        ],
      ),
    );
  }
}