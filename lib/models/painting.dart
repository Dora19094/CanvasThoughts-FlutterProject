
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
    required this.title,
    required this.artist,
    String? notes,
    required this.imageUrl,
    List<String>? feelings,
  })
      : this.paintingId = paintingId ?? '',
        this.museumId = museumId ?? '',
        this.notes = notes ?? '',
        this.feelings = feelings ?? [];
}

