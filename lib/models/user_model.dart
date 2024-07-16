class UserModel {
  String email;
  String password;
  String name;
  String? uid;
  String imageurl;
  String? address;

  UserModel({
    required this.email,
    this.uid,
    required this.password,
    required this.name,
    required this.imageurl,
      this.address,
  });

  Map<String, dynamic> tojson(uid) => {
        "email": email,
        "password": password,
        "id": uid,  
        'name': name,
        'imageurl': imageurl,
        "addres": address,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      uid: json["id"],
      password: json["password"],
      name: json['name'],
      imageurl: json['imageurl'],
      address: json['adress'],
    );
  }
}
