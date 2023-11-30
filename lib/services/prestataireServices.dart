import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weddingadministration/modeles/prestataire.dart';

class PrestataireService {
  final StreamController<List<Prestataire>> _listePrestatairesController =
      StreamController<List<Prestataire>>.broadcast();

  Stream<List<Prestataire>> get listePrestatairesStream => _listePrestatairesController.stream;

 Future<void> create(Prestataire prestataire) async {
  final docRef = await FirebaseFirestore.instance
      .collection('prestataires')
      .add(prestataire.toMap());
  prestataire.prestataireId = docRef.id;

  // Diffusez la nouvelle liste après l'ajout d'une nouvelle
  _listePrestatairesController.add(await getlistePrestataires());
}


   Future<void> update(Prestataire prestataire) async {
    try {
      // Utilisez Firestore pour mettre à jour
      await FirebaseFirestore.instance
          .collection('prestataires')
          .doc(prestataire.prestataireId)
          .update(prestataire.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de prestataires: $e');
      throw e;
    }
  }

 Future<void> delete(String prestataireId) async {
  try {
    await FirebaseFirestore.instance
        .collection('prestataires')
        .doc(prestataireId)
        .delete();
    print('Supprimer avec succes');
  } catch (e) {
    print('Erreur lors de la suppression de la prestataire: $e');
    throw e; // vous pouvez choisir de lever à nouveau l'erreur ou de la gérer ici
  }
}


Future<List<Prestataire>> getlistePrestataires() async {
  try {
    QuerySnapshot<Map<String, dynamic>> listePrestataireSnapshot =
          await FirebaseFirestore.instance.collection('prestataires').get();

      return listePrestataireSnapshot.docs.map((doc) {
        return Prestataire.fromMap(
            doc.data() as Map<String, dynamic>, doc.reference);
      }).toList();
  } catch (e) {
    print('Erreur lors de la récupération des prestataires: $e');
    return []; // retournez une liste vide en cas d'erreur
  }
}

  /// ============================list default 
  Future<List<Prestataire>> getPrestatairesList() async {
    try {
      // Utilisation de Firestore pour récupérer 
      QuerySnapshot<Map<String, dynamic>> listePrestataireSnapshot = await FirebaseFirestore.instance.collection('prestataires').get();

      //Convertir les documents Firestore en une liste 
      List<Prestataire> listes = listePrestataireSnapshot.docs.map((doc) {
            return Prestataire.fromMap(
              doc.data() as Map<String, dynamic>, doc.reference
            );
          }).toList();

      return listes;
    } catch (e) {
      print('Erreur lors de la récupération des prestataires: $e');
      return [];
    }
  }


  // Ajoutez cette méthode si nécessaire pour fermer le stream
  void dispose() {
    _listePrestatairesController.close();
  }
  
}
