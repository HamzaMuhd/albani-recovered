import 'dart:convert';
import 'dart:io';
import 'package:albani/data/models/page_meta.dart';
import 'package:albani/data/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';

class QuranController extends GetxController {
  final isReady = false.obs;
  final RxDouble downloadProgress = 0.0.obs;
  final RxString statusMessage = ''.obs;
  final bookmarks = <int>{}.obs;
  final currentPage = 1.obs;
  final RxInt extractedCount = 0.obs;
  final RxInt totalFiles = 0.obs;
  final RxBool showLinearProgress = false.obs;

  final box = GetStorage();
  List<PageMeta> pageMetaList = [];
  List<Surah> surahList = [];
  late Directory quranDir;

  final String zipUrl = 'https://media.munademy.com/quran.zip';

  @override
  void onInit() {
    super.onInit();
    final saved = box.read<List>('bookmarks')?.cast<int>() ?? [];
    bookmarks.addAll(saved);
    initialize();
  }

  Future<void> initialize() async {
    try {
      await _prepareStorage();
      await _loadMetadata();

      isReady.value = true;
    } catch (e) {
      statusMessage.value = "An error occurred.";
      Get.snackbar("Error", "Failed to load Quran. Check connection.");
      rethrow;
    }
  }

  Future<void> _prepareStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    quranDir = Directory('${dir.path}/quran_pages');

    final exists = await _checkImagesExist();
    if (!exists) {
      await _downloadAndExtractQuranZip();
    }
  }

  Future<bool> _checkImagesExist() async {
    if (!await quranDir.exists()) return false;
    final files = quranDir.listSync().whereType<File>();
    return files.isNotEmpty;
  }

  Future<void> _downloadAndExtractQuranZip() async {
    try {
      showLinearProgress.value = true;
      statusMessage.value = "Downloading Quran pages...";
      final dir = await getApplicationDocumentsDirectory();
      final zipFile = File('${dir.path}/quran.zip');

      final request = http.Request('GET', Uri.parse(zipUrl));
      final response = await request.send();
      if (response.statusCode != 200) {
        statusMessage.value = "Download failed";
        throw Exception('Download failed with status ${response.statusCode}');
      }

      final contentLength = response.contentLength ?? 0;
      final bytes = <int>[];
      int received = 0;

      await for (final chunk in response.stream) {
        bytes.addAll(chunk);
        received += chunk.length;
        downloadProgress.value = received / contentLength;
        statusMessage.value =
            "Downloading Quran pages (${(received / 1024 / 1024).toStringAsFixed(1)} MB / ${(contentLength / 1024 / 1024).toStringAsFixed(1)} MB)";
      }

      await zipFile.writeAsBytes(bytes);
      statusMessage.value = "Extracting Quran pages...";
      final archive = ZipDecoder().decodeBytes(bytes);

      totalFiles.value = archive.length;
      await quranDir.create(recursive: true);

      for (int i = 0; i < archive.length; i++) {
        final file = archive[i];
        if (file.isFile) {
          final outFile = File('${quranDir.path}/${file.name}');
          await outFile.writeAsBytes(file.content as List<int>);
        }
        extractedCount.value = i + 1;
        downloadProgress.value = (i + 1) / archive.length;
        statusMessage.value =
            "Extracting Quran pages (${extractedCount.value} / ${totalFiles.value})";
      }

      await zipFile.delete();
      showLinearProgress.value = false;
      statusMessage.value = "";
    } catch (e) {
      print('Zip download/extract failed: $e');
      statusMessage.value = "Failed to download or extract files.";
      rethrow;
    }
  }

  Future<void> _loadMetadata() async {
    try {
      final pageJson = await rootBundle.loadString('assets/pages_map.json');
      final pageData = jsonDecode(pageJson) as List;
      pageMetaList = pageData.map((e) => PageMeta.fromJson(e)).toList();
    } catch (e) {
      print('Failed to load pages_map.json: $e');
    }

    try {
      final surahJson = await rootBundle.loadString('assets/surahs_full.json');
      final surahData = jsonDecode(surahJson) as List;
      surahList = surahData.map((e) => Surah.fromJson(e)).toList();
    } catch (e) {
      print('Failed to load surahs_full.json: $e');
    }
  }

  File getPageFile(int page) {
    final padded = page.toString().padLeft(3, '0');
    return File('${quranDir.path}/page$padded.png');
  }

  List<int> getPagesBySurah(int surahNumber) {
    return pageMetaList
        .where((e) => e.surah == surahNumber)
        .map((e) => e.page)
        .toSet()
        .toList()
      ..sort();
  }

  Surah? getSurah(int number) {
    return surahList.firstWhereOrNull((e) => e.number == number);
  }

  List<int> getBookmarks() {
    final List raw = box.read('bookmarks') ?? [];
    return raw.cast<int>();
  }

  void toggleBookmark(int page) {
    final isAlreadyBookmarked = bookmarks.contains(page);

    if (isAlreadyBookmarked) {
      bookmarks.remove(page);
      Get.snackbar(
        "Bookmark Removed",
        "Page $page has been removed from bookmarks.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black87,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        duration: const Duration(seconds: 1),
      );
    } else {
      bookmarks.add(page);
      Get.snackbar(
        "Bookmarked",
        "Page $page has been added to bookmarks.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.black87,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        duration: const Duration(seconds: 1),
      );
    }

    box.write('bookmarks', bookmarks.toList());
  }

  bool isBookmarked(int page) {
    return getBookmarks().contains(page);
  }

  Surah? getSurahByPage(int page) {
    final candidates = surahList
        .where((s) => s.startPage != null && s.startPage! <= page)
        .toList();
    return candidates.isEmpty ? null : candidates.last;
  }
}
