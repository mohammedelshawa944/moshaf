import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:moshaf/modules/quran_model.dart';

class Asset{

  Future<List<List<QuranModel>>> fetchData(int page) async{

    List<List<QuranModel>>? pagesAyah = [];
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');
    if(result.isNotEmpty){
      List< dynamic> ayahs =  jsonDecode(result);

      for(int i=1; i<=604; i++){
        List<QuranModel> temp = [];
        ayahs.forEach((element) {
          if(element['page'] == i){
            temp.add(QuranModel.fromJson(element));
          }
        });
        pagesAyah.add(temp);
      }
      return pagesAyah;

    }else{
      return Future.error('error');
    }
  }
}