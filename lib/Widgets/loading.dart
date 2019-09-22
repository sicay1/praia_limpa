import 'package:flutter/material.dart';

class Loading{
  static Widget loading = Padding(
    padding: EdgeInsets.all(5.0),
    child: SizedBox(
              child: 
                  new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 4.0),
              height: 25.0,
              width: 25.0,
              )
  );

  static Widget loadingBranco = Padding(
    padding: EdgeInsets.all(5.0),
    child: SizedBox(
              child: 
                  new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 4.0),
              height: 25.0,
              width: 25.0,
              )
  );
}