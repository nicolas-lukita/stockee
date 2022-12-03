class HelperFunctions {
  static getGainLoseStock(List globalQuoteDataList) {
    if (globalQuoteDataList.isEmpty) {
      return [];
    }
    var gainer = globalQuoteDataList[0];
    var loser = globalQuoteDataList[0];
    for (var item in globalQuoteDataList) {
      if (double.parse(item.globalQuote.change) >
          double.parse(gainer.globalQuote.change)) {
        gainer = item;
      }
      if (double.parse(item.globalQuote.change) <
          double.parse(loser.globalQuote.change)) {
        loser = item;
      }
    }
    return [gainer, loser];
  }
}
