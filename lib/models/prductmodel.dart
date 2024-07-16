class Company {
  String imageurl;
  String CompanyName;
  String CompanyCharge;
  String? uid;
  bool wdwide;

  Company({
    required this.CompanyName,
    required this.imageurl,
    required this.CompanyCharge,
    this.uid,
    required this.wdwide,
  });

  Map<String, dynamic> tojson(uidp) => {
        'imageurl': imageurl,
        'CompanyName': CompanyName,
        'CompanyCharge': CompanyCharge,
        'uid': uidp,
        'WorlWide': wdwide
      };

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        imageurl: json['imageurl'],
        CompanyName: json['CompanyName'],
        CompanyCharge: json['CompanyCharge'],
        uid: json['uid'],
        wdwide: json['WorlWide']);
  }
}
