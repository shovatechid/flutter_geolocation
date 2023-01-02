import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocation/function/geolication.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}



class _LocationState extends State<Location> {
   @override
  void initState() {
    super.initState();
    getCoordinates(setState);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${myCoordinates ?? "Mencari data latitude dan longitude.."}'),
              Text('${currentAddress ?? "Mencari lokasi..."}')
            ],
          )
         ,
        ),
      ),
    );
  }
}