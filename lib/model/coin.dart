import 'dart:convert';

class Coin {
  String id;
  String normalized;
  String denominator;
  String numerator;
  int order;
  int status;
  String createDt;
  String createdBy;
  Null updateDt;
  Null updatedBy;

  Coin(
      {this.id,
      this.normalized,
      this.denominator,
      this.numerator,
      this.order,
      this.status,
      this.createDt,
      this.createdBy,
      this.updateDt,
      this.updatedBy});

  factory Coin.fromJson(Map<String, dynamic> map) {
    return Coin(
        id: map['id'],
        normalized: map['normalized'],
        denominator: map['denominator'],
        numerator: map['numerator'],
        order: map['order'],
        status: map['status'],
        createDt: map['createDt'],
        createdBy: map['createdBy'],
        updateDt: map['updateDt'],
        updatedBy: map['updatedBy']);
  }

  String toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['normalized'] = this.normalized;
    map['denominator'] = this.denominator;
    map['numerator'] = this.numerator;
    map['order'] = this.order;
    map['status'] = this.status;
    map['createDt'] = this.createDt;
    map['createdBy'] = this.createdBy;
    map['updateDt'] = this.updateDt;
    map['updatedBy'] = this.updatedBy;

    return json.encode(map);
  }
}
