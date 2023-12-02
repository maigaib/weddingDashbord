// Table prestataires
import 'package:cloud_firestore/cloud_firestore.dart';
class Prestataire {
  String? prestataireId;
  String nom;
  String email;
  String description;
  String tel;
  double note;
  String? typesId;

  Prestataire({
    required this.prestataireId,
    required this.nom,
    required this.email,
    required this.description,
    required this.tel,
    required this.note,
    required this.typesId,
  });


    Map<String, dynamic> toMap() {
    return {
     
      'nom': nom,
      'email': email,
      'description': description,
      'tel': tel,
      'note': note,
      'typesId': typesId,
    };
  }

  factory Prestataire.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Prestataire(
      prestataireId: docRef.id,
      nom: map['nom'],
      email: map['email'],
      description: map['description'],
      tel: map['tel'],
      note: map['note'],
      typesId: map['typesId'],
    );
  }

   Future<void> create() async {
    final docRef = await FirebaseFirestore.instance.collection('prestataires').add(toMap());
    prestataireId = docRef.id;
  }


}
