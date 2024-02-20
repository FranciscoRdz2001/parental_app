// ignore_for_file: inference_failure_on_collection_literal

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/utils/app_constants_util.dart';
import 'package:parental_app/core/utils/app_utils.dart';
import 'package:parental_app/domain/models/error_response_model.dart';
import 'package:parental_app/domain/models/server_response_model.dart';

class CenterApi {
  Map<String, String> _headers({String? customToken}) {
    final token = customToken ?? GlobalData.instance.token ?? '';
    if (token.isEmpty) {
      return {
        'Content-Type': 'application/json',
      };
    } else {
      return {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
  }

  Future<ServerResponse<T>> get<T>({
    required String urlSpecific,
    required T Function(Map<String, dynamic>) fromJson,
    bool useNewErrorHandler = false,
  }) async {
    try {
      final uri = Uri.parse('${AppConstant.apiUrl}$urlSpecific');
      final response = await http.get(uri, headers: _headers());
      final dataDecode = response.body != ''
          ? AppUtils.instance.getDataDecode(response.bodyBytes)
          : [];
      log('GET in $uri');
      log(dataDecode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          isSuccess: true,
          message: AppConstant.successfulGet,
          result: fromJson(dataDecode),
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          statusCode: response.statusCode,
        );
      } else {
        return ServerResponse(
          isSuccess: false,
          message: useNewErrorHandler
              ? formatNewError(dataDecode)
              : formatError(dataDecode),
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      return ServerResponse(
        isSuccess: false,
        message: '${AppConstant.connectionError} $error',
        statusCode: -99,
      );
    }
  }

  Future<ServerResponse<T>> post<T>({
    required Map<String, dynamic> data,
    required String urlSpecific,
    required T Function(Map<String, dynamic>) fromJson,
    bool activateRefresh = true,
    bool useNewErrorHandler = false,
  }) async {
    try {
      final dataParse = data.isNotEmpty ? json.encode(data) : '';
      final uri = Uri.parse('${AppConstant.apiUrl}$urlSpecific');
      final response = await http.post(
        uri,
        headers: _headers(),
        body: dataParse,
      );

      log('Post in $uri');

      final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);
      log(dataDecode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulPost,
          result: fromJson(dataDecode),
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          result: null,
        );
      } else {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: useNewErrorHandler
              ? formatNewError(dataDecode)
              : formatError(dataDecode),
          defaultCode: useNewErrorHandler ? getDefaultCode(dataDecode) : '',
          result: null,
        );
      }
    } catch (error) {
      return ServerResponse(
        statusCode: 500,
        isSuccess: false,
        message: AppConstant.connectionError,
        result: null,
      );
    }
  }

  Future<ServerResponse> update<T>({
    required Map<String, dynamic> data,
    required String urlSpecific,
    required T Function(Map<String, dynamic>) fromJson,
    bool useNewErrorHandler = false,
    String? customToken,
  }) async {
    try {
      final dataParse = json.encode(data);
      final uri = Uri.parse('${AppConstant.apiUrl}$urlSpecific');
      final response = await http.patch(
        uri,
        headers: _headers(customToken: customToken),
        body: dataParse,
      );

      log('Patch in $uri');
      final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);
      log(dataDecode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulPost,
          result: fromJson(dataDecode),
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          result: null,
        );
      } else {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: useNewErrorHandler
              ? formatNewError(dataDecode)
              : formatError(dataDecode),
          defaultCode: useNewErrorHandler ? getDefaultCode(dataDecode) : '',
          result: null,
        );
      }
    } catch (error) {
      return ServerResponse(
        statusCode: 500,
        isSuccess: false,
        message: AppConstant.connectionError,
        result: null,
      );
    }
  }

  Future<ServerResponse> postMultipart({
    required Map<String, dynamic> data,
    required String urlSpecific,
    required String fileField,
    required String filePath,
    String? subFileName,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(urlSpecific));
      request.headers.addAll(_headers());
      request.files.add(await http.MultipartFile.fromPath(fileField, filePath));
      for (final e in data.entries) {
        if (e.value != null) {
          request.fields[e.key] = e.value.toString();
        }
      }

      if (subFileName != null) {
        // ignore: avoid_dynamic_calls
        final newData =
            // ignore: avoid_dynamic_calls
            data[subFileName].entries as List<MapEntry<String, dynamic>>;
        for (final e in newData) {
          if (e.value != null) {
            request.fields['$subFileName.${e.key}'] = e.value.toString();
          }
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulPatch,
          result: dataDecode,
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          result: [],
        );
      } else {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: formatError(dataDecode),
          result: [],
        );
      }
    } catch (e) {
      return ServerResponse(
        statusCode: 500,
        isSuccess: false,
        message: AppConstant.connectionError,
        result: [],
      );
    }
  }

  Future<ServerResponse> updateMultipart({
    required Map<String, dynamic> data,
    required String urlSpecific,
    required String fileField,
    required String filePath,
  }) async {
    try {
      final request = http.MultipartRequest('PATCH', Uri.parse(urlSpecific));
      request.headers.addAll(_headers());
      request.files.add(await http.MultipartFile.fromPath(fileField, filePath));
      for (final e in data.entries) {
        if (e.value != null) {
          request.fields[e.key] = e.value.toString();
        }
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulPatch,
          result: dataDecode,
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          result: [],
        );
      } else {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: formatError(dataDecode),
          result: [],
        );
      }
    } catch (e) {
      return ServerResponse(
        statusCode: 500,
        isSuccess: false,
        message: AppConstant.connectionError,
        result: [],
      );
    }
  }

  Future<ServerResponse> delete({
    required Map<String, dynamic> data,
    required String urlSpecific,
  }) async {
    try {
      final response =
          await http.delete(Uri.parse(urlSpecific), headers: _headers());
      if (response.statusCode >= 200 && response.statusCode <= 203) {
        final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);

        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulDelete,
          result: dataDecode,
        );
      } else if (response.statusCode == 204) {
        // No content
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: AppConstant.successfulDelete,
          result: AppConstant.noContent,
        );
      } else if (response.statusCode == 401) {
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: AppConstant.tokenExpiredMessage,
          result: [],
        );
      } else {
        final dataDecode = AppUtils.instance.getDataDecode(response.bodyBytes);
        return ServerResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          message: formatError(dataDecode),
          result: [],
        );
      }
    } catch (e) {
      return ServerResponse(
        statusCode: 500,
        isSuccess: false,
        message: AppConstant.connectionError,
        result: [],
      );
    }
  }

  String formatError(dynamic error) {
    if (error is List) {
      var errorMessage = '';
      for (final e in error) {
        if (e is String) {
          errorMessage += '$e\n';
        }
      }
      return errorMessage;
    } else if (error is Map) {
      if (error.containsKey('detail')) return error['detail']! as String;

      var errorMessage = '';

      for (final element in error.values) {
        if (element is List) {
          // ignore: strict_raw_type
          for (final msg in cast<List>(element)) {
            // ignore: use_string_buffers
            errorMessage += '$msg\n';
          }
        } else if (element is String) {
          errorMessage += '$element\n';
        }
      }
      return errorMessage;
    }
    return AppConstant.error;
  }

  String formatNewError(dynamic error) {
    final errorResponse = ErrorResponse.fromJson(error as Map<String, dynamic>);
    return errorResponse.detail;
  }

  String getDefaultCode(dynamic dataDecode) {
    final errorResponse =
        ErrorResponse.fromJson(dataDecode as Map<String, dynamic>);
    return errorResponse.defaultCode;
  }
}
