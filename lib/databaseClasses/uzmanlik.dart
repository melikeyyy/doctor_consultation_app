import 'dart:convert';

class Uzmanlik {  //veri tabanında bir doktor listesi satırına karşılık gelen class
  final name;

  Uzmanlik({
    this.name,
  });

  factory Uzmanlik.fromJson(Map<String, dynamic> json) {  //gelen json nesnesini class değişkenlerine aktarır
    return Uzmanlik(
      name: json['Uzmanlik_adi'],
    );
  }
}

class Uzmanliklar{
  List<Uzmanlik> uzmanliklar;

  Uzmanliklar({this.uzmanliklar});

  factory Uzmanliklar.fromJson(List<dynamic> parsedJson){
    List<Uzmanlik> uzmanliklar;
    uzmanliklar = parsedJson.map((i)=>Uzmanlik.fromJson(i)).toList();

    return Uzmanliklar(
      uzmanliklar: uzmanliklar,
    );
  }

  List<String> uzmanlik_isimleri(){
    List<String> isimler = new List<String>();
    for(int i = 0 ; i < uzmanliklar.length ; i++)
      isimler.add(uzmanliklar[i].name);

    return isimler;
  }
}


Uzmanliklar parseUzmanlik(response){
  return Uzmanliklar.fromJson(json.decode(response.body)); 
}