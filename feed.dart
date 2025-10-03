import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initAd();
  }

  void _initAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-4827595854742658/3812751604",
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("Erro ao carregar banner: $error");
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ofertas')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                Card(child: ListTile(title: Text('Oferta 1'), subtitle: Text('10% cashback'))),
                Card(child: ListTile(title: Text('Oferta 2'), subtitle: Text('8% cashback'))),
              ],
            ),
          ),
          if (_isAdLoaded)
            Container(
              height: _bannerAd!.size.height.toDouble(),
              width: double.infinity,
              alignment: Alignment.center,
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
