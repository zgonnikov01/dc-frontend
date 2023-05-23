import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ScreenRating extends StatefulWidget {
  const ScreenRating({super.key});

  @override
  State<ScreenRating> createState() => _ScreenRatingState();
}

class Secret {
  final String secret;

  const Secret({
    required this.secret,
  });

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(secret: json['secret']);
  }
}

Future<Secret> fetchSecret() async {
  final response =
      await http.get(Uri.parse('https://dc-api.ru/secret/'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzYXJvbWV0eiIsImV4cCI6MTAzMTQ5MTIyOTh9._B7zRQnYrJjt33sozzKhZ0wFjR05D7EayZFN3hpjXYA',
  });

  if (response.statusCode == 200) {
    return Secret.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load secret');
}

class _ScreenRatingState extends State<ScreenRating> {
  late Future<Secret> futureSecret;

  @override
  void initState() {
    super.initState();
    futureSecret = fetchSecret();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      //child: const Center(child: Text('Rating')),
      color: theme.background,
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<Secret>(
          future: futureSecret,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.secret);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
