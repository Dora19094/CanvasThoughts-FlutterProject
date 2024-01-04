
class Painting {
  late String paintingId;
  late String museumId;
  final String title;
  final String artist;
  late String notes;
  final String imageUrl;
  late List<String> feelings;

  Painting({required this.paintingId,required this.artist, required this.museumId, required this.title, required this.imageUrl});


}