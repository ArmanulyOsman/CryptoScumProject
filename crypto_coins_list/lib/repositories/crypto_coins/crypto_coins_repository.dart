
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'abstract_coins_repository.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {

  CryptoCoinsRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList(List<String> coinNames) async {
    debugPrint('Fetching coins: ${coinNames.join(",")}');
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=${coinNames.join(",")}&tsyms=USD');
    debugPrint(response.data.toString());


    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries
    .map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>?;
      final price = usdData!['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      final high24hour = usdData['HIGH24HOUR'];
      final low24hour = usdData['LOW24HOUR'];
      final market = usdData['MARKET'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com$imageUrl',
        high24hour: high24hour,
        low24hour: low24hour,
        market: market
      );
    }).toList();

    return cryptoCoinsList;
  }
}