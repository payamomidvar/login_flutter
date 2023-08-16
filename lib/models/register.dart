class Register {
  final String email;
  final String password;
  final String repeatPassword;
  String? username;

  Register({
    required this.email,
    required this.password,
    required this.repeatPassword,
    this.username,
  });


  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'repeatPassword': repeatPassword,
        'username': username,
      };
}
