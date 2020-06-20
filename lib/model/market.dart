import 'dart:convert';

class Market {
  String id;
  String name;
  int order;
  int status;
  String createDt;
  String createdBy;
  Null updateDt;
  Null updatedBy;

  Market(
      {this.id,
      this.name,
      this.order,
      this.status,
      this.createDt,
      this.createdBy,
      this.updateDt,
      this.updatedBy});

  factory Market.fromJson(Map<String, dynamic> map) {
    return Market(
        id: map['id'],
        name: map['name'],
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
    map['name'] = this.name;
    map['order'] = this.order;
    map['status'] = this.status;
    map['createDt'] = this.createDt;
    map['createdBy'] = this.createdBy;
    map['updateDt'] = this.updateDt;
    map['updatedBy'] = this.updatedBy;

    return json.encode(map);
  }
}
