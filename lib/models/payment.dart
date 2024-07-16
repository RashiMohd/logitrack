 

class AddOrderPyament {
  String username;
  String uid;
  String contactnumber;
  String payment;

  AddOrderPyament({
    required this.username,
    required this.uid,
    required this.contactnumber,
    required this.payment,
  });

  Map<String, dynamic> toJsone(id) => {
        'username': username,
        'uid': id,
        'Contactnumber': contactnumber,
        'Payment': payment
      };

  factory AddOrderPyament.fromjson(Map<String, dynamic> jsone) {
    return AddOrderPyament(
      username: jsone['username'],
      uid: jsone['uid'],
      contactnumber: jsone['contactnumber'],
      payment: jsone['Payment'],
    );
  }
}
