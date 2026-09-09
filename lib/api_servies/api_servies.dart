import 'package:customer/api_servies/session.dart';
import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';


class ApiService {
  //static String apiUrl = "http://192.168.18.16:5000/api/";  //Faheem
  // static String apiUrl = "http://192.168.110.5:5000/api/";  // taj
   static String apiUrl = "http://158.220.92.206:5000/api/";  // taj live url
   // static String apiUrl = "https://www.nexustechnologys.com/api/";  // taj live url

   static String companyId = "3";

  /// --------------- - POST ----------------
   static Future<Response?> post(
       dynamic data,
       String url, {
         bool auth = false,
         bool multiPart = false,
         bool isProgressShow = false,
         bool noCloseLoading = false,
         bool sendCompanyId = false,
         String? fullUrl,
       }) async {
     if (!isProgressShow) BotToast.showLoading();

     try {
       // Add Company ID
       if (sendCompanyId) {
         if (data is FormData) {
           data.fields.add(
             MapEntry("company_id", companyId.toString()),
           );
         } else if (data is Map<String, dynamic>) {
           data["company_id"] = companyId;
         }
       }

       Response response = await Dio().post(
         fullUrl ?? apiUrl + url,
         data: data,
         options: Options(
           method: "POST",
           contentType:
           multiPart ? 'multipart/form-data' : "application/json",
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

       if (e.type == DioExceptionType.unknown) {
         BotToast.showText(text: 'No Internet connection');
       } else {
         return e.response;
       }
     }
     return null;
   }
  // static Future<Response?> post(dynamic data, String url,
  //     {bool auth = false,
  //       bool multiPart = false,
  //       bool isProgressShow = false,
  //       bool noCloseLoading = false,
  //       String? fullUrl}) async
  // {
  //   if (!isProgressShow) BotToast.showLoading();
  //
  //   try {
  //     Response response = await Dio().post(fullUrl ?? apiUrl + url,
  //         data: data,
  //         options: Options  (
  //           method: "POST",
  //           contentType: multiPart ? 'multipart/form-data' : "application/json",
  //           headers: {
  //             "Connection": "keep-alive",
  //             "accept": "application/json",
  //             if (auth) "Authorization": "Bearer ${TokenManager.token}"
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

  // ---------------- GET ----------------

///  // ---------------- get  ----------------
   static Future<Response?> get(
       String url, {
         bool auth = false,
         bool isProgressShow = false,
         bool noCloseLoading = false,
         bool sendCompanyId = false,
         Map<String, dynamic>? queryParameters,
         String? fullUrl,
       }) async {
     if (isProgressShow) BotToast.showLoading();

     try {
       Dio dio = Dio();
       dio.options.connectTimeout = const Duration(seconds: 10);
       dio.options.receiveTimeout = const Duration(seconds: 10);
       dio.options.sendTimeout = const Duration(seconds: 10);

       // Add Company ID
       queryParameters ??= {};

       if (sendCompanyId) {
         queryParameters["company_id"] = companyId;
       }

       Response response = await dio.get(
         fullUrl ?? apiUrl + url,
         queryParameters: queryParameters,
         options: Options(
           headers: {
             "Connection": "keep-alive",
             "accept": "application/json",
             if (auth) "Authorization": "Bearer ${TokenManager.token}",
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
  // static Future<Response?> get(String url,
  //     {bool auth = false,
  //       bool isProgressShow = false,
  //       bool noCloseLoading = false,
  //       Map<String, dynamic>? queryParameters,
  //       String? fullUrl}) async
  // {
  //
  //   if (isProgressShow) BotToast.showLoading();
  //
  //   try {
  //     Dio dio = Dio();
  //     dio.options.connectTimeout = const Duration(seconds: 10);
  //     dio.options.receiveTimeout = const Duration(seconds: 10);
  //     dio.options.sendTimeout = const Duration(seconds: 10);
  //
  //     Response response = await dio.get(
  //       fullUrl ?? apiUrl + url,
  //       queryParameters: queryParameters,
  //       options: Options(
  //         headers: {
  //           "Connection": "keep-alive",
  //           "accept": "application/json",
  //           if (auth) "Authorization": "Bearer ${TokenManager.token}"
  //         },
  //       ),
  //     );
  //
  //     if (!isProgressShow && !noCloseLoading) BotToast.closeAllLoading();
  //     return response;
  //
  //   } on DioException catch (e) {
  //     if (!isProgressShow) BotToast.closeAllLoading();
  //
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout ||
  //         e.type == DioExceptionType.sendTimeout) {
  //       BotToast.showText(text: 'Server not responding');
  //     } else if (e.type == DioExceptionType.unknown) {
  //       BotToast.showText(text: 'No Internet connection');
  //     } else {
  //       return e.response;
  //     }
  //   }
  //   return null;
  // }



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
