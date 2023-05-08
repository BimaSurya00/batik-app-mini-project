import 'package:flutter/material.dart';
import 'package:latihan_dio/provider/batik_provider.dart';
import 'package:provider/provider.dart';

import '../model/batik_model.dart';

class DetailBatikScreen extends StatelessWidget {
  const DetailBatikScreen({super.key, required this.batik});

  final BatikResponse batik;

  void addToBookmark(BuildContext context, BatikProvider provider) {
    provider.addToBookmark(batik);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil ditambahkan ke bookmark')));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BatikProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          batik.title!,
          style: const TextStyle(color: Colors.brown),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const SizedBox(height: 16),
          Image.network(batik.imageUrl!,
              width: 200, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(batik.title!,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Expanded(
              child: Text(batik.description!, textAlign: TextAlign.justify)),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: (() => addToBookmark(context, provider)),
        child: const Icon(Icons.bookmark),
      ),
    );
  }
}
