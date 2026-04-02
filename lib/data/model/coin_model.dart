import '../../core/assets_manager.dart';

class  CoinModel {
  String icon;
  String label;
  String type;
  String percent;
  String price;
  bool isGood;
  String total;

  CoinModel._({
    required this.icon,
    required this.type,
    required this.percent,
    required this.price,
    required this.isGood,
    required this.label,
    required this.total
  });

  static final List<CoinModel> coinList = [
    CoinModel._(icon: AssetsManager.bCoin,
        type: 'BTC/BUSD',
        percent: '+0.81%',
        price: '40,059.83',
        isGood: true,
        label: "Bitcoin",
        total: "\$468,554.23"
    ),
    CoinModel._(icon: AssetsManager.blueCoin,
        type: 'SOL/BUSD',
        percent: '-0.81%',
        price: '2,059.83',
        isGood: false,
        label: "Chainlink",
        total: "\$468,554.23"),
    CoinModel._(icon: AssetsManager.cardanoCoin,
        type: 'SHIB',
        percent: '-0.81%',
        price: '2,059.83',
        isGood: false,
        label: "Cardano",
        total: "\$468,554.23"),
    CoinModel._(icon: AssetsManager.shibaCoin,
        type: 'SHIB',
        percent: '-0.81%',
        price: '2,059.83',
        isGood: false,
        label: "SHIBA INU",
        total: "\$468,554.23"),
    CoinModel._(icon: AssetsManager.purpleCoin,
        type: 'MFT',
        percent: '+0.81%',
        price: '40,059.83',
        isGood: true,
        label: "HIFI",
        total: "\$468,554.23"),
    CoinModel._(icon: AssetsManager.darkCoin,
        type: 'REN',
        percent: '-0.81%',
        price: '2,059.83',
        isGood: false,
        label: "REN",
        total: "\$468,554.23"),
  ];
}