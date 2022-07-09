class TranslateModel
{
  String id;
  String email;
  String idm_origen;
  String idm_traduc;
  String txt_origen;
  String txt_traduc;
  String imagen;

  TranslateModel(this.id, this.email, this.idm_origen, this.idm_traduc, this.txt_origen, this.txt_traduc, this.imagen);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'idm_origen': idm_origen,
      'idm_traduc': idm_traduc,
      'txt_origen': txt_origen,
      'txt_traduc': txt_traduc,
      'imagen': imagen
    };
  }
}

