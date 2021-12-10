import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/pages/edit_info_form.dart';
import 'package:forestore/pages/loading_page.dart';
import 'package:forestore/tokens/forestore_colors.dart';

class EditeInfo extends StatelessWidget {
  const EditeInfo({Key key, this.usuario}) : super(key: key);
  final UserInfoRes usuario;

  Widget getForm() {
    if (usuario != null) {
      return EditInfoForm(
        usuario: usuario,
      );
    } else {
      return LoadingPage(
        background: MyColors.yellow300,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getForm();
  }
}
