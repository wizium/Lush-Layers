import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  static Future<bool> downloadAndSaveImage(String url) async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        return false;
      }
      var response = await get(Uri.parse(url));
      if (response.statusCode != 200) {
        return false;
      }
      var tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/temp_image.png';
      var file = await File(tempPath).writeAsBytes(response.bodyBytes);
      final result = await ImageGallerySaver.saveFile(file.path);
      Fluttertoast.showToast(msg: "Downloaded Successfully");
      return result['isSuccess'] as bool;
    } catch (e) {
      Fluttertoast.showToast(msg: "Download Failed");
      return false;
    }
  }
}
