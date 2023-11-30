// Table types
class Types {
  int typesId;
  String nom;

  Types({
    required this.typesId,
    required this.nom,
  });

  factory Types.fromMap(Map<String, dynamic> map) {
    return Types(
      typesId: map['typesId'],
      nom: map['nom'],
    );
  }
}
