import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/article.dart';


/***************************************************************************************************/

/// Cette fonction permet d'ajouter un produit dans ProduitsFavorisUser(collection composant le produit personnel
///de l'utilisateur pour la selection des images et l'ajout des favoris, cette collection est utilisée pour enregister les
///produits sur lesquels ils cliquent ce qui aide permet d'ajouter dans la table le produit avec les informations

void idProduitsFavorisUser(Produit produit, BuildContext context) async{
  if (Renseignements.emailUser != null) {
    try {
      Firestore.instance.collection("Utilisateurs").document(Renseignements.emailUser).collection("ProduitsFavoirsUser")
          .where("imagePrincipaleProduit", isEqualTo: produit.image1)
          .getDocuments().then((QuerySnapshot snapshot) async {
        if(snapshot.documents.isEmpty){
         await  FirestoreService().addProduitFavorisUser(ProduitsFavorisUser(
              imagePrincipaleProduit: produit.image1,
              imageSelect: produit.image1,
              etatIconeFavoris: false
          ), Renseignements.emailUser);
         print("L'ajout a été fait avant le onap");
        }

      });
    } catch (e){
      print(e);
    }
  }
}

////////////////////////////////////////////////////////////////////Fin de la fonction //////////////////////////////////////////////////////////


/*Fin de la fonction*/
Widget scrollabe_products_horizontal(BuildContext context){

  return Container(
      height: longueurPerCent(200, context),
      child: StreamBuilder(
          stream: FirestoreService().getProduit(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Produit>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: (){
                        idProduitsFavorisUser(snapshot.data[i], context);
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                     ArticleSansTaille(snapshot.data[i], Renseignements.emailUser)));
                      },
                      child: Container(
                        width: largeurPerCent(180, context),
                        margin: EdgeInsets.only(
                            left: largeurPerCent(10, context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height:
                                longueurPerCent(120, context),
                                width: largeurPerCent(180, context),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft:
                                        Radius.circular(10),
                                        topRight:
                                        Radius.circular(10)),
                                    child: Image.network(
                                      snapshot.data[i].image1,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context,child, progress){
                                        return progress == null?child:LinearProgressIndicator(backgroundColor:HexColor("EFD807"), );
                                      },
                                    )),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                  largeurPerCent(200, context),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: largeurPerCent(
                                            10, context),
                                        top: longueurPerCent(
                                            10, context)),
                                    child: Text(
                                      "${snapshot.data[i].prix} FCFA",
                                      style: TextStyle(
                                          color:
                                          HexColor("#001C36"),
                                          fontSize: 15,
                                          fontFamily:
                                          "MonseraBold"),
                                    )),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                  largeurPerCent(200, context),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.only(left: largeurPerCent(10, context), top: longueurPerCent(5, context)),
                                  child: Text(
                                    snapshot.data[i].nomDuProduit,
                                    style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 15,
                                        fontFamily: "MonseraRegular"),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                      longueurPerCent(10, context),
                                      left: largeurPerCent(10, context)
                                  ),
                                  child: RatingBar(
                                    initialRating: snapshot.data[i].numberStar.ceilToDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 3,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 10,
                                    ),
                                    itemSize: 20,
                                    ignoreGestures: true,
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }));
}