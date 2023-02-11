import 'dart:convert';
import 'dart:developer';
import 'package:eska_link/model/user_model.dart';

import '../../network/api_endpoints.dart';
import '../../network/base_repo.dart';
import '../../network/base_result.dart';
import 'user_model.dart';

class UserRepository extends BaseRepo {
  UserRepository();

  Future<List<UserModel>?> getUserFromAPI() async {
    BaseResult response = await post(Endpoint.user);
    switch (response.status) {
      case ResponseStatus.success:
        try {
          var a = json.decode(response.data);
          return (a['data'] as List).map((e) => UserModel.fromJson(e)).toList();
        } catch (e) {
          log("error $e");
          return null;
        }
      default:
        break;
    }
    return null;
  }
}
