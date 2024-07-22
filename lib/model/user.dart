class UserModel {
  final String status;
  final int length;
  List<Data> data;
  UserModel({this.status = "no-status", this.data = const [], this.length = 0});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'length': length,
      'data': data.map((dataItem) => dataItem.toJson()).toList(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        status: json['status'],
        length: json['length'],
        data: List<Data>.from(json['data'].map((e) => Data.fromJson(e))));
  }
}

class Data {
  final String id;
  final String name;
  final int age;
  final String email;
  Data(
      {this.id = "no-id",
      this.age = 0,
      this.email = "no-email",
      this.name = "no-name"});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json["_id"],
        name: json['name'],
        email: json['email'],
        age: json['age']);
  }
   Map<String, dynamic> toJson() {
    return {
      "_id": id,
      'name': name,
      'email': email,
      'age': age,
    };
  }
}
