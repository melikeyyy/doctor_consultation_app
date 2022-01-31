import 'package:doctor_consultation_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:doctor_consultation_app/chatScreen/chat.dart';

class DoctorEkran extends StatefulWidget {
  DoctorEkran({Key key, this.ID}) : super(key: key);
  String ID;

  @override
  _DoctorEkranState createState() => _DoctorEkranState(ID);
}

class _DoctorEkranState extends State<DoctorEkran> {
  String ID;
  _DoctorEkranState(this.ID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset('assets/icons/menu.png'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: Text(
                  'Doctor Screen ${ID}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: kTitleTextColor,
                  ),
                ),
              ),
              SizedBox(height: 40),
              MaterialButton(
                onPressed: () {
                  print("Burası da doctor ekran  ${ID}");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage.doktor(
                          ID: ID, dName: "Hasta 3", hastaMi: false)));
                },
                color: kOrangeColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Mesajlara git',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 150,),
              Image.asset('assets/images/3735015.jpg',
              fit: BoxFit.fill,),

              //buildDoctorList(),
            ],
          ),
        ),
      ),
    );
  }
}