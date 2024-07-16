class CompanyModel {
  String companyname;
  String email;
  String companylisence;
  String CompanyLocation;
  String password;
  String? uid;

  CompanyModel({
    required this.companyname,
    required this.email,
    required this.companylisence,
    required this.CompanyLocation,
    required this.password,
    this.uid,
  });

  Map<String, dynamic> toJson(uidd) => {
        'companyName': companyname,
        'email': email,
        'CompanyLisence': companylisence,
        'companyLocation': CompanyLocation,
        'password': password,
        'Uid': uidd,
      };

  factory CompanyModel.fromJsone(Map<String, dynamic> json) {
    return CompanyModel(
      companyname: json['companyName'],
      email: json['email'],
      companylisence: json['CompanyLisence'],
      CompanyLocation: json['companyLocation'],
      password: json['password'],
    );
  }
}
