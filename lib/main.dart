import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

List<String> pokeGens = [
  'Generation Zero',
  'Generation I',
  'Generation II',
  'Generation III',
  'Generation IV',
  'Generation V',
  'Generation VI',
  'Generation VII',
  'Generation VIII',
];

Map<String, dynamic> typesColor = {
  "Bug":const Color(0xff9bcc50),
  "Dark":const Color(0xff707070),
  "Dragon":const Color(0xff53a4cf),
  "Electric":const Color(0xffF9A900),
  "Fairy":const Color(0xfffb8aec),
  "Fighting":const Color(0xffe12c6a),
  "Fire":const Color(0xffff983f),
  "Flying":const Color(0xff3dc7ef),
  "Ghost":const Color(0xff4b6ab3),
  "Grass":const Color(0xff35c04a),
  "Ground":const Color(0xffe97333),
  "Ice":const Color(0xff4bd2c1),
  "Normal":const Color(0xffa4acaf),
  "Poison":const Color(0xffb667cf),
  "Psychic":const Color(0xffff6676),
  "Rock":const Color(0xffc9b787),
  "Steel":const Color(0xff9eb7b8),
  "Water":const Color(0xff4592c4)
};

Map<String, dynamic> typos = {
  "Grass": {"Advantage": "Water, Ground and Rock", "weak": "Fire, Ice, Poison, Flying and Bug"},
  "Rock": {"Advantage": "Fire, Ice, Flying and Bug", "weak": "Water, Grass, Fighting, Ground and Steel"},
  "Ice": {"Advantage": "Grass, Ground, Flying and Dragon", "weak": "Fire, Fighting, Rock and Steel"},
  "Dragon": {"Advantage": "Dragon", "weak": "Ice, Dragon and Fairy"},
  "Dark": {"Advantage": "Psychic and Ghost", "weak": "Fighting, Bug and Fairy"},
  "Psychic": {"Advantage": "Fighting and Poison", "weak": "Bug, Ghost and Dark"},
  "Bug": {"Advantage": "Grass, Psychic and Dark", "weak": "Fire, Flying and Rock"},
  "Flying": {"Advantage": "Grass, Fighting and Bug", "weak": "Electric and Ice, Rock"},
  "Steel": {"Advantage": "Ice, Rock and Fairy", "weak": "Fire, Fighting and Ground"},
  "Fire": {"Advantage": "Grass, Ice, Bug and Steel", "weak": "Water, Ground and Rock"},
  "Fighting": {"Advantage": "Normal, Ice, Rock, Dark and Steel", "weak": "Flying, Psychic and Fairy"},
  "Ground": {"Advantage": "Fire, Electric, Poison, Rock and Steel", "weak": "Water, Grass and Ice"},
  "Ghost": {"Advantage": "Psychic and Ghost", "weak": "Ghost and Dark"},
  "Poison": {"Advantage": "Grass and Fairy", "weak": "Ground and Psychic"},
  "Water": {"Advantage": "Fire, Ground and Rock", "weak": "Electric and Grass"},
  "Fairy": {"Advantage": "Fight, Dragon and Dark", "weak": "Poison and Steel"},
  "Electric": {"Advantage": "Water and Flying", "weak": "Ground"},
  "Normal": {"Advantage": "none of them", "weak": "Fighting"}
};

Map<String, dynamic> pokemons = {};

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const Pokedex(),
    );
  }
}

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

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  Map<String,dynamic> foundPokemons = pokemons;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1d1f1f),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear,color: Colors.black),
                      onPressed: () {
                        setState(() {
                          foundPokemons = pokemons;
                        });
                        searchController.clear();
                      },
                    ),
                    hintText: 'Pokémon name...',
                    border: InputBorder.none
                  ),
                  onChanged: (value){
                    Map<String,dynamic> result = {};
                    for(String i in pokemons.keys){
                      if(i.toLowerCase().contains(value.toLowerCase())){
                        result.addAll({i:pokemons[i]});
                      }
                    }
                    setState(() {
                      foundPokemons = result;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: foundPokemons.length,
          itemBuilder: (context, index) {
            return RawMaterialButton(
              onPressed: (){
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokePage(
                        pokeName: foundPokemons.keys.toList()[index],
                      ),
                    )
                  );
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(11,8,11,8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              color: typesColor[foundPokemons[foundPokemons.keys.toList()[index]]['types'].keys.toList()[0]],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1
                                ),
                              ]
                            ),
                            child: Stack(
                              children: [
                                PokeBall(
                                    pokeColor: typesColor[foundPokemons[foundPokemons.keys.toList()[index]]['types'].keys.toList()[0]],
                                    scale: 45,
                                ),
                                Image.asset(
                                  "assets/mini/${foundPokemons.keys.toList()[index]}.png",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(foundPokemons.keys.toList()[index],style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                              const SizedBox(height: 1),
                              Text("${foundPokemons[foundPokemons.keys.toList()[index]]["category"]}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("#${foundPokemons[foundPokemons.keys.toList()[index]]["id"]}",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.1))),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1
                                ),
                              ]
                            ),
                            child:
                            Image.asset(
                              "assets/icons/${foundPokemons[foundPokemons.keys.toList()[index]]["types"].keys.toList()[0]}.png",
                              scale: 2.05,
                            ),
                          ),
                        ],
                      )
                    ],
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

class PokePage extends StatefulWidget {
  const PokePage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;
  State<PokePage> createState() => _PokePageState();
}

class _PokePageState extends State<PokePage> {
  /*
  InterstitialAd? interstitialAd;
  bool isLoaded = false;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad){
          setState(() {
            isLoaded=true;
            this.interstitialAd=ad;
          });
          print("Ad loaded");
        },
        onAdFailedToLoad: (error){
          print(error);
        }
      ),
    );
  }
  */

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
    return SafeArea(
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
              /*if(isLoaded){
                interstitialAd!.show();
              }*/
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
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
              /*
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.pokeName} is a ${pokemons[widget.pokeName]['category']}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )
                                ),
                                Text(
                                  "${pokemons[widget.pokeName]['weight']/10} Kg",
                                  style: const TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                            /*Column(
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  )
                                ),
                                Text(
                                  "${pokemons[widget.pokeName]['category']}",
                                  style: const TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),*/
                            Column(
                              children: [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )
                                ),
                                Text(
                                  "${pokemons[widget.pokeName]['height']/10} m",
                                  style: const TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              */

              // Encounters
              /*
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
                              "Encounters details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "In POKÉMON-XYZ ${widget.pokeName} can be encountered at: LOCAL",
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
              */

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
              /*
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
                              "${widget.pokeName} Abilities",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${widget.pokeName} have a total of ${pokemons[widget.pokeName]['abilities'].keys.toList().length} abilities.",
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            ),
                            /*
                            for(String i in pokemons[widget.pokeName]['abilities'].keys.toList())
                              Column(
                                children: [
                                  Text("${i[0].toUpperCase()}${i.substring(1)}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  for(String j in pokemons[widget.pokeName]['abilities'][i]['effect_entries'])
                                    Text(j,textAlign: TextAlign.center,style: const TextStyle(fontSize: 14),),
                                  const SizedBox(height: 7)
                                ],
                              )
                            */
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
              */

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
                              "Evolutions chain",
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
        )
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