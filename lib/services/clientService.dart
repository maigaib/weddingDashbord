import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weddingadministration/modeles/client.dart';


class ClientService {
  final StreamController<List<Client>> _listeClientsController =
      StreamController<List<Client>>.broadcast();

  Stream<List<Client>> get listeClientsStream => _listeClientsController.stream;

 Future<void> create(Client client) async {
  final docRef = await FirebaseFirestore.instance
      .collection('clients')
      .add(client.toMap());
  client.clientId = docRef.id;

  // Diffusez la nouvelle liste après l'ajout d'une nouvelle
  _listeClientsController.add(await getlisteClients());
}


   Future<void> update(Client client) async {
    try {
      // Utilisez Firestore pour mettre à jour
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(client.clientId)
          .update(client.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de client: $e');
      throw e;
    }
  }

 Future<void> delete(String clientId) async {
  try {
    await FirebaseFirestore.instance
        .collection('prestataires')
        .doc(clientId)
        .delete();
    print('Supprimer avec succes');
  } catch (e) {
    print('Erreur lors de la suppression du client: $e');
    throw e; // vous pouvez choisir de lever à nouveau l'erreur ou de la gérer ici
  }
}


Future<List<Client>> getlisteClients() async {
  try {
    QuerySnapshot<Map<String, dynamic>> listeClientSnapshot =
          await FirebaseFirestore.instance.collection('clients').get();

      return listeClientSnapshot.docs.map((doc) {
        return Client.fromMap(
            doc.data() as Map<String, dynamic>, doc.reference);
      }).toList();
  } catch (e) {
    print('Erreur lors de la récupération des clients: $e');
    return []; // retournez une liste vide en cas d'erreur
  }
}

  /// ============================list default 
  Future<List<Client>> getClientsList() async {
    try {
      // Utilisation de Firestore pour récupérer 
      QuerySnapshot<Map<String, dynamic>> listeClientSnapshot = await FirebaseFirestore.instance.collection('clients').get();

      //Convertir les documents Firestore en une liste 
      List<Client> listes = listeClientSnapshot.docs.map((doc) {
            return Client.fromMap(
              doc.data() as Map<String, dynamic>, doc.reference
            );
          }).toList();

      return listes;
    } catch (e) {
      print('Erreur lors de la récupération des clients: $e');
      return [];
    }
  }


  // Ajoutez cette méthode si nécessaire pour fermer le stream
  void dispose() {
    _listeClientsController.close();
  }
  
}
