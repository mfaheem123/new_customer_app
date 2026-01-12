import 'package:customer/api_servies/session.dart';
import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';


class ApiService {
  static String apiUrl = "http://192.168.18.16:5000/api/";
 // static String apiUrl = "http://192.168.110.4:5000/api/";  // taj

  // ---------------- POST ----------------
  static Future<Response?> post(dynamic data, String url,
      {bool auth = false,
        bool multiPart = false,
        bool isProgressShow = false,
        bool noCloseLoading = false,
        String? fullUrl}) async {
    if (!isProgressShow) BotToast.showLoading();

    try {
      Response response = await Dio().post(fullUrl ?? apiUrl + url,
          data: data,
          options: Options(
            method: "POST",
            contentType: multiPart ? 'multipart/form-data' : "application/x-www-form-urlencoded",
            headers: {
              "Connection": "keep-alive",
              "accept": "application/json",
              if (auth) "Authorization": "Bearer ${TokenManager.token}"
            },
          ));

      if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
      return response;
    } on DioException catch (e) {
      if (!isProgressShow) BotToast.closeAllLoading();
      if (e.type == DioExceptionType.unknown) {
        BotToast.showText(text: 'No Internet connection');
      } else {
        return e.response;
      }
    }
    return null;
  }

  // ---------------- GET ----------------

///
  // static Future<Response?> get(String url,
  //     {bool auth = false,
  //       bool isProgressShow = false,
  //       bool noCloseLoading = false,
  //       Map<String, dynamic>? queryParameters,
  //       String? fullUrl}) async {
  //   if (!isProgressShow) BotToast.showLoading();
  //
  //   try {
  //     Response response = await Dio().get(fullUrl ?? apiUrl + url,
  //         queryParameters: queryParameters,
  //         options: Options(
  //           headers: {
  //             "Connection": "keep-alive",
  //             "accept": "application/json",
  //             if (auth) "Authorization": "Bearer ${TokenManager.token}"
  //
  //           },
  //         ));
  //
  //     if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
  //     return response;
  //   } on DioException catch (e) {
  //     if (!isProgressShow) BotToast.closeAllLoading();
  //     if (e.type == DioExceptionType.unknown) {
  //       BotToast.showText(text: 'No Internet connection');
  //     } else {
  //       return e.response;
  //     }
  //   }
  //   return null;
  // }

  static Future<Response?> get(String url,
      {bool auth = false,
        bool isProgressShow = false,
        bool noCloseLoading = false,
        Map<String, dynamic>? queryParameters,
        String? fullUrl}) async {

    if (isProgressShow) BotToast.showLoading();

    try {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      dio.options.sendTimeout = const Duration(seconds: 10);

      Response response = await dio.get(
        fullUrl ?? apiUrl + url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Connection": "keep-alive",
            "accept": "application/json",
            if (auth) "Authorization": "Bearer ${TokenManager.token}"
          },
        ),
      );

      if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
      return response;

    } on DioException catch (e) {
      if (!isProgressShow) BotToast.closeAllLoading();

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        BotToast.showText(text: 'Server not responding');
      } else if (e.type == DioExceptionType.unknown) {
        BotToast.showText(text: 'No Internet connection');
      } else {
        return e.response;
      }
    }
    return null;
  }



  ///
  // ---------------- PUT / UPDATE ----------------
  static Future<Response?> put(dynamic data, String url,
      {bool auth = false,
        bool multiPart = false,
        bool isProgressShow = false,
        bool noCloseLoading = false,
        String? fullUrl}) async {
    if (!isProgressShow) BotToast.showLoading();

    try {
      Response response = await Dio().put(fullUrl ?? apiUrl + url,
          data: data,
          options: Options(
            contentType: multiPart ? 'multipart/form-data' : "application/x-www-form-urlencoded",
            headers: {
              "Connection": "keep-alive",
              "accept": "application/json",
              if (auth) "Authorization": "Bearer ${TokenManager.token}"

            },
          ));

      if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
      return response;
    } on DioException catch (e) {
      if (!isProgressShow) BotToast.closeAllLoading();
      if (e.type == DioExceptionType.unknown) {
        BotToast.showText(text: 'No Internet connection');
      } else {
        return e.response;
      }
    }
    return null;
  }

  // ---------------- DELETE ----------------
  static Future<Response?> delete(String url,
      {bool auth = false,
        bool isProgressShow = false,
        bool noCloseLoading = false,
        Map<String, dynamic>? queryParameters,
        String? fullUrl}) async {
    if (!isProgressShow) BotToast.showLoading();

    try {
      Response response = await Dio().delete(fullUrl ?? apiUrl + url,
          queryParameters: queryParameters,
          options: Options(
            headers: {
              "Connection": "keep-alive",
              "accept": "application/json",
              if (auth) "Authorization": "Bearer ${TokenManager.token}"

            },
          ));

      if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
      return response;
    } on DioException catch (e) {
      if (!isProgressShow) BotToast.closeAllLoading();
      if (e.type == DioExceptionType.unknown) {
        BotToast.showText(text: 'No Internet connection');
      } else {
        return e.response;
      }
    }
    return null;
  }
}
