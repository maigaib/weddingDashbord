// Table relations
class Relation {
  int relationId;
  String nom;

  Relation({
    required this.relationId,
    required this.nom,
  });

  factory Relation.fromMap(Map<String, dynamic> map) {
    return Relation(
      relationId: map['relationId'],
      nom: map['nom'],
    );
  }
}
