// Table depenses
import 'package:cloud_firestore/cloud_firestore.dart';

class Depense {
  String? depenseId;
  String description;
  int depensesMontant;
  String budgetId;

  Depense({
    required this.depenseId,
    required this.description,
    required this.depensesMontant,
    required this.budgetId,
  });

  factory Depense.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Depense(
      depenseId: docRef.id,
      description: map['description'],
      depensesMontant: map['depensesMontant'],
      budgetId: map['budgetId'],
    );
  }

  Map<String, dynamic> toMap() {

    return{
      'description' : description,
      'depensesMontant' : depensesMontant,
      'budgetId' : budgetId
    };

  }
}