import 'package:flutter/material.dart';
import 'package:flutter_praia_limpa/common/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'data.dart';
import 'Page_indicator.dart';
import 'package:gradient_text/gradient_text.dart';
//import '../principal/index.dart';
import '../main/index.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [CoresDoProjeto.principal, Colors.white],
            tileMode: TileMode.clamp,
            begin: Alignment.topLeft,
            stops: [0.05, 0.1],
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage == pageList.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reset();
                  }
                  print(lastPage);
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    var page = pageList[index];
                    var delta;
                    var y = 1.0;

                    if (_controller.position.haveDimensions) {
                      delta = _controller.page - index;
                      y = 1 - delta.abs().clamp(0.0, 1.0);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        //SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(page.numero, style: TextStyle(fontSize: 45.0, fontFamily: "NunitoBold", color: Colors.yellow),),
                          
                            Text(page.numeroStr, style: TextStyle(fontSize: 25.0, fontFamily: "NunitoBold", color: Colors.purple),),

                            SizedBox(width: 1.0,),



                          ],
                        ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(width: 10.0,),
                              Image.asset(page.imagemInicial, width: 40.0, height: 40.0,),
                              Text(page.descImagemInicial, style: TextStyle(fontSize: 20.0, fontFamily: "NunitoBold", color: Colors.yellow),),
                              SizedBox(width: 10.0,),
                            ],
                          ),
                        

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text(page.instrucao1, style: TextStyle(fontSize: 17.0, fontFamily: "NunitoRegular", color: CoresDoProjeto.principal),),
                          ),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CoresDoProjeto.principal,
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Text(page.instrucao2, style: TextStyle(fontSize: 17.0, fontFamily: "NunitoRegular", color: Colors.white),),
                            ),
                          ),
                          

                          Center(
                            child: Image.asset(page.imagemFinal, width: 200.0, height: 200.0,),
                          ),

                          SizedBox(height: 10.0,)



                          
                        /*
                        Padding(
                          padding: const EdgeInsets.only(left: 34.0, top: 12.0),
                          child: Transform(
                            transform:
                                Matrix4.translationValues(0, 50.0 * (1 - y), 0),
                            child: Text(
                              page.body,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Montserrat-Medium",
                                  color: Colors.white),
                            ),
                          ),
                        )

                        */
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              left: 30.0,
              bottom: 55.0,
              child: Container(
                  width: 160.0,
                  child: PageIndicator(currentPage, pageList.length)),
            ),
            Positioned(
              right: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: lastPage
                    ? FloatingActionButton(
                        backgroundColor: CoresDoProjeto.principal,
                        child: Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.white,
                        ),
                        onPressed: () {
                           Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()),
                                (Route route) => route == null);
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
