import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forestore/data/server_conection.dart';
import 'package:forestore/pages/home.dart';
import 'package:forestore/tokens/forestore_colors.dart';
import 'package:ionicons/ionicons.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyColors.green100,
        child: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? _nickName, _password;
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
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    var label_input = TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.black300,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    return SafeArea(
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MyColors.white100,
                    border: Border.all(
                      width: 1.5,
                      color: MyColors.black300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(0, 1)),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Ionicons.close_outline,
                          color: MyColors.black300,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Visibility(
                            visible: false,
                            child: Text('.'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    color: MyColors.black300,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                "assets/forest.png",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 183,
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.white100,
                        border:
                            Border.all(width: 1.5, color: MyColors.black300),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: label_input,
                        decoration: InputDecoration(
                          label: Text(
                            "Nombre de Usuario",
                            style: label_input,
                          ),
                          border: InputBorder.none,
                          icon: Icon(
                            Ionicons.accessibility_outline,
                            color: MyColors.black300,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su nombre de usuario';
                          } else {
                            setState(() {
                              _nickName = value;
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.5, color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: label_input,
                        decoration: InputDecoration(
                          label: Text(
                            "Contraseña",
                            style: label_input,
                          ),
                          border: InputBorder.none,
                          icon: const Icon(
                            Ionicons.lock_closed_outline,
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña';
                          } else {
                            setState(() {
                              _password = value;
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                borderRadius: BorderRadius.circular(18),
                color: MyColors.black300,
                pressedOpacity: 0.8,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // context.showLoaderOverlay();
                    EasyLoading.show(status: 'Cargando...');
                    var srvcon = server_conection();
                    var response = await srvcon.searchUser(
                      _nickName,
                      _password,
                    );
                    // context.hideLoaderOverlay();
                    EasyLoading.dismiss();
                    var message = response == '200'
                        ? 'Ingreso exitoso'
                        : 'Usuario inexistente';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$message: $response'),
                      ),
                    );
                    if (response == '200') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(
                            userName: _nickName,
                            password: _password,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 21,
                    fontFamily: 'Montserrat',
                    color: MyColors.white100,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Eres nuevo?  ',
                  style: TextStyle(),
                ),
                InkWell(
                  child: Text(
                    "Crea una cuenta",
                    style: TextStyle(
                      color: MyColors.red300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ('/signin'));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
