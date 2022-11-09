import 'package:flutter/material.dart';

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

class PillType extends StatelessWidget {
  const PillType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              offset: const Offset(1.0, 2.0)
            )
          ]
        )
      ),
    );
  }
}

class ContentSection extends StatefulWidget {
  const ContentSection({
    Key? key, required this.title, required this.body
  }) : super(key: key);
  final String title;
  final Widget body;

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    widget.title,
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
              widget.body,
            ],
          ),
        ),
      ),
    );
  }
}