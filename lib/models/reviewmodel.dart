class ReviewModel {
  String review;
  String uid;
  String? id;

  ReviewModel({
    required this.review,
    required this.uid,
    this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'Review': review,
        'uid': uid,
        'id': idd,
      };

  factory ReviewModel.fromjsone(Map<String, dynamic> jsone) {
    return ReviewModel(
      review: jsone['Review'],
      uid: jsone['uid'],
      id: jsone['id'],
    );
  }
}
