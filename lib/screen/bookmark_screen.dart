import 'package:flutter/material.dart';
import 'package:latihan_dio/provider/batik_provider.dart';
import 'package:provider/provider.dart';

import '../model/batik_model.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late BatikProvider provider;
  List<BatikResponse> bookmarkList = [];

  @override
  void initState() {
    super.initState();
    provider = Provider.of<BatikProvider>(context, listen: false);
    bookmarkList = provider.bookmarkList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.bookmark),
            SizedBox(width: 10),
            Text('Bookmark'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: bookmarkList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(bookmarkList[index].title!),
            leading: Image.network(bookmarkList[index].imageUrl!),
            trailing: IconButton(
              onPressed: (() {
                provider.removeFromBookmark(bookmarkList[index]);
                setState(() {
                  bookmarkList = provider.bookmarkList;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Berhasil dihapus dari bookmark')));
              }),
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
