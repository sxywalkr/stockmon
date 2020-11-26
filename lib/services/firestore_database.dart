import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:stockmon/models/todo_model.dart';
import 'package:stockmon/services/firestore_path.dart';
import 'package:stockmon/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:stockmon/models/app_user_model.dart';
import 'package:stockmon/models/stok_brg_masuk_model.dart';
import 'package:stockmon/models/stok_brg_aktif_model.dart';
import 'package:stockmon/models/stok_brg_keluar_model.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
String generateUid() => Uuid().v4();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in Firestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.

 */
class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Method to create/update todoModel
  Future<void> setTodo(TodoModel todo) async => await _firestoreService.setData(
        path: FirestorePath.todo(uid, todo.id),
        data: todo.toMap(),
      );

  //Method to delete todoModel entry
  Future<void> deleteTodo(TodoModel todo) async {
    await _firestoreService.deleteData(path: FirestorePath.todo(uid, todo.id));
  }

  //Method to retrieve todoModel object based on the given todoId
  Stream<TodoModel> todoStream({@required String todoId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.todo(uid, todoId),
        builder: (data, documentId) => TodoModel.fromMap(data, documentId),
      );

  //Method to retrieve all todos item from the same user based on uid
  Stream<List<TodoModel>> todosStream() => _firestoreService.collectionStream(
        path: FirestorePath.todos(uid),
        builder: (data, documentId) => TodoModel.fromMap(data, documentId),
      );

  //Method to mark all todoModel to be complete
  Future<void> setAllTodoComplete() async {
    final batchUpdate = Firestore.instance.batch();

    final querySnapshot = await Firestore.instance
        .collection(FirestorePath.todos(uid))
        .getDocuments();

    for (DocumentSnapshot ds in querySnapshot.documents) {
      batchUpdate.updateData(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  Future<void> deleteAllTodoWithComplete() async {
    final batchDelete = Firestore.instance.batch();

    final querySnapshot = await Firestore.instance
        .collection(FirestorePath.todos(uid))
        .where('complete', isEqualTo: true)
        .getDocuments();

    for (DocumentSnapshot ds in querySnapshot.documents) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }

  // appUsers
  //Method to create/update appUserModel
  Future<void> setAppUser(AppUserModel appUser) async =>
      await _firestoreService.setData(
        path: FirestorePath.appUser(uid, appUser.id),
        data: appUser.toMap(),
      );

  //Method to delete appUserModel entry
  Future<void> deleteAppUser(AppUserModel appUser) async {
    await _firestoreService.deleteData(
        path: FirestorePath.appUser(uid, appUser.id));
  }

  //Method to retrieve AppUserModel object based on the given appUserId
  Stream<AppUserModel> appUserStream({@required String appUserId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.appUser(uid, appUserId),
        builder: (data, documentId) => AppUserModel.fromMap(data, documentId),
      );

  //Method to retrieve all appUsers item from the same user based on uid
  Stream<List<AppUserModel>> appUsersStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.appUsers(uid),
        builder: (data, documentId) => AppUserModel.fromMap(data, documentId),
      );

  // stokBarangMasuks
  //Method to create/update stokBarangMasukModel
  Future<void> setstokBarangMasuk(StokBarangMasukModel stokBarangMasuk) async =>
      await _firestoreService.setData(
        path: FirestorePath.stokBarangMasuk(stokBarangMasuk.id),
        data: stokBarangMasuk.toMap(),
      );

  //Method to delete StokBarangMasukModel entry
  Future<void> deletestokBarangMasuk(
      StokBarangMasukModel stokBarangMasuk) async {
    await _firestoreService.deleteData(
        path: FirestorePath.stokBarangMasuk(stokBarangMasuk.id));
  }

  //Method to retrieve StokBarangMasukModel object based on the given stokBarangMasukId
  Stream<StokBarangMasukModel> stokBarangMasukStream(
          {@required String stokBarangMasukId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.stokBarangMasuk(stokBarangMasukId),
        builder: (data, documentId) =>
            StokBarangMasukModel.fromMap(data, documentId),
      );

  //Method to retrieve all stokBarangMasuks item from the same user based on uid
  Stream<List<StokBarangMasukModel>> stokBarangMasuksStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.stokBarangMasuks(),
        builder: (data, documentId) =>
            StokBarangMasukModel.fromMap(data, documentId),
      );

  // stokBarangAktifs
  //Method to create/update all stokBarangAktifModel
  Future<void> setStokBarangAktif(StokBarangAktifModel stokBarangAktif) async =>
      await _firestoreService.setData(
        path: FirestorePath.stokBarangAktif(stokBarangAktif.uidBarang),
        data: stokBarangAktif.toMap(),
      );

  //Method to update partial stokBarangAktifModel
  Future<void> updateStokBarangAktif(
          StokBarangAktifModel stokBarangAktif) async =>
      await _firestoreService.updateData(
        path: FirestorePath.stokBarangAktif(stokBarangAktif.uidBarang),
        data: stokBarangAktif.toMap(),
      );

  //Method to delete StokBarangAktifModel entry
  Future<void> deletestokBarangAktif(
      StokBarangAktifModel stokBarangAktif) async {
    await _firestoreService.deleteData(
        path: FirestorePath.stokBarangAktif(stokBarangAktif.uidBarang));
  }

  //Method to retrieve StokBarangAktifModel object based on the given stokBarangAktifId
  Stream<StokBarangAktifModel> stokBarangAktifStream(
          {@required String stokBarangAktifId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.stokBarangAktif(stokBarangAktifId),
        builder: (data, documentId) =>
            StokBarangAktifModel.fromMap(data, documentId),
      );

  //Method to retrieve all stokBarangAktifs item from the same user based on uid
  Stream<List<StokBarangAktifModel>> stokBarangAktifsStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.stokBarangAktifs(),
        builder: (data, documentId) =>
            StokBarangAktifModel.fromMap(data, documentId),
      );

  //Method to retrieve todoModel object based on the given todoId
  Stream<List<StokBarangAktifModel>> stokBarangAktifModelByQ1Stream(
          {@required String query1}) =>
      _firestoreService.collectionStream(
        path: FirestorePath.stokBarangAktifs(),
        queryBuilder: query1 != null
            ? (query) => query.where('xxx1Nama', isEqualTo: query1)
            : null,
        builder: (data, documentId) =>
            StokBarangAktifModel.fromMap(data, documentId),
      );

  // stokBarangKeluars
  //Method to create/update all stokBarangKeluarModel
  Future<void> setStokBarangKeluar(
          StokBarangKeluarModel stokBarangKeluar) async =>
      await _firestoreService.setData(
        path: FirestorePath.stokBarangKeluar(stokBarangKeluar.uidBarang),
        data: stokBarangKeluar.toMap(),
      );

  //Method to update partial stokBarangKeluarModel
  Future<void> updateStokBarangKeluar(
          StokBarangKeluarModel stokBarangKeluar) async =>
      await _firestoreService.updateData(
        path: FirestorePath.stokBarangKeluar(stokBarangKeluar.uidBarang),
        data: stokBarangKeluar.toMap(),
      );

  //Method to delete StokBarangKeluarModel entry
  Future<void> deletestokBarangKeluar(
      StokBarangKeluarModel stokBarangKeluar) async {
    await _firestoreService.deleteData(
        path: FirestorePath.stokBarangKeluar(stokBarangKeluar.uidBarang));
  }

  //Method to retrieve StokBarangKeluarModel object based on the given stokBarangKeluarId
  Stream<StokBarangKeluarModel> stokBarangKeluarStream(
          {@required String stokBarangKeluarId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.stokBarangKeluar(stokBarangKeluarId),
        builder: (data, documentId) =>
            StokBarangKeluarModel.fromMap(data, documentId),
      );

  //Method to retrieve all stokBarangKeluars item from the same user based on uid
  Stream<List<StokBarangKeluarModel>> stokBarangKeluarsStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.stokBarangKeluars(),
        builder: (data, documentId) =>
            StokBarangKeluarModel.fromMap(data, documentId),
      );

  //Method to retrieve todoModel object based on the given todoId
  Stream<List<StokBarangKeluarModel>> stokBarangKeluarModelByQ1Stream(
          {@required String query1}) =>
      _firestoreService.collectionStream(
        path: FirestorePath.stokBarangKeluars(),
        queryBuilder: query1 != null
            ? (query) => query.where('xxx1Nama', isEqualTo: query1)
            : null,
        builder: (data, documentId) =>
            StokBarangKeluarModel.fromMap(data, documentId),
      );
}
