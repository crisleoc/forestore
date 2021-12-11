import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/components/btn_complete_info.dart';
import 'package:forestore/components/btn_create_store.dart';
import 'package:forestore/components/btn_edit_store.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class ProfileMain extends StatefulWidget {
  UserInfoRes? usuario;
  ProfileMain({Key? key, this.usuario}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState(usuario);
}

class _ProfileMainState extends State<ProfileMain> {
  final UserInfoRes? usuario;
  _ProfileMainState(this.usuario);

  int _incompleteDataCounter = 0;

  Image getUserImg() {
    if (usuario!.profileImg != "") {
      return Image.network(
        usuario!.profileImg!,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/noImg.png',
        fit: BoxFit.cover,
      );
    }
  }

  String? getDataString(String? data) {
    if (data != "") {
      return data;
    } else {
      setState(() {
        _incompleteDataCounter++;
      });
      return "No data";
    }
  }

  Widget getBtnProfile() {
    if (_incompleteDataCounter != 0) {
      return BtnCompleteInfo(
        usuario: usuario,
      );
    } else if (usuario!.storeId == '') {
      return BtnCreateStore(usuario: usuario);
    } else if (usuario!.storeId != '') {
      return BtnEditeStore(
        usuario: usuario,
      );
    }
    throw ('xd');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(width: 1.5, color: Colors.white),
                      ),
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: getUserImg(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          width: 1.5,
                          color: MyColors.blue100,
                        )),
                      ),
                      child: Text(
                        usuario!.userName!,
                        style: TextStyle(
                          color: MyColors.blue100,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 160,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        getDataString(usuario!.name)!,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 160,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        getDataString(usuario!.phone)!,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 160,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        getDataString(usuario!.email)!,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              getDataString(usuario!.direction)!,
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: MyColors.yellow200,
              ),
            ),
          ),
          getBtnProfile(),
        ],
      ),
    );
  }
}
