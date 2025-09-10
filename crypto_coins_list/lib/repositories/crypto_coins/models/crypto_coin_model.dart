
class CryptoCoin{
  final String name;
  final double priceInUSD;
  final String imageUrl;
  final String market;
  final double high24hour;
  final double low24hour;

  const CryptoCoin({
    required this.name, 
    required this.priceInUSD,
    required this.imageUrl,
    required this.market,
    required this.high24hour,
    required this.low24hour
  });

  @override
  String toString() {
    return 'CryptoCoin{name: $name, priceInUSD: $priceInUSD, imageUrl: $imageUrl, market: $market, high24hour: $high24hour, low24hour: $low24hour}';
  }
}