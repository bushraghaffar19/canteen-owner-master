
class CustomerModel{
  static const userName = "full_name";
  static const userEmail = "email";
  static const userMobile = "mobile";
  static const userId = "uid";
  static const userPassword = "password";
  static const userType = "user_type";
  static const userGender = "gender";
  static const teaId = "teacher_id";
  static const userProfile = "profile";
  static const fcmToken = "Token";
  static const userCart = "cart";
  String? name;
  String? email;
  String? password;
  String? profile;
  String? uid;
  String? type;
  String? gender;
  String? mobile;
  String? teacherId;
  String? token;
  CustomerModel({
    this.name,
    this.email,
    this.profile,
    this.password,
    this.uid,
    this.gender,
    this.teacherId,
    this.mobile,
    this.type,
    this.token
  }
      );
  CustomerModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    password = data[userPassword];
    profile = data[userProfile];
    uid = data[userId];
    token = data[fcmToken];
    type = data[userType];
    teacherId = data[teacherId];
    mobile = data[userMobile];
    gender = data[userGender];
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      userProfile:profile
    };
  }
}
