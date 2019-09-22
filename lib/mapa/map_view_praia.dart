/*
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class MapaPraiaPage extends StatefulWidget {
  @override
  _MapaPraiaPageState createState() => _MapaPraiaPageState();
}

class _MapaPraiaPageState extends State<MapaPraiaPage> {
  MapView mapView = new MapView();

  displayMap(){
    mapView.show(new MapOptions(
      mapViewType: MapViewType.terrain,
      initialCameraPosition: new CameraPosition(new Location(35.22, -101.83), 15.0),
      showUserLocation: true,
      title: "Praia Limpa"
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            color: Colors.blue,
            child: Text("Tap me"),
            onPressed: displayMap,
          ),
        ),
      ),
    );
  }
}
*/