part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  String uri = '${Environment.serverApi}/';
  static Future<http.Response?> sendRequest(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    Uri uri = Uri.parse('${Environment.serverApi}/$url');
    String requestBody = body != null ? jsonEncode(body) : '{}';
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri);
        break;
      case RequestType.post:
        res = await http.post(uri, body: requestBody, headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: requestBody, headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri);
    }
    return res;
  }

  static Future<http.Response?> sendAuthRequest(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final token = await KeyValueStorageServiceImpl().getValue<String>(TOKEN);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${Environment.serverApi}/$url');

    String requestBody = body != null ? jsonEncode(body) : '{}';
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri, headers: headers);
        break;
      case RequestType.post:
        res = await http.post(uri, body: requestBody, headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: requestBody, headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri, headers: headers);
    }
    return res;
  }

  static Future<http.Response> sendRequestWithFile(
    RequestType requestType,
    String url,
    String filePath, {
    Map<String, String>? body,
  }) async {
    late http.Response res;
    final token = await KeyValueStorageServiceImpl().getValue<String>('token');
    final Uri uri = Uri.parse('${Environment.serverApi}/$url');

    final mimeType = lookupMimeType(filePath)!.split('/');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final uploadFile = await http.MultipartFile.fromPath(
      'file',
      filePath,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      requestType == RequestType.post ? 'POST' : 'PUT',
      uri,
    );
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);
    if (body != null) uploadPostRequest.fields.addAll(body);
    final streamResponse = await uploadPostRequest.send();
    res = await http.Response.fromStream(streamResponse);

    return res;
  }
}

Future<T?> sendGenericRequest<T>(
  String url,
  T Function(String) functionToConvert, {
  RequestType method = RequestType.get,
  Map<String, dynamic>? body,
} // Opcional: agregar el método HTTP con un valor por defecto
    ) async {
  try {
    // Realiza la solicitud HTTP usando el método y URL proporcionados
    final resp = await Request.sendRequest(method, url, body: body);

    // Verifica si la respuesta es válida
    if (resp != null && validateStatus(resp.statusCode)) {
      // Usa la función proporcionada para convertir la respuesta
      return functionToConvert(resp.body);
    }
  } catch (e) {
    // Maneja cualquier error que ocurra durante la solicitud
    print("Error during request: $e");
  }

  // Retorna null si la solicitud falla o si no es válida
  return null;
}

Future<T?> sendGenericAuthRequest<T>(
  String url,
  T Function(String) functionToConvert, {
  RequestType method = RequestType.get,
  Map<String, dynamic>? body,
} // Opcional: agregar el método HTTP con un valor por defecto
    ) async {
  try {
    // Realiza la solicitud HTTP usando el método y URL proporcionados
    final resp = await Request.sendAuthRequest(method, url, body: body);

    // Verifica si la respuesta es válida
    if (resp != null && validateStatus(resp.statusCode)) {
      // Usa la función proporcionada para convertir la respuesta
      return functionToConvert(resp.body);
    }
  } catch (e) {
    // Maneja cualquier error que ocurra durante la solicitud
    print("Error during request: $e");
  }

  // Retorna null si la solicitud falla o si no es válida
  return null;
}
