import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  
  String? produitId;
  String nom;
  String? image;
  double prix;
  String? prestataireId;

  Produit({
    required this.produitId,
    required this.nom,
    required this.image,
    required this.prix,
    required this.prestataireId,
  });


//  Map<String, dynamic> toMap() {
//     return {
//       'nom': nom,
//       'image': image,
//       'prix': prix,
//       'prestataireId': prestataireId,
//     };
//   }

  factory Produit.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Produit(
      produitId: docRef.id,
      nom: map['nom'],
      image: map['image'],
      prix: map['prix'],
      prestataireId: map['prestataireId'],
    );
  }

  Future<void> create() async {
    final docRef = await FirebaseFirestore.instance.collection('produits').add(toMap());
    produitId = docRef.id;
  }
  
  Map<String, dynamic> toMap() {

     return {
      'nom': nom,
      'image': image,
      'prix': prix,
      'prestataireId': prestataireId,
    };
  }
}