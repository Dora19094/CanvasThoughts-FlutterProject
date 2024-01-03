import '../models/painting.dart';

Future<List<Painting>> getPaintings(String museumId) async{
  await Future.delayed(Duration(seconds: 1), () {
    print('After 1 second data retrieved with museum id $museumId');
  });

  return [
    Painting(museumId: '1', title: 'Mona Lisa', imageUrl: 'assets/mona_lisa.jpg'),
    Painting(museumId: '1', title: 'Starry Night', imageUrl: 'assets/starry_night.jpg'),
    Painting(museumId: '2', title: 'The Persistence of Memory', imageUrl: 'assets/persistence_of_memory.jpg'),
  ];
}