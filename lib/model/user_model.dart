// import 'dart:convert';

// class User {
//   final String id;
//   final String username;
//   final String email;
//   final String profileImage;

//   User(
//       {required this.id,
//       required this.username,
//       required this.email,
//       required this.profileImage});

//   User copyWith({
//     String? id,
//     String? username,
//     String? email,
//     dynamic profileImage,
//   }) =>
//       User(
//           id: id ?? this.id,
//           username: username ?? this.username,
//           email: email ?? this.email,
//           profileImage: profileImage ?? this.profileImage);

//   factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         username: json["username"],
//         email: json["email"],
//         profileImage: json['profileImage'],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "username": username,
//         "email": email,
//       };
// }


import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String profileImage;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
  });

  // Singleton instance
  static User? _instance;

  // Factory method to access the singleton instance
  static User get instance {
    // If the instance is null, create a new one
    _instance ??= User(
      id: "defaultId",
      username: "defaultUsername",
      email: "defaultEmail@example.com",
      profileImage: "defaultProfileImage.jpg",
    );

    return _instance!;
  }

  // Existing code...

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        profileImage: json['profileImage'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "profileImage": profileImage,
      };
}
