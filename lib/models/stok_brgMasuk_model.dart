class AppUserModel {
  String id;
  String email;
  String displayName;
  String phoneNumber;
  String photoUrl;
  String appRole;
  String appFcmId;

  AppUserModel({
    this.id,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.appRole,
    this.appFcmId,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String id = data['id'];
    String email = data['email'];
    String displayName = data['displayName'];
    String phoneNumber = data['phoneNumber'];
    String photoUrl = data['photoUrl'];
    String appRole = data['appRole'];
    String appFcmId = data['appFcmId'];

    return AppUserModel(
      id: id,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      appRole: appRole,
      appFcmId: appFcmId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'appRole': appRole,
      'appFcmId': appFcmId,
    };
  }
}
