part of 'models.dart';

class Cinema extends Equatable {
  final String name;

  Cinema(this.name);
  @override
  List<Object> get props => [name];
}

List<Cinema> dummyCinema = [
  Cinema("Famou Studio Jakarta"),
  Cinema("Famou Studio Bandung"),
  Cinema("Famou Studio Makassar"),
  Cinema("Famou Studio Yogyakarta"),
  Cinema("Famou Studio Banjarmasin"),
  Cinema("Famou Studio Medan"),
  Cinema("Famou Studio Bali"),
  Cinema("Famou Studio Jayapura"),
];
