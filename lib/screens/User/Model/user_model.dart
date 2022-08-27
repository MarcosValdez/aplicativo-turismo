class UserModel {
  String? uid;
  String? email;
  String? nombre;
  String? pais;

  UserModel({this.uid, this.email, this.nombre, this.pais});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nombre: map['nombre'],
      pais: map['pais']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'pais':pais
    };
  }
}