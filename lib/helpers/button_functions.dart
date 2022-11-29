import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonFunctions {
  static followButtonFunction(String uid, String symbol) async {
    List _watchlist = [];
    List noDupes = [];
    var docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    var docData = await docRef.get();
    if ((docData.data() as Map<String, dynamic>).containsKey('watchlist')) {
      _watchlist = docData['watchlist'];
    }
    if (_watchlist.contains(symbol)) {
      _watchlist.removeWhere((element) => element == symbol);
      await docRef.update({'watchlist': _watchlist});
    } else {
      noDupes = [..._watchlist, symbol].toSet().toList();
      await docRef.set({'watchlist': noDupes}, SetOptions(merge: true));
    }
  }
}
