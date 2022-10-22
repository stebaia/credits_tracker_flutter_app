import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:credits_tracker_flutter_app/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database/db.dart';
import '../../utils/bezier_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _entryField(String title, TextEditingController controller,
        {bool isPassword = false}) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: controller,
                    decoration: InputDecoration(

                        //formStore.setVisibility(!formStore.isVisibile),

                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ]));
    }

    void loginRequest(
      String email,
      String password,
      BuildContext buildContext,
    ) {}

    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.orange),
            children: [
              TextSpan(
                text: 'Dunkest',
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: 'Poppins'),
              ),
              TextSpan(
                text: 'Tracker',
                style: TextStyle(
                    color: Colors.orange, fontSize: 30, fontFamily: 'Poppins'),
              ),
            ]),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Stack(
          children: [
            Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _title(),
                  SizedBox(
                    height: 20,
                  ),
                  _entryField('Username', textEditingControllerEmail),
                  //_entryField('Password', textEditingControllerPassword, isPassword: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          checkAccess(textEditingControllerEmail.text).then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HomePage(username: textEditingControllerEmail.text,))),
                                  ModalRoute.withName('/home'));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Invalid username"))
                              );
                            }
                          });
                        },
                        child: Text("Clicca per loggarti"),
                      )),
                ],
              ),
            )
          ],
        )));
  }
}
