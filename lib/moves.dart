import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'second_page.dart';
import 'pokepage.dart';
import 'style.dart';
import 'dart:async';
import 'dart:io';

class MovesPages extends StatefulWidget {
  const MovesPages({Key? key}) : super(key: key);

  @override
  State<MovesPages> createState() => _MovesPagesState();
}

class _MovesPagesState extends State<MovesPages> {
  List<String> allTypes = typesColor.keys.toList();
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,

      children: [
        for(String i in allTypes)
          MoveTypePage(
            name: i,
            bg: typesColor[i],
            moves: [],
          )
      ],
    );
  }
}

class MoveTypePage extends StatelessWidget {
  const MoveTypePage({Key? key, required this.name, required this.bg, required this.moves}) : super(key: key);
  final List<Map<String,dynamic>> moves;
  final String name;
  final Color bg;
  @override
  Widget build(BuildContext context) {
    List ks = typesColor.keys.toList();
    int idx = ks.indexOf(name);
    List icons = [];
    if(idx == 0){
      icons = ks.sublist(0,1);
    }
    else if(idx == ks.length - 1){
      icons = ks.sublist(ks.length - 1);
    } else {
      icons = ks.sublist(idx - 1, idx + 1);
    }

    return Container(
      color: bg,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PillType(type: name)
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     for(int i = 0; i < icons.length; i++)
                  //       i == 1? RawMaterialButton(
                  //         onPressed: (){},
                  //         child: Image.asset(
                  //           name
                  //         ),
                  //       ) : RawMaterialButton(
                  //         onPressed: (){},
                  //         child: Image.asset(
                  //           name,
                  //           height: MediaQuery.of(context).size.height*0.075,
                  //         ),
                  //       )
                  //   ],
                  // ),
                ],
              ),
            ),
            Text(icons.toString())
            // for(var i in moves)
            //   ContentSection(
            //     title: i["name"],
            //     body: Column(
            //       children: [
            //         Text(name)
            //       ],
            //     )
            //   )
          ],
        ),
      ),
    );
  }
}
