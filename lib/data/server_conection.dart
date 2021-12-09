import 'dart:convert';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

class server_conection {
  final _svrUrlRead = 'https://sheetsu.com/apis/v1.0su/6622c522aed3/sheets/';
  final _svrUrlInsert =
      'https://sheet.best/api/sheets/31cab913-4125-4b3f-80b0-713601feaaac/tabs/';

  Future<dynamic> select(String object, {int id}) async {
    final url = id == null
        ? Uri.parse(_svrUrlRead + object)
        : Uri.parse('$_svrUrlRead$object/${id.toString()}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Response status: ${response.statusCode}';
    }
  }

  Future<dynamic> searchUser(String userName, String password) async {
    final url = Uri.parse(
        '${_svrUrlRead}users/search?userName=$userName&password=$password');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // return response.body;
      return '${response.statusCode}';
    } else {
      return '${response.statusCode}';
    }
  }

  Future<String> insert(String object, Map<String, dynamic> data) async {
    final url = Uri.parse(_svrUrlInsert + object);
    var jsonBody = json.encode(data);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    var jsonRes = JSON.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return '${response.statusCode}';
    } else {
      return '${response.statusCode}';
    }
  }
}

server_conection API = server_conection();
