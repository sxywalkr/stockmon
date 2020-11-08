import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mergers/models/todo_model.dart';
import 'package:mergers/services/firestore_path.dart';
import 'package:mergers/services/firestore_service.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/models/personel_model.dart';
import 'package:mergers/models/pengalaman_model.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

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

  // ***** Penyedia
  //Method to create/update todoModel
  Future<void> setPenyedia(PenyediaModel penyedia) async =>
      await _firestoreService.setData(
        path: FirestorePath.penyedia(penyedia.id),
        data: penyedia.toMap(),
      );
  //Method to retrieve all todos item from the same user based on uid
  Stream<List<PenyediaModel>> penyediasStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.penyedias(),
        builder: (data, documentId) => PenyediaModel.fromMap(data, documentId),
      );

  // ***** Personel
  //Method to create/update todoModel
  Future<void> setPersonel(PersonelModel personel) async =>
      await _firestoreService.setData(
        path: FirestorePath.personel(personel.id),
        data: personel.toMap(),
      );
  //Method to retrieve all todos item from the same user based on uid
  Stream<List<PersonelModel>> personelsStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.personels(),
        builder: (data, documentId) => PersonelModel.fromMap(data, documentId),
      );

  // ***** Pengalaman
  //Method to create/update todoModel
  Future<void> setPengalaman(PengalamanModel pengalaman) async =>
      await _firestoreService.setData(
        path: FirestorePath.pengalaman(pengalaman.id),
        data: pengalaman.toMap(),
      );
  //Method to retrieve all todos item from the same user based on uid
  Stream<List<PengalamanModel>> pengalamansStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.pengalamans(),
        builder: (data, documentId) =>
            PengalamanModel.fromMap(data, documentId),
      );
}
