import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class PosicaoPage extends StatefulWidget {
  @override
  _PosicaoPageState createState() => _PosicaoPageState();
}

class _PosicaoPageState extends State<PosicaoPage> {
  String x, y, z;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
    // Do something with the event.
      setState(() {
        x = event.x.round().toString();
        y = event.y.round().toString();
        z = event.z.round().toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(x),
            Text(y),
            Text(z),
          ],
        ),
    );
  }
}