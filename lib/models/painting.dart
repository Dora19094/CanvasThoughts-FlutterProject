
class Painting {
  late String paintingId;
  late String museumId;
  final String title;
  final String artist;
  late String notes;
  final String imageUrl;
  late List<String> feelings;

  Painting({
    String? paintingId,
    String? museumId,
    required this.artist,
    required this.title,
    required this.imageUrl,
  })  : this.paintingId = paintingId ?? '',
        this.museumId = museumId ?? '',
        notes = '',
        feelings = [];
}