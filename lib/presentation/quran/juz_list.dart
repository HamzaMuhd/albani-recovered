import 'package:albani/presentation/controllers/quran_controller.dart';
import 'package:albani/presentation/quran/page_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JuzList extends StatelessWidget {
  const JuzList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();

    final juzPages = <int, int>{};
    for (final page in controller.pageMetaList) {
      juzPages[page.juz] ??= page.page;
    }

    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final juz = index + 1;
        final startPage = juzPages[juz] ?? 1;

        return ListTile(
          leading: CircleAvatar(child: Text(juz.toString())),
          title: Text("Juz $juz", style: const TextStyle(fontSize: 18)),
          subtitle: Text("Starts on Page $startPage"),
          onTap: () => Get.to(() => PageViewer(startPage: startPage)),
        );
      },
    );
  }
}
