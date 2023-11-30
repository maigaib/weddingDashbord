// Table taches

import 'package:cloud_firestore/cloud_firestore.dart';

class Tache {
  String? tacheId;
  String nom;
  String description;
  String? status;
  bool isChecked; 
  DateTime date;
  String mariageId;

  Tache({
    required this.tacheId,
    required this.nom,
    required this.description,
    required this.status,
    this.isChecked = false,
     required this.date,
    required this.mariageId,
  });

  factory Tache.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Tache(
      tacheId: docRef.id,
      nom: map['nom'],
      description: map['description'],
      status: map['isChecked'],
      date: (map['date'] as Timestamp).toDate(),
      mariageId: map['mariageId'],
    );
  }
// Future<void> create() async {
//     final docRef = await FirebaseFirestore.instance.collection('taches').add(toMap());
//     tacheId = docRef.id;
//   }
  
  Map<String, dynamic> toMap() {
    return{
      'nom' :nom,
      'description': description,
      'status':isChecked,
      'date' : date,
      'mariageId' : mariageId
    };
  }
}

