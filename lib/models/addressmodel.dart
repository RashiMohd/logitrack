class AddresModel {
  String? id;
  String adress;
  String city;

  AddresModel({
    this.id,
    required this.adress,
    required this.city,
  });

  Map<String, dynamic> toJson(docid) => {
        "id": docid,
        "adress": adress,
        "city": city,
      };

  factory AddresModel.fromJson(Map<String, dynamic> json) {
    return AddresModel(
      id: json['id'],
      adress: json['adress'],
      city: json['city'],
    );
  }
}
