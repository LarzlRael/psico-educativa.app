part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  static Future<http.Response?> sendRequest(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    Uri uri;
    Environment environment = Environment();
    if (url.startsWith('http://') || url.startsWith('https://')) {
      // Si ya tiene http o https, usar la URL tal cual
      uri = Uri.parse(url);
    } else {
      // Si no tiene http o https, concatenar con el servidor API
      uri = Uri.parse('${environment.serverApi}/$url');
    }

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
    inspect(res);
    return res;
  }

  static Future<http.Response?> sendAuthRequest(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    Environment environment = Environment();
    final token = await KeyValueStorageServiceImpl().getValue<String>(TOKEN);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${environment.serverApi}/$url');

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
    final token = await KeyValueStorageServiceImpl().getValue<String>(TOKEN);
    ;
    final Uri uri = Uri.parse('${Environment().remoteConfig}/$url');

    final mimeType = lookupMimeType(filePath)!.split('/');

    // Configuración de los headers
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type':
          'multipart/form-data', // Asegúrate de que el Content-Type sea correcto
    };

    final uploadFile = await http.MultipartFile.fromPath(
      'profileImageCourse',
      filePath,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    final uploadPostRequest = http.MultipartRequest(
      requestType == RequestType.post ? 'POST' : 'PUT',
      uri,
    );

    // Agregar headers a la solicitud
    uploadPostRequest.headers.addAll(headers);
    uploadPostRequest.files.add(uploadFile);

    // Agregar campos adicionales si existen
    if (body != null) {
      uploadPostRequest.fields.addAll(body);
    }

    // Enviar la solicitud
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
  /* Remove the try catch if you have issues to debbuing */

  // Realiza la solicitud HTTP usando el método y URL proporcionados
  final resp = await Request.sendRequest(method, url, body: body);

  // Verifica si la respuesta es válida
  if (resp != null && validateStatus(resp.statusCode)) {
    // Usa la función proporcionada para convertir la respuesta
    return functionToConvert(resp.body);
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
