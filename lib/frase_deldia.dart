import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> obtenerFraseDelDia() async {
  try {
    final response = await http.get(Uri.parse('https://frasedeldia.azurewebsites.net/api/phrase'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final frase = data['phrase'];
      final autor = data['author'];
      return '$frase - $autor';
    } else {
      return 'El conocimiento es grande pero sin internet vamos más lento';
    }
  } catch (e) {
    return 'El conocimiento es grande pero sin internet vamos más lento';
  }
}
