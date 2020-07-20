import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/components/decoration_text_field_container.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inscription extends StatefulWidget {
  static String id = "inscription";

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _auth = FirebaseAuth.instance;
   String emailAdress = '';
  String motDePass = '';
  String confirmation = '';
  bool chargement = false;
  Utilisateur utilisateur;
  String key = "email_user";
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
      return (chargement==true)?Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/marketeurLogo.jpeg',
                height: 197,
                width: 278,
              ),
              SizedBox(height: 50.0,),
              SpinKitThreeBounce(
                color:HexColor('#001C36'),
                size: 60,
              )
            ],
          ),
        ),
      ) :Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: longueurPerCent(90, context),
                        left: largeurPerCent(5, context),
                        right: largeurPerCent(200, context)
                    ),
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontFamily: "MonseraBold",
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(70, context),),
                  Container(
                      child:Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              textField("Email", context, email()),
                              SizedBox(height: longueurPerCent(20, context),),
                              textField("Mot de passe", context,password()),
                              SizedBox(height: longueurPerCent(20, context),),
                              textField("Confirmation mot de passe", context, confirmPassword()),
                            ],
                          )
                      )
                  ),
                  SizedBox(height: longueurPerCent(50, context),),
                  button(HexColor("#001C36"), HexColor('#FFC30D'), context, "S'INSCRIRE", () async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        chargement = true;
                      });
                      try {
                        final user= await _auth.createUserWithEmailAndPassword(email: emailAdress, password: motDePass);
                        if(user!=null ) {
                          print("reussie");
                          ajouter(emailAdress);
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return Renseignements(emailAdress: emailAdress);
                          }));
                        }
                        setState(() {
                          chargement = false;
                        });
                      } catch(e){
                        print(e);
                      }
                    }
                  }),
                  SizedBox(height: longueurPerCent(30, context),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Vous avez un compte?", style: TextStyle(color: HexColor("#9B9B9B"), fontSize: 18),),
                      SizedBox(width: largeurPerCent(5, context),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Connexion.id);
                        },
                        child: Text("Connectez-vous",  style:TextStyle(
                            color: HexColor('#001C36'),
                            fontSize: 15.0,
                            fontFamily: 'MonseraBold')),
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
  }

  Widget email(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
              color: HexColor('#9B9B9B'),
              fontSize: 17.0,
              fontFamily: 'MonseraLight'),
          fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
          border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
              borderSide: BorderSide(width: 0, style: BorderStyle.none)
          ),
      ),
      onChanged: (value){
        emailAdress = value;
      },
      validator: (String value) {
        if (EmailValidator.validate(emailAdress) == false) {
          return ("Entrer un email valide");
        }
      },
    );
  }
  Widget password(){
    return  TextFormField(
      decoration: InputDecoration(
        hintText: "Mot de passe",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 17.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
        motDePass = value;
      },
      validator: (String value) {
        if(value.isEmpty) {
          return ("Entrer un mot de passe valide");
        } else if (value.length<6) {
          return ("Le nombre de caractères doit être supérieur à 5");
        }
      },
    );
  }
  Widget confirmPassword() {
    return  TextFormField(
        decoration: InputDecoration(
          hintText: "Confirmation mot de passe",
          hintStyle: TextStyle(
              color: HexColor('#9B9B9B'),
              fontSize: 17.0,
              fontFamily: 'MonseraLight'),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
          border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
              borderSide: BorderSide(width: 0, style: BorderStyle.none)
          ),
        ),
        onChanged:
            (value) => confirmation = value,
      validator: (String value) {
        if (value.isEmpty || motDePass != value) {
          return ("Veuillez confirmer votre mot de passe");
        }
      },
    );
  }

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  void obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String liste = await sharedPreferences.getString(key);
    if (liste != null) {
      setState(() {
        Renseignements.emailUser = liste;
      });
    }
  }
  /* Fin de la fonction */

  /** Cette fonction permet d'ajouter les informations*/

  void ajouter(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.emailUser=str;
    await sharedPreferences.setString(key, Renseignements.emailUser);
    obtenir();
  }
}