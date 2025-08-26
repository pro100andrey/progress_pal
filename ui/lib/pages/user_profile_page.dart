import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(S.current.title)),
    body: const Stack(
      children: [Center(child: Text('UserProfilePage Coming soon...'))],
    ),
  );
}
