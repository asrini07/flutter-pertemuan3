import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pertemuan3/mahasiswa.dart';
import 'package:pertemuan3/database_crud.dart';
import 'package:pertemuan3/crud_dialog.dart';

class Beranda extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Beranda> implements AddUserCallback {
  
  bool _anchorToBottom = false;
  DatabaseCrud databaseUtil;

  @override
  void initState(){
    super.initState();
    databaseUtil = new DatabaseCrud();
    databaseUtil.initState();
  }

  @override
  void dispose(){
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child:  new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Data User', 
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> _buildActions(){
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          onPressed: () => showEditWidget(null, false),
        ),
      ];
    }

    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),

      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getUser(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom 
              ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key) 
              : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                    return new SizeTransition(
                      sizeFactor: animation,
                      child: showUser(snapshot),
                    );
                  },
      ),
    );

  }


  Widget showUser(DataSnapshot res) {
    Mahasiswa user = Mahasiswa.fromSnapshot(res);

    var item = new Card(
      child: new Container(
        child: new Center(
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 30.0,
                child: new Text(getShortName(user)),
                backgroundColor: const Color(0xFF20283e),
              ),
              new Expanded(
                child: new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        user.nama,
                        style: new TextStyle(
                          fontSize: 20.0, 
                          color: Colors.lightBlueAccent
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: const Color(0xFF167F67),
                    ),
                    onPressed: () => showEditWidget(user, true),
                  ),
                  new IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: const Color(0xFF167F67)),
                      onPressed: () => deleteUser(user),
                    ),
                ],
              )
            ],
      ),
    ),
    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );
     
    return item;

  }


  String getShortName(Mahasiswa user) {
    String shortName = "";
    if (!user.nama.isEmpty) {
      shortName = user.nama.substring(0, 1);
    }
    return shortName;
  }

  deleteUser(Mahasiswa user){
    setState((){
      databaseUtil.deleteUser(user);
    });
  }

  showEditWidget(Mahasiswa user, bool isEdit){
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new CrudDialog().buildAboutDialog(context, this, isEdit, user),
    );

  }

 

  @override
  void addUser(Mahasiswa user){
    setState((){
      databaseUtil.addUser(user);
    });
  }

  @override
  void update(Mahasiswa user){
    setState((){
      databaseUtil.updateUser(user);
    });
  }
  
}

