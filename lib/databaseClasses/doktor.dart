import 'dart:convert';

class Doktor {  //veri tabanında bir doktor listesi satırına karşılık gelen class
  final userId;
  final name;
  final surName;
  final pswd;
  final department;

  Doktor({
    this.userId,
    this.name,
    this.surName,
    this.pswd,
    this.department
  });

  factory Doktor.fromJson(Map<String, dynamic> json) {  //gelen json nesnesini class değişkenlerine aktarır
    return Doktor(
      userId: json['DoktorID'],
      name: json['Doktor_adi'],
      surName: json['Doktor_soyadi'],
      pswd: json['Doktor_sifresi'],
      department: json['anabilim_dali']
    );
  }
}

class Doktorlar{
  List<Doktor> doktorlar;

  Doktorlar({this.doktorlar});

  factory Doktorlar.fromJson(List<dynamic> parsedJson){
    List<Doktor> doktorlar;
    doktorlar = parsedJson.map((i)=>Doktor.fromJson(i)).toList();

    return Doktorlar(
      doktorlar: doktorlar,
    );
  }

  List<String> doktor_isimleri(){
    List<String> isimler = new List<String>();
    for(int i = 0 ; i < doktorlar.length ; i++)
      isimler.add(doktorlar[i].name);

    return isimler;
  }
}


Doktorlar parseDoktorlar(response){
  return Doktorlar.fromJson(json.decode(response.body)); 
}