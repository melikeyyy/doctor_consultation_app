import 'package:doctor_consultation_app/databaseClasses/anabilim.dart';
import 'package:doctor_consultation_app/databaseClasses/doktor.dart';
import 'package:doctor_consultation_app/components/request_sender.dart';
import 'package:doctor_consultation_app/databaseClasses/uzmanlik.dart';

Future<Doktorlar> doktorlar() async{
  return parseDoktorlar(await listTable("doktor"));
}
Future<Uzmanliklar> uzmanliklar() async{
  return parseUzmanlik(await listTable("uzmanlik"));
}
Future<Anabilimler> anabilimler() async{
  return parseAnabilimler(await listTable("anabilimdali"));
}
