
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coinName,
    required this.labelSmall,
  });

  final String coinName;
  final TextStyle? labelSmall;

  @override
  Widget build(BuildContext context) {
    final mediumTheme = Theme.of(context).textTheme.bodyMedium;

    return ListTile(
      leading: SvgPicture.asset(
        'assets/svg/bitcoin-logo.svg',
        height: 30,
        width: 30),
    
      title: Text(
        coinName, 
        style: mediumTheme
        ),
      subtitle: Text(
        "200.000\$",
        style: labelSmall
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios),
      onTap: () => {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coinName)
      }
    );
  }
}