import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateManagment with ChangeNotifier {
  StateManagment() {
    Auth.getCurrentFirebaseUid().listen((event) {
      _firebaseUidController.add(event);
    });
    _firebaseUidController.stream.listen((event) async {
      _currentFirebaseUid = event;
      if (event != "noUid" && event != null) {
        _currentUserStream = User.asyncGet(event);
        _currentUserStream?.listen((event) {
          _currentUser = event;
          notifyListeners();
          return;
        });
      }
      notifyListeners();
    });
  }

  Stream<User>? _currentUserStream;
  final StreamController<String?> _firebaseUidController =
      StreamController<String>.broadcast();

  getFirebaseUid(context) async {
    _firebaseUidController.add("loading");
    await Future.delayed(Duration(milliseconds: 300))
        .then((value) => _firebaseUidController.add("some uid"));
  }

  User? _currentUser;
  String? _currentFirebaseUid;
  get currentUser => _currentUser;
  String? get currentFirebaseUid => _currentFirebaseUid;
}

class User {
  final String uid;
  String? name;

  User({required this.uid, this.name});

  static Stream<User>? asyncGet(String uid) async* {
    yield User(uid: uid);
    var params = await Future.delayed(const Duration(milliseconds: 1000))
        .then((value) => {"name": "trg"});
    yield User(uid: uid, name: params["name"]);
  }
}

class Auth {
  //some Process that automateclly tries to get the firebase uid
  static Stream<String> getCurrentFirebaseUid() async* {
    yield await Future.delayed(Duration(milliseconds: 1000))
        .then((value) => "noUid");
  }
}
