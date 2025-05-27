
import 'dart:isolate';

import 'package:waffarha/features/home/data/models/home_model.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared_widgets/debug_print_widget.dart';
import '../home_isolate.dart';

class HomeRepository {
  final DioFactory _dioFactory;
  HomeRepository(this._dioFactory);


  /// Get Home
  Future<ApiResult<List<HomeModel>>> getHome() async {
    // get json data from api
    final response = await _dioFactory.get(endPoint: EndPoints.home);
    if (response!.statusCode == 200) {
      // Create a ReceivePort to get the parsed result back from the Isolate
      final receivePort = ReceivePort();
      // Spawn a new isolate to parse the JSON data in a background thread
      await Isolate.spawn(
        homeModelIsolateEntry,  // Entry function for the isolate
        HomeParseMessage(receivePort.sendPort, response.data), // Message contains SendPort and raw JSON
      );
      // Wait for the parsed data from the isolate
      final List<HomeModel> model = await receivePort.first;
      return ApiResult.success(model);
    } else {
      debugPrintWidget(response.data['errors']);
      return ApiResult.failure(
          ServerFailure.fromResponse(response.statusCode, response.data['errors']));
    }
  }
}