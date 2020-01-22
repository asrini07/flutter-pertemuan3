import 'package:firebase_database/firebase_database.dart';

class Mahasiswa {
  String _id;
  String _nama;
  String _umur;
  String _jenis_kelamin;
 // String _alamat;

  Mahasiswa(this._id, this._nama, this._umur, this._jenis_kelamin); //constrakter = fungsi yang di panggil pertama kali

  String get nama => _nama;
  String get umur => _umur;
  String get jenis_kelamin => _jenis_kelamin;

  String get id => _id;

  Mahasiswa.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nama = snapshot.value['nama'];
    _umur = snapshot.value['umur'];
    _jenis_kelamin = snapshot.value['jenis_kelamin'];
   // _alamat = snapshot.value['alamat'];
  }
}