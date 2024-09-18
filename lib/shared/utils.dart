import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> startWhatsapp(BuildContext context, String whatsappNumber, String text) async {
  const noWhatsapp = "Whatsapp no instalado";
  final whatsappURlAndroid = "whatsapp://send?phone=$whatsappNumber&text=";
  var whatsappUrlIOS =
      "https://wa.me/$whatsappNumber?text=${Uri.parse("hello")}";
  final Uri url =
      Uri.parse("https://wa.me/$whatsappNumber?text=${Uri.parse("hello")}");
  launchUrl(url).then((value) {
    if (!value) {
      /* GlobalSnackBar.show(context, noWhatsapp, backgroundColor: Colors.red); */
    }
  });
}