class UserEntranceData {
  String? token;
  UserInfo? userInfo = UserInfo();
  String? expireIn;

  UserEntranceData({this.token, this.userInfo, this.expireIn});

  UserEntranceData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
    expireIn = json['expire_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    data['expire_in'] = expireIn;
    return data;
  }
}

class UserInfo {
  int? id;
  String? regNo;
  String? firstName;
  String? lastName;
  String? familyName;
  String? civilId;
  String? phone;
  String? username;
  String? email;
  String? birthDate;
  int? gender;
  String? userInfo;
  String? profilePicture;
  int? isXypSync;
  String? rootAccount;
  String? passportExpireDate;
  String? passportIssueDate;
  String? aimagCode;
  String? sumCode;
  String? bagCode;
  String? address;
  int? isPhoneActivated;
  int? isEmailActivated;
  String? country;
  String? docmentNumber;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isForeign;
  String? countryName;
  String? passportNo;
  String? passportType;
  String? nationality;
  String? hash;

  UserInfo(
      {this.id,
      this.regNo,
      this.firstName,
      this.lastName,
      this.familyName,
      this.civilId,
      this.phone,
      this.username,
      this.email,
      this.birthDate,
      this.gender,
      this.userInfo,
      this.profilePicture,
      this.isXypSync,
      this.rootAccount,
      this.passportExpireDate,
      this.passportIssueDate,
      this.aimagCode,
      this.sumCode,
      this.bagCode,
      this.address,
      this.isPhoneActivated,
      this.isEmailActivated,
      this.country,
      this.docmentNumber,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isForeign,
      this.countryName,
      this.passportNo,
      this.passportType,
      this.nationality,
      this.hash});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNo = json['reg_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    familyName = json['family_name'];
    civilId = json['civil_id'];
    phone = json['phone'];
    username = json['username'];
    email = json['email'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    userInfo = json['user_info'];
    profilePicture = json['profile_picture'] == ''
        ? 'a91b623f56554d19bae4dc32a385e7ff.png'
        : json['profile_picture'];
    isXypSync = json['is_xyp_sync'];
    rootAccount = json['root_account'];
    passportExpireDate = json['passport_expire_date'];
    passportIssueDate = json['passport_issue_date'];
    aimagCode = json['aimag_code'];
    sumCode = json['sum_code'];
    bagCode = json['bag_code'];
    address = json['address'];
    isPhoneActivated = json['is_phone_activated'];
    isEmailActivated = json['is_email_activated'];
    country = json['country'];
    docmentNumber = json['docment_number'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isForeign = json['is_foreign'];
    countryName = json['country_name'];
    passportNo = json['passport_no'];
    passportType = json['passport_type'];
    nationality = json['nationality'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reg_no'] = regNo;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['family_name'] = familyName;
    data['civil_id'] = civilId;
    data['phone'] = phone;
    data['username'] = username;
    data['email'] = email;
    data['birth_date'] = birthDate;
    data['gender'] = gender;
    data['user_info'] = userInfo;
    data['profile_picture'] = profilePicture;
    data['is_xyp_sync'] = isXypSync;
    data['root_account'] = rootAccount;
    data['passport_expire_date'] = passportExpireDate;
    data['passport_issue_date'] = passportIssueDate;
    data['aimag_code'] = aimagCode;
    data['sum_code'] = sumCode;
    data['bag_code'] = bagCode;
    data['address'] = address;
    data['is_phone_activated'] = isPhoneActivated;
    data['is_email_activated'] = isEmailActivated;
    data['country'] = country;
    data['docment_number'] = docmentNumber;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['is_foreign'] = isForeign;
    data['country_name'] = countryName;
    data['passport_no'] = passportNo;
    data['passport_type'] = passportType;
    data['nationality'] = nationality;
    data['hash'] = hash;
    return data;
  }
}
