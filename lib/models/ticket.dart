part of 'models.dart';

class Ticket extends Equatable {
  final MovieDetail movieDetail;
  final Cinema cinema;
  final DateTime time;
  final String bookingCode;
  final List<String> seats;
  final String name;
  final int priceInDay;
  final int totalPrice;

  Ticket(this.movieDetail, this.cinema, this.time, this.bookingCode, this.seats,
      this.name, this.totalPrice, this.priceInDay);

  Ticket copyWith(
          {MovieDetail movieDetail,
          Cinema cinema,
          DateTime time,
          String bookingCode,
          List<String> seats,
          String name,
          int totalPrice}) =>
      Ticket(
          movieDetail ?? this.movieDetail,
          cinema ?? this.cinema,
          time ?? this.time,
          bookingCode ?? this.bookingCode,
          seats ?? this.seats,
          name ?? this.name,
          totalPrice ?? this.totalPrice,
        priceInDay ?? this.priceInDay
      );

  String get seatsInString {
    String s = "";
    for (var seat in seats) {
      s += seat + ((seat != seats.last) ? ', ' : '');
    }
    return s;
  }

  @override
  List<Object> get props =>
      [movieDetail, cinema, time, bookingCode, seats, name, totalPrice, priceInDay];
}
