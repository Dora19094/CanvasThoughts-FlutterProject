import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

Future<List<String>> search_image(String filePath) async{
  final inputImage = InputImage.fromFilePath(filePath);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  List<String> result = ['',''];
  int i = 0;
  for (TextBlock block in recognizedText.blocks) {
   for (TextLine line in block.lines)
    if(i < 2) {
      result[i] = line.text;
      i++;
    }
  }
  return result;
}