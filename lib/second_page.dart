import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'pokepage.dart';
import 'style.dart';
import 'dart:async';
import 'dart:io';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, required this.pokeName}) : super(key: key);
  final String pokeName;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    List types = pokemons[widget.pokeName]["types"].keys.toList();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 6,bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PillType(type: types[idx].toString()),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TypeButton(
                  img: "assets/icons/${types[idx]}.png",
                  height: MediaQuery.of(context).size.height*0.075,
                ),
                TypeButton(
                  img: "assets/icons/${types[idx]}.png",
                  height: MediaQuery.of(context).size.height*0.2,
                ),
                TypeButton(
                  img: "assets/icons/${types[idx]}.png",
                  height: MediaQuery.of(context).size.height*0.075,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TypeButton extends StatefulWidget {
  const TypeButton({Key? key, required this.img, required this.height}) : super(key: key);
  final String img;
  final double height;
  @override
  State<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){},
      child: Image.asset(
        widget.img,
        height: widget.height,
      ),
    );
  }
}
