import 'package:cloud_firestore/cloud_firestore.dart';

class Type {
  String? typeId;
  String nom;

  Type({
    required this.typeId,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Type(
      typeId: docRef.id,
      nom: map['nom'],
    );
  }

  Future<void> create() async {
    final docRef = await FirebaseFirestore.instance.collection('types').add(toMap());
    typeId = docRef.id;
  }
}

class TypesService {
  Future<List<Type>> getTypesList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> listeTypesSnapshot =
          await FirebaseFirestore.instance.collection('types').get();

      List<Type> listes = listeTypesSnapshot.docs.map((doc) {
        return Type.fromMap(
          doc.data() as Map<String, dynamic>, doc.reference,
        );
      }).toList();

     // print(listes.map((type) => type.nom).toList()); // Ajoutez ce print
      
      
      return listes;
    } catch (e) {
      print('Erreur lors de la récupération des types: $e');
      return [];
    }
  }
}
