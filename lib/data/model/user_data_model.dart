class User {
  static final User _instance = User._internal();

  User._internal();

  static User get instance => _instance;

  String? userName;
  String? email;
  String? mobileNumber;
  String? password;

  void updateUserData({
    required String userName,
    required String email,
    required String mobileNumber,
    required String password,
  }) {
    this.userName = userName;
    this.email = email;
    this.mobileNumber = mobileNumber;
    this.password = password;
  }

  void clearUserData() {
    userName = null;
    email = null;
    mobileNumber = null;
    password = null;
  }

  bool get isLoggedIn => userName != null && email != null;

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': email,
    'mobileNumber': mobileNumber,
    'password': password,
  };

  void fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }
}