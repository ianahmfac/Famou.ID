part of 'services.dart';

class TransactionService {
  static var transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> setTransaction(AppTransaction transaction) async {
    transactionCollection.document().setData({
      'userId': transaction.userId,
      'title': transaction.title,
      'subtitle': transaction.subtitle,
      'time': transaction.time.millisecondsSinceEpoch,
      'amount': transaction.amount,
      'picture': transaction.picture
    });
  }

  static Future<List<AppTransaction>> getTransaction(String userId) async {
    var snapshot = await transactionCollection.getDocuments();
    var documents =
        snapshot.documents.where((element) => element.data['userId'] == userId);

    return documents
        .map((e) => AppTransaction(
            userId: e.data['userId'],
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data['time']),
            amount: e.data['amount'],
            picture: e.data['picture']))
        .toList();
  }
}
