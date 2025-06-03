import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';

import '../log_utils.dart';
import 'exception/error_status.dart';

///Header management interceptor
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: todo
    // TODO: add header to each request {
    //  options.headers["Authorization"] = " $value"
    //  }
    options.headers["Accept"] = "application/json";
    // options.headers["authorization"] = "54|WEM0KwmG7Q1r9GPfMymksr5hlOAsmg3sbUqUS18O";
    super.onRequest(options, handler);
  }
}

///Log interceptor settings
class LoggingInterceptor extends Interceptor {
  DateTime? startTime;
  DateTime? endTime;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    Log.d("----------Request Start---------");
    Log.i(" path :${options.path}");

    ///print full path request
    if (options.queryParameters.isEmpty) {
      if (options.path.contains(options.baseUrl)) {
        Log.i("RequestUrl:${options.path}");
      } else {
        Log.i("RequestUrl:${options.baseUrl}${options.path}");
      }
    } else {
      ///If queryParameters is not empty, splice into a complete URl
      Log.i(
          "RequestUrl:${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}");
    }

    Log.w("RequestMethod:${options.method}");
    Log.w("RequestHeaders:${options.headers}");
    Log.w("RequestContentType:${options.contentType}");
    Log.w("RequestDataOptions:"
        "${options.data is FormData ? '${(options.data as FormData).fields}\n${(options.data as FormData).files}' : options.data.toString()}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();
    //Request duration
    int duration = endTime!.difference(startTime!).inMilliseconds;
    Log.i("----------End Request $duration millisecond---------");
    super.onResponse(response, handler);
  }
}

//parsing data
class AdapterInterceptor extends Interceptor {
  static const String mSG = "msg";
  static const String sLASH = "\"";
  static const String mESSAGE = "message";
  static const String eRROR = "validateError";

  static const String dEFAULT = "\"NOT_FOUND\"";
  static const String notFound = "Some Thing Wrong Happened";

  static const String fAILUREFORMAT = "{\"code\":%d,\"message\":\"%s\"}";
  static const String sUCCESSFORMAT =
      "{\"code\":0,\"data\":%s,\"message\":\"\"}";

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    Response mResponse = adapterData(response);
    return super.onResponse(mResponse, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      adapterData(err.response!);
    }
    return super.onError(err, handler);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? "" : response.data.toString();
    if (response.statusCode == ErrorStatus.sUCCESS) {
      if (content.isEmpty) {
        content = dEFAULT;
      }
      result = sprintf(sUCCESSFORMAT, [content]);
      response.statusCode = ErrorStatus.sUCCESS;
    } else if (response.statusCode == 201) {
      if (content.isEmpty) {
        content = dEFAULT;
      }
      result = sprintf(sUCCESSFORMAT, [content]);
      response.statusCode = ErrorStatus.sUCCESS;
    } else if (response.statusCode == ErrorStatus.notToken) {
      result = sprintf(fAILUREFORMAT, [response.statusCode, "Unauthorized"]);
      response.statusCode = ErrorStatus.sUCCESS;
    } else {
      result = sprintf(fAILUREFORMAT, [response.statusCode, notFound]);
      response.statusCode = ErrorStatus.sUCCESS;
    }
    if (response.statusCode == ErrorStatus.sUCCESS) {
      Log.d("ResponseCode:${response.statusCode}");
      Log.d("response:${jsonDecode(response.data)}");
    } else {
      //Logo.e("ResponseCode:${response.statusCode}");
      Log.d("response:${jsonDecode(response.data)}");
    }
    Log.json(result);
    response.data = result;
    return response;
  }
}
