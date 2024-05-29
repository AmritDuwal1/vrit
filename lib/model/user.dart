

// class User {
//   String? firstName;
//   String? lastName;
//   String? username;
//   String? email;
//   String? password;
//   String? token;
//   int? id;
//   String? image; // New field for storing image URL
//
//   User({
//     this.firstName,
//     this.lastName,
//     this.username,
//     this.email,
//     this.password,
//     this.token,
//     this.id,
//     this.image, // Include imageUrl in constructor
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       username: json['username'],
//       email: json['email'],
//       password: json['password'],
//       token: json['token'],
//       id: json['id'],
//       image: json['image_url'], // Assign imageUrl value from JSON
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'email': email,
//       'password': password,
//       'first_name': firstName,
//       'last_name': lastName,
//       'token': token,
//       'id': id,
//       'image_url': image, // Include imageUrl in JSON
//     };
//   }
// }


// class User {
//   String? firstName;
//   String? lastName;
//   String? username;
//   String? email;
//   String? password;
//   String? token;
//   int? id;
//   String? image; // New field for storing image URL
//   String? address; // New field for storing address
//   String? phoneNumber; // New field for storing phone number
//   String? userType; // New field for storing user type
//   String? role;
//
//
//   User({
//     this.firstName,
//     this.lastName,
//     this.username,
//     this.email,
//     this.password,
//     this.token,
//     this.id,
//     this.image, // Include imageUrl in constructor
//     this.address, // Include address in constructor
//     this.phoneNumber, // Include phoneNumber in constructor
//     this.userType, // Include userType in constructor
//     this.role,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       username: json['username'],
//       email: json['email'],
//       password: json['password'],
//       token: json['token'],
//       id: json['id'],
//       image: json['image_url'], // Assign imageUrl value from JSON
//       address: json['address'], // Assign address value from JSON
//       phoneNumber: json['phone_number'], // Assign phoneNumber value from JSON
//       userType: json['usertype'], // Assign userType value from JSON
//         role: json["role"],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'email': email,
//       'password': password,
//       'first_name': firstName,
//       'last_name': lastName,
//       'token': token,
//       'id': id,
//       'image_url': image, // Include imageUrl in JSON
//       'address': address, // Include address in JSON
//       'phone_number': phoneNumber, // Include phoneNumber in JSON
//       'usertype': userType, // Include userType in JSON
//       "role": role,
//     };
//   }
// }



class User {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? token;
  int? id;
  String? image; // Field for storing image URL
  String? address; // Field for storing address
  String? phoneNumber; // Field for storing phone number
  String? userType; // Field for storing user type
  String? role;
  String? birthdate; // New field for storing birthdate

  User({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.token,
    this.id,
    this.image, // Include image in constructor
    this.address, // Include address in constructor
    this.phoneNumber, // Include phoneNumber in constructor
    this.userType, // Include userType in constructor
    this.role,
    this.birthdate, // Include birthdate in constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
      id: json['id'],
      image: json['image_url'], // Assign image value from JSON
      address: json['address'], // Assign address value from JSON
      phoneNumber: json['phone_number'], // Assign phoneNumber value from JSON
      userType: json['usertype'], // Assign userType value from JSON
      role: json['role'],
      birthdate: json['birthdate'], // Assign birthdate value from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'token': token,
      'id': id,
      'image_url': image, // Include image in JSON
      'address': address, // Include address in JSON
      'phone_number': phoneNumber, // Include phoneNumber in JSON
      'usertype': userType, // Include userType in JSON
      'role': role,
      'birthdate': birthdate, // Include birthdate in JSON
    };
  }
}
