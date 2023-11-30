import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weddingadministration/modeles/produit.dart';

class ProduitService {
  final StreamController<List<Produit>> _listeProduitsController =
      StreamController<List<Produit>>.broadcast();

  Stream<List<Produit>> get listeProduitsStream => _listeProduitsController.stream;

 Future<void> create(Produit produit) async {
  final docRef = await FirebaseFirestore.instance
      .collection('produits')
      .add(produit.toMap());
  produit.produitId = docRef.id;

  // Diffusez la nouvelle liste après l'ajout d'une nouvelle
  _listeProduitsController.add(await getlisteProduits());
}


   Future<void> update(Produit produit) async {
    try {
      // Utilisez Firestore pour mettre à jour
      await FirebaseFirestore.instance
          .collection('produits')
          .doc(produit.produitId)
          .update(produit.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de Produits: $e');
      throw e;
    }
  }

 Future<void> delete(String produitId) async {
  try {
    await FirebaseFirestore.instance
        .collection('produits')
        .doc(produitId)
        .delete();
    print('Supprimer avec succes');
  } catch (e) {
    print('Erreur lors de la suppression de la Produit: $e');
    throw e; // vous pouvez choisir de lever à nouveau l'erreur ou de la gérer ici
  }
}


Future<List<Produit>> getlisteProduits() async {
  try {
    QuerySnapshot<Map<String, dynamic>> listeProduitSnapshot =
          await FirebaseFirestore.instance.collection('produits').get();

      return listeProduitSnapshot.docs.map((doc) {
        return Produit.fromMap(
            doc.data() as Map<String, dynamic>, doc.reference
            );
      }).toList();
  } catch (e) {
    print('Erreur lors de la récupération des Produits: $e');
    return []; // retournez une liste vide en cas d'erreur
  }
}

  /// ============================list default 
  Future<List<Produit>> getProduitsList() async {
    try {
      // Utilisation de Firestore pour récupérer 
      QuerySnapshot<Map<String, dynamic>> listeProduitSnapshot = await FirebaseFirestore.instance.collection('produits').get();

      //Convertir les documents Firestore en une liste 
      List<Produit> listes = listeProduitSnapshot.docs.map((doc) {
            return Produit.fromMap(
              doc.data() as Map<String, dynamic>, doc.reference
            );
          }).toList();

      return listes;
    } catch (e) {
      print('Erreur lors de la récupération des Produits: $e');
      return [];
    }
  }


  // Ajoutez cette méthode si nécessaire pour fermer le stream
  void dispose() {
    _listeProduitsController.close();
  }
  
}
