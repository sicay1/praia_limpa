import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;

class TesteImagem extends StatefulWidget {
  Uint8List bytes;
  @override
  _TesteImagemState createState() => _TesteImagemState();
}

class _TesteImagemState extends State<TesteImagem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(widget.bytes)
        )
      ),
    );
  }
}