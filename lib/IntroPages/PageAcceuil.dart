import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/IntroPages/slider.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class PageAcceuil extends StatefulWidget {
  static String id="PageAcceuil";
  @override
  _PageAcceuilState createState() => _PageAcceuilState();
}

class _PageAcceuilState extends State<PageAcceuil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/femme3.jpg",
              ),fit: BoxFit.fitHeight,
          )
      ),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.75),
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(1),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: longueurPerCent(30, context),right: longueurPerCent(30, context),),
                  child: Text("Bienvenue dans",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: "MonseraBold",

                    ),
                  ),
                ),Padding(
                  padding: EdgeInsets.only(left: longueurPerCent(30, context),right: longueurPerCent(30, context)),
                  child: Text("1er Choix",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: "MonseraBold",

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: longueurPerCent(10, context),right: longueurPerCent(10, context),top: longueurPerCent((10), context),bottom: longueurPerCent((10), context)),
                  child: Text("Votre appliation mobile de friperie.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Monsera_Light",

                    ),
                  ),
                ),
                Center(
                  child:
                  Container(
                    child: button(HexColor("#001C36"), HexColor("#FFC30D"), context,
                        'DÉMARRER', () {
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 750),child: IntroScreen(),
                          ));
                        }),
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context))
              ],
            ),
          )
      ),
    );
  }
}