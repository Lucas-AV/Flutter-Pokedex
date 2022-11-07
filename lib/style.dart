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
