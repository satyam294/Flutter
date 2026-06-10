import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/bookmark_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  final BookmarkService bookmarkService =
      BookmarkService();

  final titleController =
      TextEditingController();

  final urlController =
      TextEditingController();

  Future<void> addBookmark() async {
    final title =
        titleController.text.trim();

    final url =
        urlController.text.trim();

    if (title.isEmpty || url.isEmpty) {
      return;
    }

    await bookmarkService.addBookmark(
      title: title,
      url: url,
    );

    titleController.clear();
    urlController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark It'),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  titleController,
              decoration:
                  const InputDecoration(
                labelText: 'Title',
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: urlController,
              decoration:
                  const InputDecoration(
                labelText: 'URL',
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addBookmark,
              child:
                  const Text('Add Bookmark'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<
                  QuerySnapshot>(
                stream: bookmarkService
                    .getBookmarks(),
                builder:
                    (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  final docs = snapshot
                      .data!.docs;

                  if (docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No bookmarks yet',
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount:
                        docs.length,
                    itemBuilder:
                        (context, index) {
                      final doc =
                          docs[index];

                      final data =
                          doc.data()
                              as Map<
                                  String,
                                  dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text(
                            data['title'],
                          ),
                          subtitle:
                              Text(
                            data['url'],
                          ),
                          trailing:
                              IconButton(
                            icon:
                                const Icon(
                              Icons
                                  .delete,
                            ),
                            onPressed:
                                () async {
                              await bookmarkService
                                  .deleteBookmark(
                                      doc.id);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}