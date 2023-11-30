// Table mariagesInvites
class MariageInvite {
  int id;
  int mariageId;
  int inviteId;

  MariageInvite({
    required this.id,
    required this.mariageId,
    required this.inviteId,
  });

  factory MariageInvite.fromMap(Map<String, dynamic> map) {
    return MariageInvite(
      id: map['id'],
      mariageId: map['mariageId'],
      inviteId: map['inviteId'],
    );
  }
}