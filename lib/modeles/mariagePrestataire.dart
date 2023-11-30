// Table mariagesPrestataires
class MariagePrestataire {
  int id;
  int mariageId;
  int prestataireId;

  MariagePrestataire({
    required this.id,
    required this.mariageId,
    required this.prestataireId,
  });

  factory MariagePrestataire.fromMap(Map<String, dynamic> map) {
    return MariagePrestataire(
      id: map['id'],
      mariageId: map['mariageId'],
      prestataireId: map['prestataireId'],
    );
  }
}