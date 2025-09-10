
import 'package:crypto_coins_list/features/crypto_coin/widgets/crypto_tile.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  CryptoCoin? coin;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as CryptoCoin?;
    assert(args != null, 'You must provide args');
    debugPrint('args: )$args');
    coin = args;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coin?.name ?? '...'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), // высота Divider
            child: const Divider(
            height: 1,
            thickness: 1,
            color: Colors.white24
          ),
        )
      ),
      body: (coin == null)
        ? const Center(child: CircularProgressIndicator())
        : CryptoDetailWidget(coin: coin!)
    );
  }
}