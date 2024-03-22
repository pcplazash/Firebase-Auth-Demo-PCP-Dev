import '../../barrel.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          }
          return Scaffold(
            body: Consumer<AuthProviderDemo>(
              builder: (context, model, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: model.phoneController,
                        iconData: Icons.phone,
                        hintText: 'Enter phone number',
                      ),
                      ElevatedButton(
                        onPressed: () {
                          model.verifyPhoneNumber(context);
                        },
                        child: Text('send OTP'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
