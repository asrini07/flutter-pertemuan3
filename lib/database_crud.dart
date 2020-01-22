import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:pertemuan3/mahasiswa.dart';

class DatabaseCrud {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;

//suatu function event (stream = async) selain event dia juga nyediain callback
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;

  //pintu utamanya
  FirebaseDatabase database = new FirebaseDatabase();

  int _counter;

  DatabaseError error;

  static final DatabaseCrud _instance = new DatabaseCrud.internal();

  DatabaseCrud.internal();

  factory DatabaseCrud() {
    return _instance;
  }


  void initState() {
    //yang akan di jalankan terlebih dahulu. overide tanpa di pangil akan kepanggil sendiri dalam konsidi tertentu udah auto ke panggil
    //setiap activity ada onCreate, onPause, onResume, onDestroy, onStop, onActivityResult(balik lagi)

    //menginisialisasi counter (key) cara 1 menggunakan file(disarankan untuk file video, foto dll)
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
  //menginisialusasi user (key) cara 2
    _userRef = database.reference().child('user');

  //cari child yang bernama counter
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });

    //mengijinkan firebase menyimpan data di lokal berupa key .dengan size 10juta byte. di jaga agar selalu sinkron.
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }


  //GET FUNCTION
  DatabaseError getError(){
    return error;
  }

  int getCounter(){
    return _counter;
  }

  DatabaseReference getUser(){
    return _userRef;
  }

    // //DELETE USER
  void deleteUser(Mahasiswa user) async {
    await _userRef.child(user.id).remove().then((_){
      print("Trancaction comitted");
    });
  }

  //ADD USER
  addUser(Mahasiswa user) async {
    final TransactionResult transactionResult=
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData; 
    });

    if(transactionResult.committed){
      _userRef.push().set(<String, String>{
        "nama": "" + user.nama
      }).then((_) {
        print('Transaction comitted');
      });
    } else {
      print('Transaction mot commited');
      if(transactionResult.error != null){
        print(transactionResult.error.message);
      }
    }
  }

  //UPDATE USER
  void updateUser(Mahasiswa user) async {
    await _userRef.child(user.id).update({
      "nama": "" + user.nama
    }).then((_) {
      print('Transaction Commited');
    });
  }


  void dispose(){
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }




  




}

