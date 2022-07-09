import 'package:aplicativo_turismo/screens/Dictionary/model/translate_service.dart';
import 'dart:async';
import 'package:aplicativo_turismo/Model/Translate/translate_model.dart';

class TranslateRepository{
  TranslateService _translateService = TranslateService();

  Future<List<TranslateModel>> getTraduccionesEmail(String email) async
  {
    dynamic jsondata = await _translateService.getTraduccionesEmail(email);
    List<TranslateModel>list = [];
    for (var data in jsondata) {
      TranslateModel n = new TranslateModel(
          data['doc_id'],
          data['email'],
          data['idm_origen'],
          data['idm_traduc'],
          data['txt_origen'],
          data['txt_traduc'],
          data['imagen']
      );
      list.add(n);
    }
    return list;
  }

  Future<List<TranslateModel>> getTraducciones() async
  {
    List<TranslateModel>list = [];
    dynamic jsondata = await _translateService.getTraducciones();
    for (var data in jsondata) {
      TranslateModel n = new TranslateModel(
          data['doc_id'],
          data['email'],
          data['idm_origen'],
          data['idm_traduc'],
          data['txt_origen'],
          data['txt_traduc'],
          data['imagen']
      );
      list.add(n);
    }
    return list;
  }

  void deleteTraduccion(String id) async{
    await _translateService.deleteTraduccion(id);
  }

}