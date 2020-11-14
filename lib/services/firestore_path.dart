/*
This class defines all the possible read/write locations from the Firestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String todo(String uid, String todoId) => 'users/$uid/todos/$todoId';
  static String todos(String uid) => 'users/$uid/todos';

  static String penyedia(String penyediaId) => 'masterPenyedia/$penyediaId';
  static String penyedias() => 'masterPenyedia';

  static String personel(String personelId) => 'masterPersonel/$personelId';
  static String personels() => 'masterPersonel';

  static String pengalaman(String pengalamanId) =>
      'masterPengalaman/$pengalamanId';
  static String pengalamans() => 'masterPengalaman';

  static String peralatan(String peralatanId) => 'masterPeralatan/$peralatanId';
  static String peralatans() => 'masterPeralatan';

  static String mergrPenyedia(String mergrPenyediaId) =>
      'mergrPenyedia/$mergrPenyediaId';
  static String mergrPenyedias() => 'mergrPenyedia';

  static String mergrPeralatanDetail(String mergrPeralatanDetailId) =>
      'mergrPeralatanDetail/$mergrPeralatanDetailId';
  static String mergrPeralatanDetails() => 'mergrPeralatanDetail';
}
