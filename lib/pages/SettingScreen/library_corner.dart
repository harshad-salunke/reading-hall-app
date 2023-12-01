import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../global/AppColors.dart';
import '../NotificationScreen/DefaultAppBar.dart';
import '../NotificationScreen/DefaultBackButton.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class LibraryCorner extends StatefulWidget {
  const LibraryCorner({Key? key}) : super(key: key);

  @override
  State<LibraryCorner> createState() => _LibraryCornerState();
}


class _LibraryCornerState extends State<LibraryCorner> {
  String path='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_bar_color,
      appBar:  DefaultAppBar(
        title: 'Library Corner',
        child: DefaultBackButton(),
      ),
      body:path==''?Center(child: CircularProgressIndicator(),)
          :PDFView(
        filePath: path,
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
        fitEachPage: true,
      ),
    );
  }
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
  @override
  void initState() {
    fromAsset('assets/images/book_list.pdf', 'book_list.pdf').then((f) {
      setState(() {
        path = f.path;
        print(path);
      });
    });
  }
}
