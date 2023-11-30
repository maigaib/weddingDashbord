import 'package:cloud_firestore/cloud_firestore.dart';

class Mariage {
  String? mariageId;
  String monsieur;
  String madame;
  String lieu;
  DateTime date;
  String photo;
  int utilisateursId;

  Mariage({
    required this.mariageId,
    required this.monsieur,
    required this.madame,
    required this.lieu,
    required this.date,
    required this.photo,
    required this.utilisateursId,
  });
 // Ajoutez cette méthode pour convertir l'objet Mariage en Map
  Map<String, dynamic> toMap() {
    return {
      // 'mariageId': mariageId,
      'monsieur': monsieur,
      'madame': madame,
      'lieu': lieu,
      'date': date,
      'photo': photo,
      'utilisateursId': utilisateursId,
    };
  }
  factory Mariage.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Mariage(
      mariageId: docRef.id,
      monsieur: map['monsieur'],
      madame: map['madame'],
      lieu: map['lieu'],
      //date: map['date'],
      photo: map['photo'],
      utilisateursId: map['utilisateursId'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  // create funtion

  Future<void> create() async {
    final docRef = await FirebaseFirestore.instance.collection('mariages').add(toMap());
    mariageId = docRef.id;
  }
}