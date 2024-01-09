import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

class DummyData {

    CollectionReference museums = FirebaseFirestore.instance.collection('museums');
    CollectionReference paintings = FirebaseFirestore.instance.collection('paintings');
    Map<String,String> museumIds = new Map();

    Future<void> addMuseums(String name) {
      String museumId = museums.doc().id;
      museumIds[name] = museumId;
      return museums.doc(museumId)
          .set({
        'name': name,
        'museumId': museumId
      })
          .then((value) => print("Museum Added"))
          .catchError((error) => print("Failed to add museum: $error"));
    }

    Future<void> addPainting(String title,String artist,String museumId,String image,String notes,List<String> feelings) {
      String paintingId = paintings.doc().id;
      return paintings.doc(paintingId)
          .set({
        'title': title,
        'museumId': museumId,
        'imageUrl': image,
        'artist': artist,
        'notes' : notes,
        'feelings': feelings,
        'paintingId' : paintingId
      })
          .then((value) => print("Painting $title added"))
          .catchError((error) => print("Failed to add museum: $error"));
    }



    Future<void> insertDummyData() async {
      Random random = Random();
      await addMuseums('Louvre');
      await addMuseums('Met Museum');
      await addMuseums('Museum of Modern Art');
      await addMuseums("Musee d'Orsay");


      await addPainting('Mona Lisa', 'Leonardo da Vinci', museumIds['Louvre']!,
          'https://www.google.com/url?sa=i&url=http%3A%2F%2Ft1.gstatic.com%2Flicensed-image%3Fq%3Dtbn%3AANd9GcQ-FvbbAq5IaJUhtwxXEwY0D-jiZju02ejnNHx_bQWL_27GF3srhwJgqusMAqKh3QqU&psig=AOvVaw253JK6JfjY5E4XG-8Roc1M&ust=1704490461680000&source=images&cd=vfe&opi=89978449&ved=0CA0QjhxqFwoTCNjJhPfXxIMDFQAAAAAdAAAAABAD',
      "The Mona Lisa, with her enigmatic smile and timeless gaze, elicits a profound emotional response. Leonardo da Vinci's meticulous craftsmanship and the subtle interplay of light and shadow create an atmosphere of quiet contemplation. Her eyes seem to hold secrets, inviting viewers to unravel the mysteries concealed within that Mona Lisa smile. The painting's enduring allure goes beyond mere artistry; it serves as a poignant reminder of the complexities of human emotion and the beauty of artistic expression, leaving an indelible mark on the hearts and minds of those who encounter her.",
      ['Enigma','Contemplation','Allure']);
      await addPainting('Starry Night', 'Vincent van Gogh',museumIds['Museum of Modern Art']!, 
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1024px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
          "And then, there's 'Starry Night' by Van Gogh – a real cosmic trip! The night sky is like a swirling party, and the village below is just chilling. Van Gogh's brushstrokes give it this cool texture; you can almost feel the vibes. It's like he bottled up the night and put it on canvas. Art's wild, man. It's like a magic portal to feelings and stories you never knew you had.",
          ['Cosmic','Vibes','Magic']);
      await addPainting('The Persistence of Memory', 'Salvador Dalí',museumIds['Museum of Modern Art']!, 
          'https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg',
      "Dali's way of bending time and space is next-level. The soft, dreamy vibes mixed with the surrealism give this painting a quirky charm. It's like a quirky daydream frozen in time. Hanging out with Dali's melting clocks makes me wonder about the flexibility of reality. Art's cool like that – it messes with your head, but in the best way possible.",
      ['Surreal','Quirky','Flexibility']);
      await addPainting('The Olive Trees', 'Vincent van Gogh', museumIds['Museum of Modern Art']!,
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Van_Gogh_The_Olive_Trees..jpg/405px-Van_Gogh_The_Olive_Trees..jpg',
          "Spent some time soaking in the beauty of Vincent van Gogh's 'Olive Trees.' It's like stepping into a sun-drenched dream. The colors he splashed on the canvas make those olive trees dance with life. Van Gogh's brushstrokes are full of energy, capturing the essence of a breezy day in an olive grove."
          , ['Beauty','Dream','Life']);
      await addPainting('The Ship of Fools', 'Hieronymus Bosch', museumIds['Louvre']!,
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Jheronimus_Bosch_011.jpg/375px-Jheronimus_Bosch_011.jpg',
          "Today, I immersed myself in the whimsical chaos of Hieronymus Bosch's 'The Ship of Fools.' The painting, a carnival of grotesque characters on a drifting vessel, unfolds like a surreal narrative. Bosch's intricate details and satirical symbolism create a captivating commentary on human folly. As I navigate the bizarre scenes, I find myself drawn into a timeless reflection on the eccentricities of human nature, making this journey through Bosch's artistic seascape both perplexing and thought-provoking.",
          ['Whimsical','Captivating','Thought-Provoking']);
      await addPainting('Bridge over a Pond of Water Lilies', 'Claude Monet', museumIds['Met Museum']!,
          'https://www.claude-monet.com/images/paintings/water-lily-pond-with-japanese-bridge.jpg',
          "Today, I found solace in Claude Monet's 'Bridge over a Pond of Water Lilies.' The canvas unfolds like a poetic expression of nature's tranquility, with the delicate arch of the Japanese bridge mirroring its surroundings in the pond below. Monet's mastery of light and color transforms the scene into a dreamy atmosphere, where the water lilies dance in harmony with the ever-changing reflections. Standing on the artistic threshold of Monet's Giverny, I felt a serene connection to the beauty of the natural world, transcending the boundaries between reality and the ethereal strokes of this timeless masterpiece.",
          ['Solace','Tranquility','Timeless']);
      await addPainting('Portrait of the artist', 'Vincent van Gogh', museumIds["Musee d'Orsay"]!,
          'https://cdn.mediatheque.epmoo.fr/link/3c9igq/gii19u984kje4ww.jpg',
          "In the intimate company of Vincent Van Gogh's 'Portrait of the Artist,' I found myself captivated by the intensity of the artist's self-reflection. The penetrating gaze of the self-portrait reveals a tumultuous inner world, where each brushstroke seems to convey a spectrum of emotions. The bold colors and textured strokes reflect Van Gogh's unyielding passion for his craft, while the somber tones hint at the challenges he faced. As I delved into the depths of this self-revealing artwork, I sensed a poignant dialogue between the artist and his canvas, an unfiltered glimpse into the psyche of a creative mind. Van Gogh's self-portrait is not merely an exploration of facial features but a profound exploration of identity, resilience, and the unwavering commitment to artistic expression.",
          ['Intense', 'Captivating', 'Profound']);
      await addPainting('Romans of decadence', 'Thomas Couture', museumIds["Musee d'Orsay"]!,
          'https://cdn.mediatheque.epmoo.fr/link/3c9igq/glr189jpzx2cfvk.jpg',
          "Entering the realm of Thomas Couture's 'Romans of Decadence,' I found myself enveloped in the opulent tapestry of a bygone era. The painting, a vivid portrayal of ancient Roman excess, unfolds with a cascade of characters engaged in extravagant revelry. Couture's meticulous attention to detail captures the decadence of the scene, from sumptuous garments to lavish surroundings, offering a glimpse into the extravagant lifestyle of the Roman elite. As I explored the canvas, the artist's commitment to historical accuracy became evident, each figure contributing to the narrative of moral decline. 'Romans of Decadence' serves as a visual chronicle, prompting contemplation on the cyclical nature of societal values and the timeless allure of Couture's skill in bringing history to life on the canvas.",
          ['Opulent','Extravagant','Contemplative']);
      await addPainting('Coquelicots', 'Claude Monet', museumIds["Musee d'Orsay"]!,
          'https://cdn.mediatheque.epmoo.fr/link/3c9igq/hlz19u984fkmasg.jpg',
          "Wandering into Claude Monet's 'Coquelicots,' I found myself immersed in a sea of vibrant red poppies dancing beneath the radiant sun. The effervescent colors and gentle brushstrokes create a tapestry of nature in its most enchanting form. Monet's ability to capture the fleeting essence of a moment is evident as the poppies sway gracefully in the warm breeze, inviting contemplation on the transience of beauty. The play of light and shadow, the subtle variations of reds and greens, all harmonize to evoke a sense of tranquility and awe. 'Coquelicots' is a testament to Monet's mastery in portraying the ephemeral beauty of the natural world, leaving me with a profound appreciation for the delicate nuances of life's fleeting moments.",
          ['Vibrant','Enchanting','Transience']);
      

    }

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  DummyData dd = DummyData();
  await dd.insertDummyData();
  print('Dummy data insertion completed!');
  exit(0);
}