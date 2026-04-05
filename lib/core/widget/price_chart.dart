import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../data/model/response/market_chart.dart';
import '../colors.dart';

class PriceChart extends StatefulWidget {
  final MarketChart chartData;
  final String coinSymbol;
  final double currentPrice;

  const PriceChart({
    super.key,
    required this.chartData,
    required this.coinSymbol,
    required this.currentPrice,
  });

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceHeader(),
          const SizedBox(height: 24),


          SizedBox(
            height: 250,
            child: _buildLineChart(),
          ),

          const SizedBox(height: 16),

          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildPriceHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${widget.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  widget.chartData.isPriceUp ? Icons.trending_up : Icons.trending_down,
                  color: widget.chartData.isPriceUp ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.chartData.priceChangePercentage.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: widget.chartData.isPriceUp ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'vs 24h',
                  style: TextStyle(
                    color: MyColor.gray77,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.coinSymbol.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildLineChart() {
    final spots = <FlSpot>[];
    final prices = widget.chartData.prices;

    if (prices.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final minPrice = widget.chartData.minPrice;
    final maxPrice = widget.chartData.maxPrice;
    final priceRange = maxPrice - minPrice;

    for (int i = 0; i < prices.length; i++) {
      final x = i.toDouble();
      final y = priceRange > 0 ? (prices[i].price - minPrice) / priceRange : 0.5;
      spots.add(FlSpot(x, y));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 0.25,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < prices.length) {
                  final time = prices[index].timestamp;
                  if (time.hour % 4 == 0) {
                    return Text(
                      '${time.hour}:00',
                      style: TextStyle(
                        color: MyColor.gray77,
                        fontSize: 10,
                      ),
                    );
                  }
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                final price = minPrice + (value * priceRange);
                return Text(
                  '\$${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: MyColor.gray77,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: widget.chartData.isPriceUp ? Colors.green : Colors.red,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: (widget.chartData.isPriceUp ? Colors.green : Colors.red)
                  .withOpacity(0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot spot) {
                final index = spot.x.toInt();
                if (index >= 0 && index < prices.length) {
                  final price = prices[index].price;
                  final time = prices[index].timestamp;
                  return LineTooltipItem(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}\n\$${price.toStringAsFixed(2)}',
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return null;
              }).toList();
            },
            getTooltipColor: (LineBarSpot spot) {
              return Colors.black.withOpacity(0.8);
            },
          ),
          handleBuiltInTouches: true,
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(
          'Open',
          '\$${widget.chartData.prices.first.price.toStringAsFixed(2)}',
        ),
        _buildStatItem(
          'Close',
          '\$${widget.chartData.prices.last.price.toStringAsFixed(2)}',
        ),
        _buildStatItem(
          'High',
          '\$${widget.chartData.maxPrice.toStringAsFixed(2)}',
        ),
        _buildStatItem(
          'Low',
          '\$${widget.chartData.minPrice.toStringAsFixed(2)}',
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: MyColor.gray77,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
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