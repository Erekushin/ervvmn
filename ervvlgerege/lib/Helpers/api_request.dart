import 'dart:convert';
import 'dart:io';
import 'package:ervvlgerege/Helpers/logging.dart';
import 'package:http/http.dart';
import '../global_constants.dart';

class ApiReq {
  final ereklog = logger(ApiReq);
  var data = '';
  Future<String> postdata(
    var jsonBody,
    String uriAddress,
  ) async {
    // var data;
    try {
      var myheaders = {
        'Authorization': 'Bearer ${GlobalHelpers.auth}',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      Response response = await post(Uri.parse(uriAddress),
          body: json.encode(jsonBody), headers: myheaders);

      print(Client);
      data = utf8.decode(response.bodyBytes);
      return data;
    } on HttpException catch (err) {
      data = '{"code":100,"status":"httpException","message":"$err"}';
      return data;
    } on SocketException catch (socketerr) {
      data = '{"code":101,"status":"SocketException","message":"$socketerr"}';
      return data;
    } catch (e) {
      ereklog.e(e);
      return '';
    } finally {
      ereklog.i('got data');
    }
  }

  Future uploadImage(String filepath, String url) async {
    try {
      var request = MultipartRequest('POST', Uri.parse(url));
      request.files.add(await MultipartFile.fromPath('file', filepath));
      // request.fields['image_type'] = imageType;
      var res = await request.send();
      if (res.statusCode == 401) {
      } else {
        var bodyResponse = await res.stream.bytesToString();
        return bodyResponse;
      }
    } on HttpException catch (err) {
      data = '{"code":100,"status":"httpException","message":"$err"}';
      return data;
    } on SocketException catch (socketerr) {
      data = '{"code":101,"status":"SocketException","message":"$socketerr"}';
      return data;
    } catch (e) {
      ereklog.e(e);
      return '';
    } finally {
      ereklog.i('all done');
    }
  }
}
