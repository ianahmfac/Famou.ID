part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTickets extends TicketEvent {
  final String userId;

  GetTickets(this.userId);

  @override
  List<Object> get props => [userId];
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userId;

  BuyTicket(this.ticket, this.userId);

  @override
  List<Object> get props => [ticket, userId];
}
