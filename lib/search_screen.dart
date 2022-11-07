import 'package:flutter/material.dart';
import 'pokepage.dart';
import 'style.dart';

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
