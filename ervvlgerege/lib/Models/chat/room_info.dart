class RoomInfo {
  Data? data;
  bool? error;

  RoomInfo({this.data, this.error});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? token;
  String? url;

  Data({this.token, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['url'] = this.url;
    return data;
  }
}
