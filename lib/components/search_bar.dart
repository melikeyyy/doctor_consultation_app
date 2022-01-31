import 'package:doctor_consultation_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:doctor_consultation_app/components/request_sender.dart';
import 'package:doctor_consultation_app/dataBaseClasses/doktor.dart';
import 'package:doctor_consultation_app/dataBaseClasses/uzmanlik.dart';
import 'package:doctor_consultation_app/dataBaseClasses/anabilim.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Doktorları ara',
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            onPressed: () async {print((await doktorlar()).doktorlar[0].pswd);},
            color: kOrangeColor,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset('assets/icons/search.png'),
          )
        ),
      ],
    );
  }
}

Future<Doktorlar> doktorlar() async{
  return parseDoktorlar(await listTable("doktor"));
}

Future<Uzmanliklar> uzmanliklar() async{
  return parseUzmanlik(await listTable("uzmanlik"));
}

Future<Anabilimler> anabilimler() async{
  return parseAnabilimler(await listTable("anabilimdali"));
}

