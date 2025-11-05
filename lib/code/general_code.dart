import "dart:convert";
import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;
import "package:package_info_plus/package_info_plus.dart";

/*
Comprueba si la app está actualizada
@return true si lo esta, false si no
*/
Future<bool> isAppUpdated() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  late List<String> webSegmentedVersion;
  late List<String> localSegmentedVersion;

  try {
    Uri url = Uri.parse(
      "https://irregly-web.web.app/backend/version.json",
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String webVersion = data["irregly"];
      String localVersion = packageInfo.version;
      webSegmentedVersion = webVersion.split(".");
      localSegmentedVersion = localVersion.split(".");
      for (int i = 0; i < 3; i++) {
        int webNumber = int.parse(webSegmentedVersion[i]);
        int localNumber = int.parse(localSegmentedVersion[i]);
        if (webNumber > localNumber) {
          return false;
        }
      }
    }
    return true;
  } catch (e) {
    debugPrint("Ha sucedido un error: ${e.toString()}");
    return true;
  }
}
