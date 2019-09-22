import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'splash/index.dart';
import 'package:camera/camera.dart';
import 'common/usuario.dart';
import 'splash/localizacao.dart';

//var myKey = "AIzaSyAF9Bs41yTxRgioa3BYLs-DIsj6n-jCZiY";
void main() {
  runApp(MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CoresDoProjeto.principal,
        primarySwatch: Colors.blue,
      ),
    ));
}