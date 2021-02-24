part of 'services.dart';

class TicketService {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieId': ticket.movieDetail.id ?? "",
      'userId': id ?? "",
      'cinema': ticket.cinema.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    var snapshot = await ticketCollection.getDocuments();
    var documents =
        snapshot.documents.where((element) => element.data['userId'] == userId);
    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieService.getDetailMovie(null,
          movieId: document.data['movieId']);
      tickets.add(Ticket(
        movieDetail,
        Cinema(document.data['cinema']),
        DateTime.fromMillisecondsSinceEpoch(document.data['time']),
        document.data['bookingCode'],
        document.data['seats'].toString().split(','),
        document.data['name'],
        document.data['totalPrice'],
        0
      ));
    }
    return tickets;
  }
}
