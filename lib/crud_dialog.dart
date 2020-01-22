import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pertemuan3/mahasiswa.dart';

class CrudDialog{
  final teName = TextEditingController();
  final teUmur = TextEditingController();
  final teJenisKelamin = TextEditingController();
  Mahasiswa user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );


Widget buildAboutDialog(BuildContext context, AddUserCallback _myHomePageState, bool isEdit, Mahasiswa user) {
  if(user != null) {
    this.user = user;
    teName.text = user.nama;
    teUmur.text = user.umur;
    teJenisKelamin.text = user.jenis_kelamin;
  }

  return new AlertDialog(
    title: new Text(isEdit ? 'Edit detail' : 'Add new user!'),
    content: new SingleChildScrollView(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getTextField("Nama", teName),
          getNumberField("Umur", teUmur),
          getTextField("Jenis Kelamin", teJenisKelamin),
          new GestureDetector(
            onTap: () => onTap(isEdit, _myHomePageState, context),
            child: new Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: getAppBorderButton(isEdit ? "Edit" : "Add", 
                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0))
            ),
          )
        ],
      ),
      ),
  );
}



Widget getTextField(String inputBoxName, TextEditingController inputBoxController) {
  var loginBtn = new Padding(
    padding:  const EdgeInsets.all(5.0),
    child: new TextFormField(
      controller: inputBoxController,
      decoration: new InputDecoration(
        hintText: inputBoxName,
      ),
      ),
  );
  return loginBtn;
}

Widget getNumberField(String inputBoxName, TextEditingController inputBoxController) {
  var loginBtn = new Padding(
    padding:  const EdgeInsets.all(5.0),
    child: new TextField(
              controller: inputBoxController,
              decoration: new InputDecoration(
              hintText: inputBoxName,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
  );
  return loginBtn;
}




Widget getAppBorderButton(String buttonLabel, EdgeInsets margin){
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
        letterSpacing: 0.2,
      ),
    ),

  );
  return loginBtn;
}

Mahasiswa getData(bool isEdit){
  return new Mahasiswa(isEdit ? user.id: "", teName.text, teUmur.text, teJenisKelamin.text);
}


onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context){
  if(isEdit){
    _myHomePageState.update(getData(isEdit));

  } else {
    _myHomePageState.addUser(getData(isEdit));
  }

  Navigator.of(context).pop();
}
}

abstract class AddUserCallback{
  void addUser(Mahasiswa user);

  void update(Mahasiswa user);
}