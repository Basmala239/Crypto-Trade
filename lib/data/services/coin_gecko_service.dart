import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/responce/coin_market.dart';
import '../model/responce/market_chart.dart';
import '../model/responce/trending_coin.dart';

class CoinGeckoService {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  // Fetch top 20 coins by market cap
  Future<List<CoinMarket>> fetchTopCoins({int perPage = 20, int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$perPage&page=$page&sparkline=false'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CoinMarket.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top coins: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching top coins: $e');
    }
  }

  // Fetch trending coins
  Future<List<TrendingCoin>> fetchTrendingCoins() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search/trending'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> coins = data['coins'] ?? [];
        return coins.map((json) => TrendingCoin.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trending coins: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching trending coins: $e');
    }
  }

  // Fetch all market coins (with pagination)
  Future<List<CoinMarket>> fetchMarketCoins({int perPage = 50, int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/markets?vs_currency=usd&per_page=$perPage&page=$page'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CoinMarket.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load market coins: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching market coins: $e');
    }
  }

  Future<MarketChart> fetchMarketChart(String coinId, {int days = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/$coinId/market_chart?vs_currency=usd&days=$days'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MarketChart.fromJson(data);
      } else {
        throw Exception('Failed to load market chart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching market chart: $e');
    }
  }

  Future<MarketChart> fetchMarketChartWithRange(
      String coinId, {
        required String from,
        required String to,
      }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/$coinId/market_chart/range?vs_currency=usd&from=$from&to=$to'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MarketChart.fromJson(data);
      } else {
        throw Exception('Failed to load market chart range: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching market chart range: $e');
    }
  }
}