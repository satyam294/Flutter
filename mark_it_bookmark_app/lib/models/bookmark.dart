class Bookmark {
  final String id;
  final String title;
  final String url;

  Bookmark({
    required this.id,
    required this.title,
    required this.url,
  });

  factory Bookmark.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return Bookmark(
      id: id,
      title: data['title'] ?? '',
      url: data['url'] ?? '',
    );
  }
}