import 'package:flutter/material.dart';
import 'package:latihan_dio/provider/batik_provider.dart';
import 'package:latihan_dio/screen/bookmark_screen.dart';
import 'package:latihan_dio/screen/detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  late BatikProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<BatikProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchBatikList(' ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.home),
            const SizedBox(width: 10),
            const Text('Batik App'),
            const Spacer(),
            IconButton(
              onPressed: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BookmarkScreen(),
                  ),
                );
              }),
              icon: const Icon(Icons.bookmark),
            )
          ],
        ),
      ),
      body: Consumer<BatikProvider>(
        builder: (context, batikProvider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: 'Search Batik...',
                      border: const OutlineInputBorder(),
                      prefixIcon: IconButton(
                        onPressed: (() {
                          provider.fetchBatikList(_searchController.text.isEmpty
                              ? ' '
                              : _searchController.text);
                        }),
                        icon: const Icon(Icons.search),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.batikList.isEmpty
                        ? const Center(
                            child: Text('Data tidak ditemukan'),
                          )
                        : ListView.builder(
                            itemCount: provider.batikList.length,
                            itemBuilder: (context, index) {
                              final batik = provider.batikList[index];
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailBatikScreen(batik: batik),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(batik.title ?? ''),
                                    leading: Image.network(
                                      batik.imageUrl ?? '',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
