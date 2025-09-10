import 'package:crypto_coins_list/features/crypto_coin/crypto_coint.dart';
import 'package:crypto_coins_list/features/crypto_coint_list/crypto_list.dart';

final routes = {
  "/": (context) => const CryptoListScreen(),
  "/coin": (context) => const CryptoCoinScreen()
};
