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

  Future<void> showEditDialog(
  String bookmarkId,
  String currentTitle,
  String currentUrl,
  ) async {
    final titleController =
        TextEditingController(text: currentTitle);

    final urlController =
        TextEditingController(text: currentUrl);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Bookmark'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: 'URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title =
                    titleController.text.trim();

                final url =
                    urlController.text.trim();

                if (title.isEmpty || url.isEmpty) {
                  return;
                }

                await bookmarkService.updateBookmark(
                  bookmarkId: bookmarkId,
                  title: title,
                  url: url,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
              child: StreamBuilder<QuerySnapshot>(
                stream: bookmarkService.getBookmarks(),
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

                      final data = doc.data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text(data['title']),
                          subtitle: Text(data['url']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showEditDialog(
                                    doc.id,
                                    data['title'],
                                    data['url'],
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await bookmarkService.deleteBookmark(
                                    doc.id,
                                  );
                                },
                              ),
                            ],
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