// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rest API Call',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Icon(Icons.refresh),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          final gender = user['gender'];
          final names = user['name'];
          final imageUrl = user['picture'];

          return ListTile(
            // leading: CircleAvatar(child: Text('${index + 1}')),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network('${imageUrl['thumbnail']}'),
            ),
            title: Text('${names['title']} ${names['first']} ${names['last']}'),
            subtitle: Text('$gender  $email'),
            trailing: const Icon(Icons.call),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getApi,
        child: const Icon(Icons.add),
      ),
    );
  }

  void getApi() async {
    print('Refreshed API');
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
    print("API Call Completed");
  }
}
