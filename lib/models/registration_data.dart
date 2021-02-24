part of 'models.dart';

class RegistrationData {
  String name, email, password, selectedLanguage;
  List<String> selectedGenres;
  File profileImage;

  RegistrationData(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.selectedGenres = const [],
      this.selectedLanguage = "",
      this.profileImage});
}
