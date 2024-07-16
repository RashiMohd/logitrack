 
class Addproductmodel {
  String? id;
  String Pickupfromname;
  String Pickupfromnumber;
  String Pickupaddress;
  String Deliveryname;
  String Deliverynumber;
  String Deliveryadress;
  String Producttype;
  String Prductweight;
  String productid;
  String userid;
  bool? payment;
  String? orderdate;
  String orderstatus;

  Addproductmodel({
    required this.Pickupfromnumber,
    required this.Pickupaddress,
    required this.Pickupfromname,
    this.id,
    required this.Deliveryname,
    required this.Deliverynumber,
    required this.Deliveryadress,
    required this.Producttype,
    required this.Prductweight,
    required this.productid,
    required this.userid,
    this.payment,
    this.orderdate,
    required this.orderstatus,
  });

  Map<String, dynamic> tojson(id) => {
        "Pickupfromnumber": Pickupfromnumber,
        "Pickupaddress": Pickupaddress,
        "id": id,
        'Pickupfromname': Pickupfromname,
        "DeliveryToname": Deliveryname,
        "Deliverytonumber": Deliverynumber,
        "Deliverytoadress": Deliveryadress,
        "ProductType": Producttype,
        "Productweight": Prductweight,
        "productid": productid,
        "userid": userid,
        'payment': payment,
        'orderdate': orderdate,
        'orderstatus': orderstatus,
      };

  factory Addproductmodel.fromJson(Map<String, dynamic> json) {
    return Addproductmodel(
        id: json['id'],
        Pickupfromnumber: json["Pickupfromnumber"],
        Pickupaddress: json["Pickupaddress"],
        Pickupfromname: json['Pickupfromname'],
        Deliveryname: json['DeliveryToname'],
        Deliverynumber: json['Deliverytonumber'],
        Deliveryadress: json['Deliverytoadress'],
        Producttype: json['ProductType'],
        Prductweight: json['Productweight'],
        productid: json['productid'],
        userid: json['userid'],
        payment: json['payment'],
        orderdate: json['orderdate'],
        orderstatus: json['orderstatus']);
  }
}
