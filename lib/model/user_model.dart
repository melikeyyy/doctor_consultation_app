class UserModel {
  String uid;
  String email;
  String name;
  String secondName;
  String age;
  String gender;
  String imageUrl;

  UserModel(
      {this.uid, this.email, this.name, this.age, this.gender, this.imageUrl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        age: map['age'],
        gender: map['gender'],
        imageUrl: map['imageUrl']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrl': imageUrl,
    };
  }
}
