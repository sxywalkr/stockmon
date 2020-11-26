class AppUserModel {
  String appUserUid;
  String appUserEmail;
  // String displayName;
  // String phoneNumber;
  // String photoUrl;
  String appRole;
  String appFcmId;

  AppUserModel({
    this.appUserUid,
    this.appUserEmail,
    // this.displayName,
    // this.phoneNumber,
    // this.photoUrl,
    this.appRole,
    this.appFcmId,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String appUserUid = data['appUserUid'];
    String appUserEmail = data['appUserEmail'];
    // String displayName = data['displayName'];
    // String phoneNumber = data['phoneNumber'];
    // String photoUrl = data['photoUrl'];
    String appRole = data['appRole'];
    String appFcmId = data['appFcmId'];

    return AppUserModel(
      appUserUid: appUserUid,
      appUserEmail: appUserEmail,
      // displayName: displayName,
      // phoneNumber: phoneNumber,
      // photoUrl: photoUrl,
      appRole: appRole,
      appFcmId: appFcmId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appUserUid': appUserUid,
      'appUserEmail': appUserEmail,
      // 'displayName': displayName,
      // 'phoneNumber': phoneNumber,
      // 'photoUrl': photoUrl,
      'appRole': appRole,
      'appFcmId': appFcmId,
    };
  }
}
