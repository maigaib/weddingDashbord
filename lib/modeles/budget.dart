// Table budget
//import 'package:app_wedding_yours/services/mariagesServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  String? budgetId;
  int budgetMontant;
  String mariageId;

  Budget({
    required this.budgetId,
    required this.budgetMontant,
    required this.mariageId, 
  });

  factory Budget.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Budget(
      budgetId: docRef.id,
      budgetMontant: map['budgetMontant'],
      mariageId: map['mariageId'],
    );
  }
  // Future<void> createBudget() async {
  //   final docRef = await FirebaseFirestore.instance.collection('budgets').add(toMap());
  //   budgetId = docRef.id;
  // }
  
  Future<void> createBudget(String mariageId) async {
  final docRef = await FirebaseFirestore.instance.collection('budgets').add({
    ...toMap(), // Utilisez la méthode toMap pour obtenir les autres valeurs
    'mariageId': mariageId,
  });
  budgetId = docRef.id;
}

  Map<String, dynamic> toMap() {
    return {
      'budgetMontant' : budgetMontant,
      'mariageId' : mariageId
    };
  }
}