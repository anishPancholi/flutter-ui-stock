import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:digit_ui_components/utils/app_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/entities/stock.dart';
import '../../../utils/environment_config.dart';
import '../../../data/repositories/remote/stock.dart'; // adjust import as needed
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stock_bloc.freezed.dart';

@freezed
class StockEvent with _$StockEvent {
  // Event to search for stocks using a StockSearchModel query.
  const factory StockEvent.search({
    required StockSearchModel query,
  }) = _SearchStock;

  // Event to create a stock entry using a StockModel.
  const factory StockEvent.create({
    required StockModel model,
  }) = _CreateStock;
}

@freezed
class StockState with _$StockState {
  // Initial state
  const factory StockState.initial() = _Initial;

  // Loading state
  const factory StockState.loading() = _Loading;

  // State when search is successful. Contains the list of stocks returned.
  const factory StockState.searchSuccess({
    required List<StockModel> stocks,
  }) = _SearchSuccess;

  // State when create is successful. Contains the created stock (here assumed to be the first item returned).
  const factory StockState.createSuccess({
    required StockModel stock,
  }) = _CreateSuccess;

  // Failure state with an error message.
  const factory StockState.failure({
    required String message,
  }) = _Failure;
}

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;

  StockBloc(this.repository) : super(const StockState.initial()) {
    on<_SearchStock>(_onSearchStock);
    on<_CreateStock>(_onCreateStock);
  }

  FutureOr<void> _onSearchStock(
      _SearchStock event, Emitter<StockState> emit) async {
    emit(const StockState.loading());
    try {
      // Call the repository's search method.
      final stocks = await repository.search(event.query);
      //print(stocks);
      emit(StockState.searchSuccess(stocks: stocks));
    } on DioException catch (e) {
      AppLogger.instance.error(
        title: 'StockBloc Search',
        message: '$e',
        stackTrace: e.stackTrace,
      );
      emit(StockState.failure(message: e.toString()));
      print("one dio error"); //debugging line
      print(e.toString()); //debugging line
      emit(StockState.failure(message: e.toString()));
    } catch (e) {
      print("try catch error"); //debugging line
      print(e.toString()); //debugging line
      emit(StockState.failure(message: e.toString()));
    }
  }

  FutureOr<void> _onCreateStock(
      _CreateStock event, Emitter<StockState> emit) async {
    emit(const StockState.loading());
    try {
      // Call the repository's create method.
      final stock = await repository.create(event.model);
      // Assuming create returns a single StockModel.
      emit(StockState.createSuccess(stock: stock));
    } on DioException catch (e) {
      AppLogger.instance.error(
        title: 'StockBloc Create',
        message: '$e',
        stackTrace: e.stackTrace,
      );
      print("one dio error"); //debugging line
      print(e.toString()); //debugging line
      emit(StockState.failure(message: e.toString()));
    } catch (e) {
      print("try catch error"); //debugging line
      print(e.toString()); //debugging line
      emit(StockState.failure(message: e.toString()));
    }
  }
}



// import 'dart:async';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:digit_ui_components/utils/app_logger.dart';

// import '../../../models/entities/stock.dart';
// import '../../../utils/environment_config.dart';
// import '../../../data/repositories/remote/stock_repository.dart';

// /// -------------------------
// /// Events
// /// -------------------------

// // Base class for events
// abstract class StockEvent {}

// // Event to trigger a stock search using a StockSearchModel query
// class SearchStockEvent extends StockEvent {
//   final StockSearchModel query;
  
//   SearchStockEvent({required this.query});
// }

// // Event to trigger creating a new stock using a StockModel
// class CreateStockEvent extends StockEvent {
//   final StockModel model;
  
//   CreateStockEvent({required this.model});
// }

// /// -------------------------
// /// States
// /// -------------------------

// // Base class for states
// abstract class StockState {}

// // Initial state
// class StockInitialState extends StockState {}

// // Loading state indicates that an API call is in progress
// class StockLoadingState extends StockState {}

// // State for successful search result. Carries a list of StockModel
// class StockSearchSuccessState extends StockState {
//   final List<StockModel> stocks;
  
//   StockSearchSuccessState({required this.stocks});
// }

// // State for successful stock creation. Carries the created StockModel (assumed as the first in the returned list)
// class StockCreateSuccessState extends StockState {
//   final StockModel stock;
  
//   StockCreateSuccessState({required this.stock});
// }

// // Failure state which carries an error message
// class StockFailureState extends StockState {
//   final String message;
  
//   StockFailureState({required this.message});
// }

// /// -------------------------
// /// Bloc
// /// -------------------------

// class StockBloc extends Bloc<StockEvent, StockState> {
//   final StockRepository repository;

//   StockBloc({required this.repository}) : super(StockInitialState()) {
//     on<SearchStockEvent>(_onSearchStock);
//     on<CreateStockEvent>(_onCreateStock);
//   }

//   FutureOr<void> _onSearchStock(
//       SearchStockEvent event, Emitter<StockState> emit) async {
//     emit(StockLoadingState());
//     try {
//       // Call repository search; expects a List<StockModel>
//       final stocks = await repository.search(event.query);
//       emit(StockSearchSuccessState(stocks: stocks));
//     } on DioError catch (e) {
//       AppLogger.instance.error(
//         title: 'StockBloc Search',
//         message: '$e',
//         stackTrace: e.stackTrace,
//       );
//       emit(StockFailureState(message: e.toString()));
//     } catch (e) {
//       emit(StockFailureState(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onCreateStock(
//       CreateStockEvent event, Emitter<StockState> emit) async {
//     emit(StockLoadingState());
//     try {
//       // Call repository create; here we assume it returns a List<StockModel>
//       final stocks = await repository.create(event.model);
//       emit(StockCreateSuccessState(stock: stocks[0]));
//     } on DioError catch (e) {
//       AppLogger.instance.error(
//         title: 'StockBloc Create',
//         message: '$e',
//         stackTrace: e.stackTrace,
//       );
//       emit(StockFailureState(message: e.toString()));
//     } catch (e) {
//       emit(StockFailureState(message: e.toString()));
//     }
//   }
// }
