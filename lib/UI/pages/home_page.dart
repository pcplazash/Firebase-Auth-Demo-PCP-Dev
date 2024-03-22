import 'package:firebase_auth_demo/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProviderDemo>(context, listen: false);
    if (mounted) authProvider.updateEmailVerificationState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderDemo>(
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                model.logOut();
              },
            )
          ],
        ),
        body: Center(
          child: model.emailVerified ?? false
              ? Text('email verified')
              : Text('Email is not verified'),
        ),
      ),
    );
  }
}
