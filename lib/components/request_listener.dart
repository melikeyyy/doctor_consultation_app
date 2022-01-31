//import 'package:doctor_consultation_app/components/search_bar.dart';
import 'package:doctor_consultation_app/databaseClasses/anabilim.dart';
import 'package:doctor_consultation_app/databaseClasses/doktor.dart';
import 'package:doctor_consultation_app/databaseClasses/uzmanlik.dart';
import 'package:flutter/cupertino.dart';
import 'package:doctor_consultation_app/components/requestParser.dart';

class httpListener extends ChangeNotifier{
  Doktorlar d = Doktorlar();
  Uzmanliklar u = Uzmanliklar();
  Anabilimler a = Anabilimler();

  void setupDoktorlarListener(){
    doktorlar().asStream().listen((value) {
       d = value as Doktorlar; 
       notifyListeners();
    });
  }
  void setupUzmanliklarListener(){
    uzmanliklar().asStream().listen((value) {
       u = value as Uzmanliklar; 
       //notifyListeners();
    });
    doktorlar().asStream().listen((value) {
       d = value as Doktorlar; 
       notifyListeners();
    });
  }
  void setupAnabilimlerListener(){
    anabilimler().asStream().listen((value) {
       a = value as Anabilimler; 
       notifyListeners();
    });
    doktorlar().asStream().listen((value) {
       d = value as Doktorlar; 
       notifyListeners();
    });
  }
}