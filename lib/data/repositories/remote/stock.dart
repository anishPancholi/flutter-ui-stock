// Generated using mason. Do not modify by hand

import 'dart:async';
// import 'dart:convert';

// import 'package:dart_mappable/dart_mappable.dart';
// import 'package:digit_data_model/data_model.dart';
// import 'package:digit_ui_components/utils/app_logger.dart';
import 'package:dio/dio.dart';

import '../../../models/entities/stock.dart';
import '../../../utils/environment_config.dart';

// class StockRepository {
//   final Dio _client;

//   const StockRepository(this._client);

//   Future<dynamic> createStock(
//     String apiEndPoint,
//     Map body,
//   ) async {
//     try {
//       final response = await _client.post(apiEndPoint, data: body);

//       final appCon = StockModelMapper.fromJson(jsonDecode(response.data));
//       return appCon;
//     } on DioError catch (e) {
//       AppLogger.instance.error(
//         title: 'Stock Repository',
//         message: '$e',
//         stackTrace: e.stackTrace,
//       );
//       rethrow;
//     }
//   }
// }

// class StockRepository {
//   final Dio _client;

//   const StockRepository(this._client);

//   Future<List<StockModel>> createStock(  ) async {
//     const apiEnd = '/stock/v1/_create';
//     final baseUrl = envConfig.variable.baseUrl;
//     try {
//       final response = await _client.post(apiEndPoint, data: body);

//       final rawData = response.data;

//       final decoded = rawData is String ? jsonDecode(rawData) : rawData;

//       if (decoded is List) {
//         final stockList = (decoded as List<dynamic>)
//             .map((json) => StockModelMapper.fromJson(json))
//             .toList();

//         return stockList;
//       } else {
//         throw Exception('Unexpected response format: Expected List');
//       }
//     } on DioError catch (e) {
//       AppLogger.instance.error(
//         title: 'Stock Repository',
//         message: '$e',
//         stackTrace: e.stackTrace,
//       );
//       rethrow;
//     }
//   }

//   Future<List<StockModel>> searchStocks(
//     String apiEndPoint,
//     Map<String, dynamic> filters,
//   ) async {
//     try {
//       final response = await _client.post(apiEndPoint, data: filters);

//       final rawData = response.data;
//       final decoded = rawData is String ? jsonDecode(rawData) : rawData;

//       final List<dynamic> stockListRaw = decoded['stocks'];

//       final stockList =
//           stockListRaw.map((json) => StockModelMapper.fromJson(json)).toList();

//       return stockList;
//     } on DioError catch (e) {
//       AppLogger.instance.error(
//         title: 'Stock Search API',
//         message: '$e',
//         stackTrace: e.stackTrace,
//       );
//       rethrow;
//     }
//   }
// }

// class StockRepository {
//   final Dio dio;

//   StockRepository(this.dio);

//   Future<List<StockModel>> search(StockSearchModel query) async {
//     const url = 'stock/v1/_search?tenantId=mz&offset=0&limit=100';
//     final baseUrl = envConfig.variables.baseUrl;

//     if (url == null) {
//       throw Exception("Search action not found for Stock");
//     }

//     final response = await dio.post('$baseUrl$url', data: {
//       "Stock": {query.toMap()}
//     });

//     if (response.statusCode == 200) {
//       final data = response.data["Stock"] as List;
//       return data.map((json) => StockModelMapper.fromMap(json)).toList();
//     } else {
//       throw Exception('Failed to search Stock');
//     }
//   }

//   Future<StockModel> create(StockModel model) async {
//     const url = 'stock/v1/_create';

//     if (url == null) {
//       throw Exception("Create action not found for Stock");
//     }

//     final baseUrl = envConfig.variables.baseUrl;

//     final response = await dio.post('$baseUrl$url', data: {
//       "Stock": [model.toMap()]
//     });

//     if (response.statusCode == 200) {
//       final data = response.data["Stock"][0];
//       return StockModelMapper.fromMap(data);
//     } else {
//       throw Exception('Failed to create Stock');
//     }
//   }
// }

class StockRepository {
  final Dio dio;

  StockRepository(this.dio);

  Future<List<StockModel>> search(StockSearchModel query) async {
    final url =
        'stock/v1/_search?tenantId=${envConfig.variables.tenantId}&offset=0&limit=100';
    final baseUrl = envConfig.variables.baseUrl;

    // if (url == null) {
    //   throw Exception("Search action not found for Stock");
    // }

    final requestBody = {
      //"RequestInfo": {}, // Fill with real request info
      "Stock": query.toMap()
    };

    print('Request Body: $requestBody'); // Debugging line
    print('URL: $baseUrl$url'); // Debugging line

    final response = await dio.post('$baseUrl$url', data: requestBody);

    print('Response: ${response.data}'); // Debugging line
    print('Response Status Code: ${response.statusCode}'); // Debugging line

    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> stockResponse = data['Stock'] ?? [];
      final List<StockModel> stockList =
          stockResponse.map((e) => StockModelMapper.fromMap(e)).toList();
      return stockList;
    } else {
      throw Exception('Failed to search Households');
    }
  }

  // Future<StockModel> create(StockModel model) async {
  //   const url = 'stock/v1/bullk/_create';

  //   // if (url == null) {
  //   //   throw Exception("Create action not found for Stock");
  //   // }

  //   final baseUrl = envConfig.variables.baseUrl;

  //   final requestBody = {
  //     "RequestInfo": {}, // Fill with real request info
  //     "Stock": [model.toMap()] // for bulk "Stock": [model.toMap()]
  //   };

  //   final response = await dio.post('$baseUrl$url', data: requestBody);

  //   // if (response.statusCode == 200) {
  //   //   final data = response.data["Stock"];
  //   //      if (data == null || data is! Map<String, dynamic>) {
  //   //         throw Exception("Invalid 'Stock' response: ${response.data}");
  //   //       }
  //   //       return StockModelMapper.fromMap(data);
  //   //     } else {
  //   //       throw Exception('Failed to create Stock');
  //   //     }

  //   if (response.statusCode == 200) {
  //     // Explicitly cast response.data to Map<String, dynamic>
  //     final Map<String, dynamic> jsonResponse =
  //         response.data as Map<String, dynamic>;

  //     // Safely extract the "Stock" value and cast it to Map<String, dynamic>
  //     final stockData = jsonResponse["Stock"];
  //     if (stockData == null || stockData is! Map<String, dynamic>) {
  //       throw Exception("Invalid 'Stock' response: $jsonResponse");
  //     }

  //     // Now stockData is typed as Map<String, dynamic>, and we can call fromMap safely.
  //     return StockModelMapper.fromMap(stockData);
  //   } else {
  //     throw Exception('Failed to create Stock');
  //   }
  // }

  Future<StockModel> create(StockModel model) async {
    const url = 'stock/v1/bulk/_create'; // Fixed typo: 'bullk' → 'bulk'

    final baseUrl = envConfig.variables.baseUrl;

    final requestBody = {
      "RequestInfo": {
        // "apiId": "digit-ui",
        // "ver": "1.0",
        // "ts": DateTime.now().millisecondsSinceEpoch,
        // "action": "POST",
        // Other RequestInfo fields can be added as needed
      },
      "Stock": [model.toMap()]
    };

    final response = await dio.post('$baseUrl$url', data: requestBody);

    if (response.statusCode == 202) {
      // The API appears to return a ResponseInfo object without the created Stock data
      // So we'll just return the original model since it should be created with the same data
      // You may want to add a check for the "status" field in ResponseInfo

      final Map<String, dynamic> jsonResponse =
          response.data as Map<String, dynamic>;

      // Check if the response contains a successful status
      final responseInfo = jsonResponse['ResponseInfo'];
      if (responseInfo == null || responseInfo['status'] != 'SUCCESSFUL') {
        throw Exception(
            "Stock creation failed: ${jsonResponse['ResponseInfo']}");
      }

      // Since the API doesn't return the created stock object,
      // we'll just return the original model with the assumption it was created successfully
      return model;
    } else {
      throw Exception('Failed to create Stock: ${response.statusCode}');
    }
  }
}
