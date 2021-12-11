import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/pages/create_store.dart';
import 'package:forestore/pages/edit_info.dart';
import 'package:forestore/pages/edit_store.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class BtnEditeStore extends StatelessWidget {
  final UserInfoRes? usuario;
  const BtnEditeStore({Key? key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: MyColors.black300,
            offset: Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      child: CupertinoButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 125,
              child: Text(
                'Pulsa aqui para echar un vistazo a tu tienda',
                maxLines: 3,
                softWrap: true,
                style: TextStyle(
                  color: MyColors.black200,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Icon(
              Icons.edit_outlined,
              size: 30,
              color: MyColors.black200,
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditStore(
                usuario: usuario,
              ),
            ),
          );
        },
      ),
    );
  }
}
