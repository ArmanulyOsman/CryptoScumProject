
import 'package:crypto_coins_list/features/crypto_coint_list/widget/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});


  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelSmall = Theme.of(context).textTheme.labelSmall;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Scum Application"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), // высота Divider
            child: const Divider(
            height: 1,
            thickness: 1,
            color: Colors.white24
          ),
        ),
      ),
      body: (_cryptoCoinsList == null)
       ? const Center(child: const CircularProgressIndicator())
       : ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemCount: _cryptoCoinsList!.length,
        separatorBuilder: (context, index) => Divider(),

        itemBuilder: (context, i) {
          final coin = _cryptoCoinsList![i];

          return CryptoCoinTile(coin: coin, labelSmall: labelSmall);
        }
      )
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
}
