class GeneralRes {
  Stream<String>? codestr;
  String? code;
  String? message;
  // ignore: prefer_typing_uninitialized_variables
  var result;
  String? status;
  GeneralRes({this.code, this.status, this.message, this.result});
  GeneralRes.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    status = json['status'];
    message = json['message'];
    result = json['result'];
  }
}
