
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weddingadministration/modeles/mariage.dart';


class MariageService {
  final StreamController<List<Mariage>> _listeMariagesController =
      StreamController<List<Mariage>>.broadcast();

  Stream<List<Mariage>> get listeMariagesStream => _listeMariagesController.stream;

 Future<void> create(Mariage mariage) async {
  final docRef = await FirebaseFirestore.instance
      .collection('mariages')
      .add(mariage.toMap());
  mariage.mariageId = docRef.id;

  // Diffusez la nouvelle liste après l'ajout d'une nouvelle
  _listeMariagesController.add(await getlisteMariages());
}


   Future<void> update(Mariage mariage) async {
    try {
      // Utilisez Firestore pour mettre à jour
      await FirebaseFirestore.instance
          .collection('mariages')
          .doc(mariage.mariageId)
          .update(mariage.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de mariages: $e');
      throw e;
    }
  }

 Future<void> delete(String mariageId) async {
  try {
    await FirebaseFirestore.instance
        .collection('mariages')
        .doc(mariageId)
        .delete();
    print('Supprimer avec succes');
  } catch (e) {
    print('Erreur lors de la suppression du mariage: $e');
    throw e; // vous pouvez choisir de lever à nouveau l'erreur ou de la gérer ici
  }
}


Future<List<Mariage>> getlisteMariages() async {
  try {
    QuerySnapshot<Map<String, dynamic>> listeMariageSnapshot =
          await FirebaseFirestore.instance.collection('mariages').get();

      return listeMariageSnapshot.docs.map((doc) {
        return Mariage.fromMap(
            doc.data() as Map<String, dynamic>, doc.reference);
      }).toList();
  } catch (e) {
    print('Erreur lors de la récupération des mariages: $e');
    return []; // retournez une liste vide en cas d'erreur
  }
}

  /// ============================list default 
  Future<List<Mariage>> getMariagesList() async {
    try {
      // Utilisation de Firestore pour récupérer 
      QuerySnapshot<Map<String, dynamic>> listeMariageSnapshot = await FirebaseFirestore.instance.collection('mariages').get();

      //Convertir les documents Firestore en une liste 
      List<Mariage> listes = listeMariageSnapshot.docs.map((doc) {
            return Mariage.fromMap(
              doc.data() as Map<String, dynamic>, doc.reference
            );
          }).toList();

      return listes;
    } catch (e) {
      print('Erreur lors de la récupération des mariages: $e');
      return [];
    }
  }


  // Ajoutez cette méthode si nécessaire pour fermer le stream
  void dispose() {
    _listeMariagesController.close();
  }
  
}
