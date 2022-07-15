class UserModel {
  String? uid;
  String? email;
  String? nombre;

  UserModel({this.uid, this.email, this.nombre});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nombre: map['nombre'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
    };
  }
}