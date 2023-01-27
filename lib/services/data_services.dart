import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_model.dart';

class UserDataSource {
  static const url = 'https://jsonplaceholder.typicode.com/photos';

//get User

  Future<List<UserModel>> getUser() async {
    var response = await http.get(Uri.parse(url));
    Iterable userList = json.decode(response.body);
    List<UserModel> users =
        userList.map((user) => UserModel.fromJson(user)).toList();
    return users;
  }
}
