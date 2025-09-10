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
  static const List<String> _defaultCoins = ['BTC', 'ETH', 'XRP', 'USDT', 'BNB'];

  List<String> _coinsSymbols = List.from(_defaultCoins);
  List<CryptoCoin>? _cryptoCoinsList;

  final TextEditingController _coinController = TextEditingController();

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  void dispose() {
    _coinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelSmall = Theme.of(context).textTheme.labelSmall;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Scum Application"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.white24,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- Поле ввода и кнопка ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Поле ввода для нового символа монеты
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _coinController,
                    decoration: InputDecoration(
                      hintText: "Введите символ монеты (например, DOGE)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Кнопка "Добавить"
                ElevatedButton(
                  onPressed: _addNewCoin,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  ),
                  child: const Text("Добавить"),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // --- Список монет ---
          Expanded(
            child: (_cryptoCoinsList == null)
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: _cryptoCoinsList!.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, i) {
                      final coin = _cryptoCoinsList![i];
                      return CryptoCoinTile(coin: coin, labelSmall: labelSmall);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>()
        .getCoinsList(_coinsSymbols);
    setState(() {});
  }

  Future<void> _addNewCoin() async {
    final newCoin = _coinController.text.trim().toUpperCase();
    if (newCoin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите символ монеты")),
      );
      return;
    }

    if (_coinsSymbols.contains(newCoin)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Такая монета уже есть")),
      );
      return;
    }

    // Добавляем монету во временный список
    final tempList = List<String>.from(_coinsSymbols)..add(newCoin);

    // Загружаем данные из репозитория
    final updatedCoins = await GetIt.I<AbstractCoinsRepository>()
        .getCoinsList(tempList);

    if (updatedCoins.length == _cryptoCoinsList?.length) {
      // Если размер списка не изменился => монета не найдена
      _showCoinNotFoundDialog(newCoin);
      return;
    }

    // Если монета добавилась — обновляем список
    setState(() {
      _coinsSymbols.add(newCoin);
      _cryptoCoinsList = updatedCoins;
    });

    _coinController.clear();
  }

  void _showCoinNotFoundDialog(String coin) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[900], // Цвет фона
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Скругление углов
      ),
      title: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 28,
          ),
          const SizedBox(width: 8),
          const Text(
            "Ошибка",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Text(
        "Монета \"$coin\" не найдена.\nПроверьте символ и попробуйте снова.",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

}
