import 'package:flutter/material.dart';
import 'package:pertemuan3/beranda.dart';

void main(){
  runApp(new MyApp() );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      theme : new ThemeData(
        //primaryColor: const Color(0xFF02BB9F),
        primaryColor: const Color(0xFFB71C1C),
        primaryColorDark: const Color(0xFF16767),
        //accentColor: const Color(0xFF167F67),
        accentColor: const Color(0xFF1976D2),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      home : new Beranda()
    );
  }
}