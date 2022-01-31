import 'dart:convert';

class Anabilim {  //veri tabanında bir doktor listesi satırına karşılık gelen class
  final name;

  Anabilim({
    this.name,
  });

  factory Anabilim.fromJson(Map<String, dynamic> json) {  //gelen json nesnesini class değişkenlerine aktarır
    return Anabilim(
      name: json['Anabilim_adi'],
    );
  }
}

class Anabilimler{
  List<Anabilim> anabilimler;

  Anabilimler({this.anabilimler});

  factory Anabilimler.fromJson(List<dynamic> parsedJson){
    List<Anabilim> anabilimler;
    anabilimler = parsedJson.map((i)=>Anabilim.fromJson(i)).toList();

    return Anabilimler(
      anabilimler: anabilimler,
    );
  }

  List<String> anabilim_isimleri(){
    List<String> isimler = new List<String>();
    for(int i = 0 ; i < anabilimler.length ; i++)
      isimler.add(anabilimler[i].name);

    return isimler;
  }
}


Anabilimler parseAnabilimler(response){
  return Anabilimler.fromJson(json.decode(response.body)); 
}