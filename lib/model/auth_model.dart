class AuthModel{
  static const userName = "full_name";
  static const userEmail = "email";
  static const userMobile = "mobile";
  static const userId = "uid";
  static const userPassword = "password";
  static const canteenImage = "canteen_image";
  static const fcmToken = "Token";
  String? name;
  String? email;
  String? password;
  String? image;
  String? uid;
  String? type;
  String? gender;
  String? mobile;
  String? token;
  AuthModel({
    this.name,
    this.email,
    this.image,
    this.password,
    this.uid,
    this.gender,
    this.mobile,
    this.type,
    this.token
  }
      );
  AuthModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    password = data[userPassword];
    image = data[canteenImage];
    uid = data[userId];
    token = data[fcmToken];
    mobile = data[userMobile];
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      canteenImage:image
    };
  }
}