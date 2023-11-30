import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String? clientId;
  final String nom;
  final String prenom;
  final String email;
  final String adresse;
  final String telephone;
  final String? mot_Passe;

  Client({
    required this.clientId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.adresse,
    required this.telephone,
    required this.mot_Passe,
  });

  factory Client.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Client(
      clientId: docRef.id,
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      adresse: map['adresse'],
      telephone: map['telephone'],
      mot_Passe: map['mot_Passe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
     
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'adresse': adresse,
      'telephone': telephone,
      'mot_Passe': mot_Passe,
    };
  }
  Future<void> create() async {
    final docRef = await FirebaseFirestore.instance.collection('clients').add(toMap());
    clientId = docRef.id;
  }

}
