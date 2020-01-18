import 'package:firebase_database/firebase_database.dart';

class Mahasiswa {
  String _id;
  String _nama;
 // String _alamat;

  Mahasiswa(this._id, this._nama); //constrakter = fungsi yang di panggil pertama kali

  String get nama => _nama;

  String get id => _id;

  Mahasiswa.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nama = snapshot.value['nama'];
   // _alamat = snapshot.value['alamat'];
  }
}