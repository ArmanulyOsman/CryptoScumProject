import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CryptoCurrenciesListApp());
}

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Scum',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        primarySwatch: Colors.yellow,
        dividerColor: Colors.white24,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),

        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20),
          labelSmall: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w700,
            fontSize: 14),
          ),
      ),
      routes: {
        "/": (context) => CryptoListScreen(),
        "/coin": (context) => CryptoCoinScreen()
      },
      // initialRoute: '/coins-list', // custom inital route
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});


  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  @override
  Widget build(BuildContext context) {
    final mediumTheme = Theme.of(context).textTheme.bodyMedium;
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
      body: ListView.separated(
        itemCount: 10,

        separatorBuilder: (context, index) => Divider(),

        itemBuilder: (context, i) { 
          const coinName = 'Bitcoin';

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
      )
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String args');
    // if (args == null) {
    //   log("You must provide args!");
    //   return;
    // }
    // if (args is! String) {
    //   log("You must provide String args");
    //   return;
    // }

    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      )
    );
  }
}