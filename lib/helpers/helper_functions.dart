class HelperFunctions {
  static getGainLoseStock(List globalQuoteDataList) {
    if (globalQuoteDataList.isEmpty) {
      return [];
    }
    var gainer = globalQuoteDataList[0];
    var loser = globalQuoteDataList[0];
    for (var item in globalQuoteDataList) {
      if (double.parse(
              item.globalQuote.changePercent.replaceAll(RegExp('%'), '')) >
          double.parse(
              gainer.globalQuote.changePercent.replaceAll(RegExp('%'), ''))) {
        gainer = item;
      }
      if (double.parse(
              item.globalQuote.changePercent.replaceAll(RegExp('%'), '')) <
          double.parse(
              loser.globalQuote.changePercent.replaceAll(RegExp('%'), ''))) {
        loser = item;
      }
    }
    return [gainer, loser];
  }
}
