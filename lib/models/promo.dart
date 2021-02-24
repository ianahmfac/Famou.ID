part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo(
      {@required this.title, @required this.subtitle, @required this.discount});

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromos = [
  Promo(
      title: "Special New Customer",
      subtitle: "Maximal only for 2 peoples",
      discount: 50),
  Promo(
      title: "Happy Holiday",
      subtitle: "Discount for every weekend",
      discount: 10),
  Promo(
      title: "Subscribe Developer",
      subtitle: "Follow developer's social media @ianahmfac",
      discount: 15)
];
