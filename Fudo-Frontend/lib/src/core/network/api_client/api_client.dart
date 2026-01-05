import 'dart:convert';
import 'dart:io';

import 'package:fudo/src/core/network/api_service/api_constants.dart';
import 'package:fudo/src/core/network/response_method/response.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/constants/app_constants.dart';
import 'package:fudo/src/core/utils/constants/storage_keys.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/sharedpref/shared_pref.dart';
import 'package:fudo/src/core/utils/singleton/singleton.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Response<T>> post<T>(String endpoint, T Function(dynamic) fromJson, {Object? body, Map<String, String>? headers, bool isLogin = false}) async {
    var isNetworkAvailable = await isConnectionAvailable();
    if (!isNetworkAvailable) {
      return Response.failure("Please check your network connectivity.");
    }
    // try {
    hideKeyboard();

    String url;
    url = ApiConstants.baseUrl + endpoint;
//  return Response.success(fromJson(json.decode(AppConstants.apiresponse.toString())));
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    logV("Method=> post");
    logV("body=> $body");
    logV("url=> $url");
    logV("headers => $headers");
    logV("response status code=> ${response.statusCode}");
    logV("response log=> ${response.body}");

    // switch (json.decode(response.body)["statusCode"]) {
    switch (response.statusCode) {
      case 200:
        logV("True");
        // logV("True: ${json.decode(response.body)}");
        return Response.success(fromJson(json.decode(response.body)));
        // return Response.success(fromJson(json.decode(AppConstants.apiresponse.toString())));
      case 201:
        logV("True");
        logV("True: ${json.decode(response.body)}");
        return Response.success(fromJson(json.decode(response.body)));
      case 403:
        clearAndGotoLogin();
        return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
      case 419:
        return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
      case 404:
        if (!isLogin) {}
        return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
      case 500:
        return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong!!");

      case 429:
        return Response.failure("Something Went Wrong");
      default:
        return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
    }
    // } catch (e) {
    //   logV('API FAILED');
    //   return Response.failure(e.toString());
    // }
  }

  Future<Response<T>> put<T>(String endpoint, T Function(dynamic) fromJson, {String? endpointExtraPath, Object? body, Map<String, String>? headers, bool isLogin = false}) async {
    var isNetworkAvailable = await isConnectionAvailable();
    if (!isNetworkAvailable) {
      return Response.failure("Please check your network connectivity.");
    }

    try {
      hideKeyboard();
      String url;
      url = ApiConstants.baseUrl + endpoint;
      if (endpointExtraPath != null) {
        logV("endpointExtraPath: $endpointExtraPath");
        url += "/${Uri(path: endpointExtraPath)}";
        logV("endpointExtraPath: $url");
      }
      final response = await http.put(Uri.parse(url), headers: headers, body: body);
      logV("Method=> put");
      logV("url=> $url");
      logV("headers => $headers");
      logV("body=> $body");
      logV("response status code=> ${response.statusCode}");
      logV("response log=> ${response.body}");
      logV("response log=> $response");

      // switch (json.decode(response.body)["statusCode"]) {
      switch (response.statusCode) {
        case 200:
          logV("True");
          return Response.success(fromJson(json.decode(response.body)));
        case 201:
          logV("True");
          return Response.success(fromJson(json.decode(response.body)));
        case 403:
          clearAndGotoLogin();
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 419:
           return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 404:
          if (!isLogin) {}
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 500:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong!!");

        case 429:
          return Response.failure("Something Went Wrong");
        default:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
      }
    } catch (e) {
      logV('API FAILED');
      return Response.failure(e.toString());
    }
  }

  Future<Response<T>> delete<T>(String endpoint, T Function(dynamic) fromJson, {String? deleteId, Map<String, dynamic>? parameters, Object? body, Map<String, String>? headers, bool isLogin = false}) async {
    var isNetworkAvailable = await isConnectionAvailable();
    if (!isNetworkAvailable) {
      return Response.failure("Please check your network connectivity.");
    }

    try {
      hideKeyboard();
      String url;
      url = ApiConstants.baseUrl  + endpoint;
      if (deleteId != null) {
        logV("parameters: $parameters");
        url += "/${Uri(path: deleteId)}";
      }
      if (parameters != null) {
        logV("parameters: $parameters");
        url += "/${Uri(queryParameters: (parameters)).query}";
      }
      final response = await http.delete(Uri.parse(url), headers: headers, body: body);
      logV("Method=> delete");
      logV("url=> $url");
      logV("headers => $headers");
      logV("body=> $parameters");
      logV("response status code=> ${response.statusCode}");
      logV("response log=> ${response.body}");
      logV("response log=> $response");

      // switch (json.decode(response.body)["statusCode"]) {
      switch (response.statusCode) {
        case 200:
          logV("True");
          logV("True: ${json.decode(response.body)}");
          return Response.success(fromJson(json.decode(response.body)));
        case 201:
          logV("True");
          logV("True: ${json.decode(response.body)}");
          return Response.success(fromJson(json.decode(response.body)));
        case 403:
          clearAndGotoLogin();
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 419:
        clearAndGotoLogin();
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 404:
          if (!isLogin) {}
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong");
        case 500:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong!!");

        case 429:
          return Response.failure("Something Went Wrong");
        default:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
      }
    } catch (e) {
      logV('API FAILED');
      return Response.failure(e.toString());
    }
  }

  Future<Response<T>> get<T>(String endpoint, T Function(dynamic) fromJson, {Map<String, dynamic>? parameters, Map<String, String>? headers}) async {
    var isNetworkAvailable = await isConnectionAvailable();
    if (!isNetworkAvailable) {
      return Response.failure("Please check your network connectivity.");
    }
    try {
      hideKeyboard();
      String url;
      url = ApiConstants.baseUrl  + endpoint;
      if (parameters != null) {
        logV("parameters: $parameters");
        url += "?${Uri(queryParameters: (parameters)).query}";
      }
      final response = await http.get(Uri.parse(url), headers: headers);
      logV("Method=> get");
      logV("url=> $url");
      logV("headers => $headers");
      logV("response status code=> ${response.statusCode}");
      logV("response log=> ${response.body}");

      switch (response.statusCode) {
        case 200:
          return Response.success(fromJson(json.decode(response.body)));
        case 201:
          return Response.success(fromJson(json.decode(response.body)));

        case 403:
          clearAndGotoLogin();
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
        case 419:
             return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
        case 500:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
        default:
          return Response.failure(json.decode(response.body)["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
      }
    } catch (e) {
      return Response.failure(e.toString());
    }
  }

  ///upload single Image
  Future<Response<T>> multiPartRequest<T>(String method, String url, {Map<String, String>? headers, Map<String, dynamic>? fields, String? fileFieldName, List<File>? file, List<http.MultipartFile>? multipartFiles, T Function(dynamic)? fromJson}) async {
    hideKeyboard();
    var isNetworkAvailable = await isConnectionAvailable();
    if (!isNetworkAvailable) {
      return Response.failure("Please check your network connectivity.");
    }
  
    String endpoint = ApiConstants.baseUrl  + url;
    logV("Method=> multiPartRequest");
    logV("multiPartRequest : $method");
    logV("url=> $url");
    final request = http.MultipartRequest(method, Uri.parse(endpoint));
    logV("add header : ${headers != null}");
    logV("request : ${request}");
    if (fields != null) {
      fields.forEach((key, value) {
        try {
          request.fields[key] = value;
          // logV("+++++++++++++++");
          // logV("key: ${key}");
          // logV("value: ${value}");
          // logV("===============");
        } catch (e) {
          request.fields[key] = jsonEncode(value);
          // logV("Error");
          // logV("+++++++++++++++");
          // logV("key: ${key}");
          // logV("value: ${value}");
          // logV("===============");
        }
      });
    }
    logV("Body: ${request.fields}");
    if (headers != null) {
      logV("add header : $headers");
      headers.forEach((key, value) {
        request.headers[key] = value;
      });
    }

    if (multipartFiles != null) {
      request.files.addAll(multipartFiles);
    }

    if (file != null) {
      for (int i = 0; i < file.length; i++) {
        request.files.add(createMultipartFile("$fileFieldName", file[i]));
      }
      // request.files.add(createMultipartFile(fileFieldName!, file));
    }

    logV('createMultipartFile : ${request.files.length}');
    logV('createMultipartFile : ${request.files.length}');
    request.files.map((e) {
      logV("e.filename : ${e.filename}");
      logV("e.contentType : ${e.contentType.type}");
      logV("e.field : ${e.field}");
    }).toList();
    logV('request header : ${request.headers}');
    logV('header : $headers');

    var response = await request.send();
    logV('response : $response');
    var responseBody = await http.Response.fromStream(response).then((value) => value.body);

    // var responseBody = response.stream.bytesToString();
    logV('response.statusCode :${response.statusCode}');
    logV('response body :$responseBody');
    switch (response.statusCode) {
      case 200:
        return Response.success(fromJson!(json.decode(responseBody)));
      case 201:
        return Response.success(fromJson!(json.decode(responseBody)));
      case 403:
        clearAndGotoLogin();
        return Response.failure(json.decode(responseBody.toString())["message"] ?? "Something Went Wrong");
      case 419:
      return Response.failure(json.decode(responseBody.toString())["message"] ?? "Something Went Wrong");
      case 500:
        return Response.failure(json.decode(responseBody.toString())["message"] ?? "Something Went Wrong");
      case 429:
        return Response.failure("Something Went Wrong");
      default:
        return Response.failure(json.decode(responseBody.toString())["message"] ?? "Something Went Wrong", responseCode: response.statusCode);
    }
  }

  http.MultipartFile createMultipartFile(String field, File file) {
    List<int> fileBytes = file.readAsBytesSync();
    return http.MultipartFile.fromBytes(field, fileBytes, filename: file.path);
  }
}

Future<http.Response> getData(String baseUrl, Map<String, String> parameters) async {
  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: parameters);

  try {
    final response = await http.get(uri);
    return response;
  } catch (error) {
    throw Exception('Failed to load data: $error');
  }
}
