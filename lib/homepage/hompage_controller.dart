import 'dart:developer';
import 'package:eska_link/model/user_model.dart';
import 'package:eska_link/model/user_repository.dart';
import 'package:eska_link/network/localDB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ListenerTypes {
  edit,
  delete,
  create,
}

class HomepageController extends GetxController {
  final RxList<UserModel> _user = <UserModel>[].obs;
  RxList<UserModel> get user => _user;

  final RxList<User> _userDB = <User>[].obs;
  RxList<User> get userDB => _userDB;

  final _userRepo = UserRepository();
  final _userDBRepo = Get.put(LocalDB());
  final _data = Get.find<LocalDB>();

  TextEditingController nikTC = TextEditingController();
  TextEditingController namaTC = TextEditingController();
  TextEditingController umurTC = TextEditingController();
  TextEditingController kotaTC = TextEditingController();

  final listnerType = ListenerTypes.create.obs;
  final userId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    dataFromAPI();
    getUser();
  }

  dataFromAPI() async {
    if (_userDB.isEmpty) {
      _user.addAll((await _userRepo.getUserFromAPI()) ?? []);

      if (_user.isNotEmpty) {
        for (var i = 0; i < _user.length; i++) {
          await _userDBRepo.insertUser(
            User(
                id: i,
                nik: _user[i].nik!,
                nama: _user[i].nama!,
                umur: _user[i].umur!,
                kota: _user[i].kota!),
          );
        }
      }
      getUser();
    }
  }

  createUser() async {
    if (nikTC.text != "" &&
        namaTC.text != "" &&
        umurTC.text != "" &&
        kotaTC.text != "") {
      var user = User(
          id: _userDB.isNotEmpty ? _userDB.last.id + 1 : 0,
          nik: nikTC.text,
          nama: namaTC.text,
          umur: int.parse(umurTC.text),
          kota: kotaTC.text);
      await _userDBRepo.insertUser(user);
      cancelEdit();
      getUser();
    } else {
      log('cant be empty');
    }
  }

  getUser() async {
    _userDB.clear();
    _userDB.addAll(await _userDBRepo.users());

    log('user db ${_userDB.length}');

    update();
  }

  updateUser(int id) async {
    // var user = User(id: id, nik: nik, nama: nama, umur: umur, kota: kota);
    // await _userDBRepo.updateUser(user);

    if (nikTC.text != "" &&
        namaTC.text != "" &&
        umurTC.text != "" &&
        kotaTC.text != "") {
      var user = User(
          id: id,
          nik: nikTC.text,
          nama: namaTC.text,
          umur: int.parse(umurTC.text),
          kota: kotaTC.text);
      await _userDBRepo.updateUser(user);
      cancelEdit();
      getUser();
    } else {
      log('cant be empty');
    }
  }

  deleteUser(int id) async {
    await _userDBRepo.deleteUser(id);
    getUser();
  }

  editOnTap(int id, String nik, String nama, int umur, String kota) {
    nikTC.text = nik;
    namaTC.text = nama;
    umurTC.text = umur.toString();
    kotaTC.text = kota;
    listnerType.value = ListenerTypes.edit;

    userId.value = id;

    log('listener ${listnerType.value}');
  }

  cancelEdit() {
    nikTC.text = '';
    namaTC.text = '';
    umurTC.text = '';
    kotaTC.text = '';
    listnerType.value = ListenerTypes.create;
  }
}
