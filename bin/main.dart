import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart'; // Importa el archivo user.dart

Future<List<User>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los usuarios');
  }
}

void filterAndDisplayUsers(List<User> users) {
  List<User> filteredUsers =
      users.where((user) => user.username.length > 6).toList();
  print('Usuarios con username de más de 6 caracteres:');
  for (var user in filteredUsers) {
    print(
        'ID: ${user.id}, Name: ${user.name}, Username: ${user.username}, Email: ${user.email}');
  }
}

void countUsersWithBizDomain(List<User> users) {
  int count = users.where((user) => user.email.endsWith('.biz')).length;
  print('Cantidad de usuarios con email en dominio ".biz": $count');
}

void main() async {
  try {
    List<User> users = await fetchUsers();

    filterAndDisplayUsers(users);

    countUsersWithBizDomain(users);
  } catch (e) {
    print('Ocurrió un error: $e');
  }
}
