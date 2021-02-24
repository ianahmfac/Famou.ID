part of 'models.dart';

class Credit extends Equatable {
  final String name;
  final String profilePath;
  final String character;

  Credit({this.name, this.profilePath, this.character});

  @override
  List<Object> get props => [name, profilePath, character];
}
