

import '../../barrel.dart';

class GoogleSignPage extends StatelessWidget {
  const GoogleSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context, snapshot) {
        if(snapshot.hasData){
          return HomePage();
        }

        return Scaffold(
          body: Consumer<AuthProviderDemo>(
            builder: (context, model, _) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: AuthButton(
                    iconData: FontAwesomeIcons.google,
                    title: 'Google',
                    onTap: () {
                      model.signInWithGoogle();
                    },
                  ),
                ),
              );
            },
          ),
        );

      }
    );
  }
}
