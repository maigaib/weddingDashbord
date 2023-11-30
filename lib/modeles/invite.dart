// Table invites
class Invite {
  int inviteId;
  String nom;
  String prenom;
  String email;
  String tel;
  int relationId;

  Invite({
    required this.inviteId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.tel,
    required this.relationId,
  });

  factory Invite.fromMap(Map<String, dynamic> map) {
    return Invite(
      inviteId: map['inviteId'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      tel: map['tel'],
      relationId: map['relationId'],
    );
  }
}