import 'package:flutter/material.dart';
import 'package:pertemuan3/mahasiswa.dart';

class CrudDialog {
  final teName = TextEditingController();
  Mahasiswa user;

  //linkStyle
  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  //buildAboutDialog
  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, bool isEdit, Mahasiswa user) {
    if (user != null) {
      this.user = user;
      teName.text = user.nama;
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Edit detail!' : 'Add new user!'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Nama", teName),
            new GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //getTextField
  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  //getAppBorderButton
  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  //getData
  Mahasiswa getData(bool isEdit) {
    return new Mahasiswa(isEdit ? user.id : "", teName.text);
  }

  //onTap
  onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
    } else {
      _myHomePageState.addUser(getData(isEdit));
    }

    Navigator.of(context).pop();

  }
}
//Call back of user dashboad
abstract class AddUserCallback {
  void addUser(Mahasiswa user);
  void update(Mahasiswa user);
}