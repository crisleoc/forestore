import 'package:flutter/material.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/pages/edit_info.dart';
import 'package:forestore/pages/profile_main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  final userName;
  final password;
  ProfileView({
    Key? key,
    this.userName,
    this.password,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState(
        this.userName,
        this.password,
      );
}

class _ProfileViewState extends State<ProfileView> {
  final userNickname;
  final userPassword;
  _ProfileViewState(this.userNickname, this.userPassword);

  UserInfoRes? infoUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0,
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditeInfo(
                          usuario: infoUser,
                        )),
              );
            },
            icon: const Icon(Ionicons.settings_outline),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchUserInfo(userNickname, userPassword),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<UserInfoRes>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              infoUser = snapshot.data![0];
              return ProfileMain(
                usuario: snapshot.data![0],
              );
            }
          },
        ),
      ),
    );
  }

  var url = 'https://sheetsu.com/apis/v1.0su/5a774ce7a249/sheets/';

  Future<List<UserInfoRes>> fetchUserInfo(
      String? userName, String? password) async {
    var link = Uri.parse(
        '${url}users/search?userName=${userName}&password=${password}');
    final resp = await http.get(link);
    return userInfoResFromJson(resp.body);
  }
}
