import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forestore/data/server_conection.dart';
import 'package:forestore/model/user_info.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';

class EditInfoForm extends StatefulWidget {
  final UserInfoRes? usuario;
  EditInfoForm({Key? key, this.usuario}) : super(key: key);

  @override
  _EditInfoFormState createState() => _EditInfoFormState(this.usuario);
}

class _EditInfoFormState extends State<EditInfoForm> {
  final UserInfoRes? usuario;
  _EditInfoFormState(this.usuario);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  TextEditingController imgField = TextEditingController();
  TextEditingController nickField = TextEditingController();
  TextEditingController nameField = TextEditingController();
  TextEditingController mailField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController directionField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  String? updateImg;
  String? updateNick;
  String? updateName;
  String? updateMail;
  String? updatePhone;
  String? updateDirection;
  String? updatePassword;

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
      return "No data";
    }
  }

  bool? confirm;
  final _formKey = GlobalKey<FormState>();

  TextStyle label_input = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.black200.withOpacity(0.7),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  TextStyle text_form = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.black200,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text(
            'Editar perfil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back),
          ),
        ),
        backgroundColor: MyColors.yellow300,
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Ingrese los datos que desee cambiar los demás se mantendran igual.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.44,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('URL imagen de perfil'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: imgField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.profileImg),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Nombre de usuario'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: nickField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.userName),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Nombre'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: nameField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.name),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('E-mail'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: mailField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.email),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Teléfono'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: phoneField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.phone),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                            'Dirección (calle, ciudad, estado, país)'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: directionField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.direction),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Contraseña'),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: CupertinoTextField(
                          controller: passwordField,
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: label_input,
                          placeholder: getDataString(usuario!.password),
                          cursorColor: Colors.blue,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          style: text_form,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: MyColors.black300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1.5, color: Colors.black),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(18),
                      color: MyColors.red300,
                      pressedOpacity: 0.8,
                      onPressed: () async {
                        final isYes = await showCupertinoDialog(
                            context: context, builder: DeleteDialog);
                        if (isYes) {
                          EasyLoading.show(status: 'Eliminando...');
                          var srvcon = server_conection();
                          var response = await srvcon.delete(
                            "users",
                            usuario!.id,
                          );
                          EasyLoading.dismiss();
                          var message =
                              response == '200' ? 'Cuenta eliminada' : 'Error';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$message: $response'),
                            ),
                          );
                          if (response == '200') {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1.5, color: Colors.black),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.greenAccent[700],
                      pressedOpacity: 0.8,
                      onPressed: () async {
                        final isYes = await showCupertinoDialog(
                            context: context, builder: UpdateDataDialog);
                        if (isYes) {
                          updateImg = usuario!.profileImg;
                          updateNick = usuario!.userName;
                          updateName = usuario!.name;
                          updateMail = usuario!.email;
                          updatePhone = usuario!.phone;
                          updateDirection = usuario!.direction;
                          updatePassword = usuario!.password;

                          if (!imgField.text.isEmpty) {
                            updateImg = imgField.text;
                          }
                          if (!nickField.text.isEmpty) {
                            updateNick = nickField.text;
                          }
                          if (!nameField.text.isEmpty) {
                            updateName = nameField.text;
                          }
                          if (!mailField.text.isEmpty) {
                            updateMail = mailField.text;
                          }
                          if (!phoneField.text.isEmpty) {
                            updatePhone = phoneField.text;
                          }
                          if (!directionField.text.isEmpty) {
                            updateDirection = directionField.text;
                          }
                          if (!passwordField.text.isEmpty) {
                            updatePassword = passwordField.text;
                          }
                          EasyLoading.show(status: 'Actualizando...');
                          var srvcon = server_conection();
                          var response = await srvcon.update(
                            "users",
                            usuario!.id,
                            {
                              "userName": updateNick,
                              "password": updatePassword,
                              "profileImg": updateImg,
                              "name": updateName,
                              "email": updateMail,
                              "phone": updatePhone,
                              "direction": updateDirection
                            },
                          );
                          EasyLoading.dismiss();
                          var message =
                              response == '200' ? 'Cambios aplicados' : 'Error';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$message: $response'),
                            ),
                          );
                          if (response == '200') {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Icon(
                        Ionicons.save_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget DeleteDialog(BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          "Esta seguro de eliminar su cuenta?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
          ),
        ),
        content: const Text("Si la elimina tendra que registrarse de nuevo",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
            )),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                )),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Ok',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                )),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );

  Widget UpdateDataDialog(BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          "Esta seguro de actualizar sus datos?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                )),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Ok',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                )),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
}
