import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/widget/error_view.dart';
import '../../../core/widget/price_chart.dart';
import '../../../data/model/responce/coin_market.dart';
import '../../../data/model/responce/market_chart.dart';
import '../../../data/services/coin_gecko_service.dart';

class CoinDetailPage extends StatefulWidget {
  const CoinDetailPage({super.key, required this.coin});
  final CoinMarket coin;

  @override
  State<CoinDetailPage> createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  final CoinGeckoService _service = CoinGeckoService();
  late Future<MarketChart> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _service.fetchMarketChart(widget.coin.id, days: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.coin.image,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.currency_bitcoin, size: 20),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coin.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.coin.symbol.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColor.gray77,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: MyColor.secondaryColor,
        elevation: 0,
      ),
      body: FutureBuilder<MarketChart>(
        future: _chartData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return errorView(snapshot.error.toString(), () {
              setState(() {
                _chartData = _service.fetchMarketChart(widget.coin.id, days: 1);
              });
            });
          }

          final chartData = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PriceChart(
                  chartData: chartData,
                  coinSymbol: widget.coin.symbol,
                  currentPrice: widget.coin.currentPrice,
                ),
                const SizedBox(height: 16),
                _buildInfoCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoRow('Market Cap', widget.coin.formattedMarketCap),
          const SizedBox(height: 12),
          _buildInfoRow('Market Cap Rank', '#${widget.coin.marketCapRank}'),
          const SizedBox(height: 12),
          _buildInfoRow('24h High', '\$${widget.coin.high24h?.toStringAsFixed(2) ?? 'N/A'}'),
          const SizedBox(height: 12),
          _buildInfoRow('24h Low', '\$${widget.coin.low24h?.toStringAsFixed(2) ?? 'N/A'}'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: MyColor.gray77,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}