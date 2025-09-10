
import 'package:crypto_coins_list/features/crypto_coint_list/widget/widgets.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});


  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  @override
  Widget build(BuildContext context) {
    final labelSmall = Theme.of(context).textTheme.labelSmall;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cryptso Scsum Application"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), // высота Divider
            child: const Divider(
            height: 1,
            thickness: 1,
            color: Colors.white24
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: 10,

        separatorBuilder: (context, index) => Divider(),

        itemBuilder: (context, i) { 
          const coinName = 'Bitcoin';

          return CryptoCoinTile(coinName: coinName, labelSmall: labelSmall);
        }
      )
    );
  }
}
