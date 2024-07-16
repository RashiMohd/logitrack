
class DeliveryBoysModel {
  String Name;
  String Email;
  String DLNumber;
  String Vehiclenumber;
  String? id;
  String vehicl;

  DeliveryBoysModel({
    required this.Name,
    required this.Email,
    required this.DLNumber,
    required this.Vehiclenumber,
    this.id,
    required this.vehicl,
  });

  Map<String, dynamic> tojson(uid) => {
        'Name': Name,
        'Email': Email,
        'DLNumber': DLNumber,
        'VehicleNumber': Vehiclenumber,
        'id': uid,
        'vehicle':vehicl,
      };

  factory DeliveryBoysModel.fromJson(Map<String, dynamic> json) {
    return DeliveryBoysModel(
      Name: json['Name'],
      Email: json['Email'],
      DLNumber: json['DLNumber'],
      Vehiclenumber: json['VehicleNumber'],
      id: json['id'],
      vehicl: json['vehicle']
    );
  }
}
