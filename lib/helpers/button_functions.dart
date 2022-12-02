import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonFunctions {
  static followButtonFunction(String uid, String symbol, String name) async {
    print("++++++++++++++++BUTTON PRESSED+++++++++++++++++++++++++");
    List _watchlist = [];
    List noDupes = [];
    var docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    var docData = await docRef.get();
    List prevWatchlist = (docData.data() as Map<String, dynamic>)['watchlist'];
    if (prevWatchlist.isNotEmpty) {
      _watchlist = docData['watchlist'];
      print(_watchlist);
    }
    if (_watchlist.isNotEmpty &&
        _watchlist.firstWhere((element) => element['symbol'] == symbol,
                orElse: () => null) !=
            null) {
      print("ENTER IF NUMBER ONE");
      _watchlist.removeWhere((element) => element['symbol'] == symbol);
      await docRef.update({'watchlist': _watchlist});
    } else {
      print("ENTER IF NUMBER ELSE");
      noDupes = [
        ..._watchlist,
        {'symbol': symbol, 'name': name}
      ].toSet().toList();
      await docRef.set({'watchlist': noDupes}, SetOptions(merge: true));
    }
  }
}
