import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../common/colors.dart';

class SobrePage extends StatefulWidget {
  @override
  _SobrePageState createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoresDoProjeto.principal,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CoresDoProjeto.principal,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),),
        title: Text("Sobre", style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",)),
        
      ),

      body: SingleChildScrollView(
        
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text("Aprenda com os elementos que compõem o ecossistema marinho a importância que cada um tem, o que afeta sua sobrevivência no ambiente marinho e como cada um é um elo fundamental na vida como um todo. Convidamos você a contribuir para reduzir uma grande ameaça a vida, principalmente aos ecossistemas marinhos, os resíduos sólidos (lixo) descartados inadequadamente. Vivemos dentro de um sistema vivo, o planeta terra, onde toda a matéria natural possui um tempo específico de transformação e ciclagem. Por outro lado, os plásticos e outros compostos artificiais são persistentes e não evoluíram naturalmente, portanto, não são ciclados na natureza, persistem dentro dos organismos, inclusive no humano, causando diversos problemas de saúde 2 e ambientais. Esse tipo de intoxicação ambiental está tomando proporções alarmantes e acumula-se gradativamente no ambiente e nos seres vivos. O alerta é necessário, uma vez que não existe formas de retirá-los da natureza, mas podemos agir de três formas reduzir o consumo, reduzir o descarte inadequado e exigir produtos menos nocivos à vida. Com o app Mar Limpo, você pode contribuir gerando informação para que o poder público seja acionado de forma eficiente para limpeza das praias. Cada registro dos resíduos sólidos que você realiza, com o app Mar Limpo, nos ambientes de praia, conta pontos para abrir símbolos que representam grupos de animais, vegetais, espécies e relações ecológicas entre estes componentes. Ao atingir determinado número de registros, você receberá pontos que abrirão símbolos de componentes do ecossistema e que darão créditos que poderão ser descontados na rede de empreendimentos no litoral que apoiam o projeto.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium", fontSize: 18.0)),
          ),
        )
          
          
        
      ),
    );
  }
}