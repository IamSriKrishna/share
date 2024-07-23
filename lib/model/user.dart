class UserModel {
  List<Data> data;
  UserModel({this.data = const []});

  factory UserModel.fromJson(List<dynamic> json) {
    return UserModel(data: json.map((e) => Data.fromJson(e)).toList());
    //data: List<Data>.from(json['data'].map((e) => Data.fromJson(e))));
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
        id: json["id"],
        name: json['name'],
        email: json['email'],
        age: json['age']);
  }
}
