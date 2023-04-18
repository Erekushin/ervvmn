class ConvsM {
  List<EachConvM>? data;
  bool? error;

  ConvsM({this.data, this.error});

  ConvsM.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EachConvM>[];
      json['data'].forEach((v) {
        data!.add(EachConvM.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class ConversationM {
  EachConvM? data;
  bool? error;

  ConversationM({this.data, this.error});

  ConversationM.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EachConvM.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class EachConvMsjs {
  List<Msgs>? data;
  bool? error;

  EachConvMsjs({this.data, this.error});

  EachConvMsjs.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Msgs>[];
      json['data'].forEach((v) {
        data!.add(Msgs.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class MsgM {
  Msgs? data;
  bool? error;

  MsgM({this.data, this.error});

  MsgM.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Msgs.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class EachConvM {
  int? id;
  String? title;
  bool? isGroup;
  String? img;
  List<int>? participants;
  List<int>? show;
  String? createdAt;
  String? updatedAt;
  List<ConvManyUsers>? convManyUsers;
  List<Msgs>? msgs;

  EachConvM(
      {this.id,
      this.title,
      this.isGroup,
      this.img,
      this.participants,
      this.show,
      this.createdAt,
      this.updatedAt,
      this.convManyUsers,
      this.msgs});

  EachConvM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isGroup = json['isGroup'];
    img = json['img'];
    participants = json['participants'].cast<int>();
    show = json['show'].cast<int>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['ConvManyUsers'] != null) {
      convManyUsers = <ConvManyUsers>[];
      json['ConvManyUsers'].forEach((v) {
        convManyUsers!.add(ConvManyUsers.fromJson(v));
      });
    }
    if (json['msgs'] != null) {
      msgs = <Msgs>[];
      json['msgs'].forEach((v) {
        msgs!.add(Msgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isGroup'] = isGroup;
    data['img'] = img;
    data['participants'] = participants;
    data['show'] = show;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (convManyUsers != null) {
      data['ConvManyUsers'] = convManyUsers!.map((v) => v.toJson()).toList();
    }
    if (msgs != null) {
      data['msgs'] = msgs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConvManyUsers {
  int? id;
  String? username;
  String? regNo;
  String? lastName;
  String? firstName;
  String? familyName;
  String? userInfo;
  ConvUsers? convUsers;

  ConvManyUsers(
      {this.id,
      this.username,
      this.regNo,
      this.lastName,
      this.firstName,
      this.familyName,
      this.userInfo,
      this.convUsers});

  ConvManyUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    regNo = json['reg_no'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    familyName = json['family_name'];
    userInfo = json['user_info'];
    convUsers = json['conv_users'] != null
        ? ConvUsers.fromJson(json['conv_users'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['reg_no'] = regNo;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['family_name'] = familyName;
    data['user_info'] = userInfo;
    if (convUsers != null) {
      data['conv_users'] = convUsers!.toJson();
    }
    return data;
  }
}

class ConvUsers {
  String? createdAt;
  String? updatedAt;
  int? conId;
  int? userId;

  ConvUsers({this.createdAt, this.updatedAt, this.conId, this.userId});

  ConvUsers.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    conId = json['conId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['conId'] = conId;
    data['userId'] = userId;
    return data;
  }
}

class Msgs {
  int? id;
  int? conId;
  int? owner;
  String? msg;
  String? type;
  List<int>? seen;
  String? createdAt;
  String? updatedAt;

  Msgs(
      {this.id,
      this.conId,
      this.owner,
      this.msg,
      this.type,
      this.seen,
      this.createdAt,
      this.updatedAt});

  Msgs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conId = json['conId'];
    owner = json['owner'];
    msg = json['msg'];
    type = json['type'];
    seen = json['seen'].cast<int>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conId'] = conId;
    data['owner'] = owner;
    data['msg'] = msg;
    data['type'] = type;
    data['seen'] = seen;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
