class User{
  User({required this.username, required this.email});
  final String email;
  final String username;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      username: json['username'],
      email: json['email'],
    );
  }
}