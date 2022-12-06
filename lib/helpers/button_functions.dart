import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonFunctions {
  static followButtonFunction(String uid, String symbol, String name) async {
    List watchlist = [];
    List noDupes = [];
    var docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    var docData = await docRef.get();
    List prevWatchlist = (docData.data() as Map<String, dynamic>)['watchlist'];
    if (prevWatchlist.isNotEmpty) {
      watchlist = docData['watchlist'];
    }
    if (watchlist.isNotEmpty &&
        watchlist.firstWhere((element) => element['symbol'] == symbol,
                orElse: () => null) !=
            null) {
      watchlist.removeWhere((element) => element['symbol'] == symbol);
      await docRef.update({'watchlist': watchlist});
    } else {
      //convert to set to remove duplicate, then convert back to list
      noDupes = [
        ...watchlist,
        {'symbol': symbol, 'name': name}
      ].toSet().toList();
      await docRef.set({'watchlist': noDupes}, SetOptions(merge: true));
    }
  }
}
