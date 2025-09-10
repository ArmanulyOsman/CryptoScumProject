import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoDetailWidget extends StatelessWidget {
  final CryptoCoin coin;

  const CryptoDetailWidget({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Картинка монеты
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              coin.imageUrl,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),

          // Название монеты
          Text(
            coin.name,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          // Биржа
          Text(
            'Market: ${coin.market}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),

          // Цена
          Text(
            '\$${coin.priceInUSD.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
          const SizedBox(height: 20),

          // High / Low
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPriceInfo('24h High', coin.high24hour, Colors.greenAccent),
              const SizedBox(width: 20),
              _buildPriceInfo('24h Low', coin.low24hour, Colors.redAccent),
            ],
          ),

          const SizedBox(height: 30),

          // Карточка с подробной информацией
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xFF1E2A38),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow('Название', coin.name),
                  _buildDetailRow('Биржа', coin.market),
                  _buildDetailRow('Цена', '\$${coin.priceInUSD.toStringAsFixed(2)}'),
                  _buildDetailRow('24h High', '\$${coin.high24hour.toStringAsFixed(2)}'),
                  _buildDetailRow('24h Low', '\$${coin.low24hour.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
