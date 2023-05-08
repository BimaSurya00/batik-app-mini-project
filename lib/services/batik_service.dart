import 'package:dio/dio.dart';
import 'package:latihan_dio/model/batik_model.dart';

class BatikService {
  final Dio _dio = Dio();

  Future<List<BatikResponse>> getBatik(String title) async {
    try {
      final response =
          await _dio.get('https://batik-bene.up.railway.app/api/batik/$title');
      final List<BatikResponse> listBatik = (response.data as List)
          .map((batik) => BatikResponse.fromJson(batik))
          .toList();
      return listBatik;
    } catch (e) {
      rethrow;
    }
  }
}
