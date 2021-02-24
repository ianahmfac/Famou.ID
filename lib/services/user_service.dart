part of 'services.dart';

class UserService {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    await _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<User> getUser(String id) async {
    var snapshot = await _userCollection.document(id).get();

    return User(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        name: snapshot.data['name'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage']);
  }
}
