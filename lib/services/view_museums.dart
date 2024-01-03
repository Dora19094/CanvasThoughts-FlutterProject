import '../models/museum.dart';

Future<List<Museum>> getMuseums() async {
  await Future.delayed(Duration(seconds: 1), () {
    print('After 1 second data retrieved');
  });

  return [
    Museum(museumId: '1', name: 'Louvre'),
    Museum(museumId: '1',name: 'Modern Art Museum'),
    Museum(museumId: '1',name: 'Met Collection'),
    Museum(museumId: '1',name: 'Asian Collection'),
    Museum(museumId: '1',name: 'Paul Getty Center'),
    Museum(museumId: '1',name: 'Musee d Orsay'),
    Museum(museumId: '1',name: 'Uffizi Gallery'),
  ];
}
