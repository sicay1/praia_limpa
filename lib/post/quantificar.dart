import 'package:flutter/material.dart';
import 'package:custom_radio_button/custom_radio_button.dart';
import 'package:custom_radio_button/radio_model.dart';

class QuantidadePage extends StatefulWidget {
  @override
  _QuantidadePageState createState() => _QuantidadePageState();
}

class _QuantidadePageState extends State<QuantidadePage> {
  String _selectedValue;
  
 
  @override
  Widget build(BuildContext context) {
  List<RadioModel> incidentTypeList = new List<RadioModel>();
        incidentTypeList.add(new RadioModel(
            false,
            Icon(
              Icons.whatshot,
              color: Colors.blue,
            ),
            'Fire',
            Colors.red));
        incidentTypeList.add(new RadioModel(
            false,
            Icon(
              Icons.face,
              color: Colors.red,
            ),
            'Near Miss',
            Colors.deepPurple));
        incidentTypeList.add(new RadioModel(
            false,
            Icon(
              Icons.directions_car,
              color: Colors.deepOrange,
            ),
            'Accident',
            Colors.blueAccent));
        incidentTypeList.add(new RadioModel(
            false,
            Icon(
              Icons.directions_run,
              color: Colors.greenAccent,
            ),
            'Theft',
            Colors.purpleAccent));
        incidentTypeList.add(new RadioModel(
            false,
            Icon(
              Icons.business,
              color: Colors.yellow,
            ),
            'Property damage',
            Colors.greenAccent));
    return CustomRadioGroupWidget(
                           //onChanged: getvalue,
                           isSquareRadioGroup: false,
                           radioList: incidentTypeList,
                         );
  }
  void getvalue(Map value) {
      _selectedValue = value.toString();
    }
}