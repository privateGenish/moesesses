void main() async {
  print("Hello World");

  //provider
  var s = CurrentState();
  print(s.currentUser.about);

  //futureBuilder
  await s.initUser.then((v) => print(v.name));
}

class UserModel {
  //param
  String name;
  String about;

  UserModel({this.name = "null"}) : about = callFromCache();

  static callFromCache() => "hi";

  init() async {
    return await MockHttp.getUser();
  }

  updateAbout() async {
    //cache
    //about = http.get("/ewewe/" , )
  }
}

class MockHttp {
  static Future<UserModel> getUser() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return UserModel(name: "someUser");
  }
}

class CurrentState {
  UserModel _currentUser = UserModel();

  UserModel get currentUser => _currentUser;

  Future<UserModel> get initUser async {
    _currentUser = _currentUser.init();
    return _currentUser;
  }
}




//Provider
///Provider.currentUser
///FutureBuilder(
/// future: Provider.initUser
///)