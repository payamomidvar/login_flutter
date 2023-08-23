class ChangePassword {
  final String currentPassword;
  final String newPassword;
  final String repeatNewPassword;

  ChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.repeatNewPassword,
  });

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'repeatNewPassword': repeatNewPassword,
      };
}
