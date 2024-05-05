// class User {
//   String? firstName;
//   String? lastName;
//   String? username;
//   String? email;
//   String? token;
//   int? id;
//
//
//   User({
//     this.firstName,
//     this.lastName,
//     this.username,
//     this.email,
//     this.token,
//     this.id,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       username: json['username'],
//       email: json['email'],
//       token: json['token'],
//       id: json['id'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'email': email,
//       'first_name': firstName,
//       'last_name': lastName,
//       'token': token,
//       'id': id,
//     };
//   }
// }


class User {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password; // New password field
  String? token;
  int? id;


  User({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password, // Include password in constructor
    this.token,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      password: json['password'], // Assign password value from JSON
      token: json['token'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password, // Include password in JSON
      'first_name': firstName,
      'last_name': lastName,
      'token': token,
      'id': id,
    };
  }
}
