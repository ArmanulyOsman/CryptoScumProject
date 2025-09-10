import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
    required this.labelSmall,
  });

  final CryptoCoin coin;
  final TextStyle? labelSmall;

  @override
  Widget build(BuildContext context) {
    final mediumTheme = Theme.of(context).textTheme.bodyMedium;

    return ListTile(
      leading: Image.network(coin.imageUrl),
    
      title: Text(
        coin.name, 
        style: mediumTheme
        ),
      subtitle: Text(
        '${coin.priceInUSD} \$',
        style: labelSmall
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios),
      onTap: () => {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coin.name)
      }
    );
  }
}