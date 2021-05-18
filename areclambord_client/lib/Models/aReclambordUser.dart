class AReclamborUser {
  String email;
  String password;
  // double longitude;
  // double latitude;
  // DocumentReference userId; 
  // DocumentReference mallId;
  // DocumentReference reference;

  AReclamborUser({this.email, this.password});

  AReclamborUser.fromMap(Map<String, dynamic> map):
    email = map["email"],
    password = map["password"];

  
  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'password': password,
    };

  } 
  
  // FavouriteMall.fromSnapshot(DocumentSnapshot snapshot)
  //   : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson(){
    return {
      'email': email,
      'password': password
    };
  }
}