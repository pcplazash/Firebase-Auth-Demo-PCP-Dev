import 'package:firebase_auth_demo/utils/font_theme.dart';

import '../../barrel.dart';
import 'email_login_page.dart';
import 'google_login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Auth provider',
                style: titleFontStyle(context, color.primary),
              ),
              SizedBox(
                height: 10,
              ),
              AuthButton(
                iconData: Icons.email,
                title: 'Email/password',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => EmailPassPage()));
                },
              ),
              AuthButton(
                iconData: Icons.phone,
                title: 'Phone',
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => PhonePage()));
                },
              ),
              AuthButton(
                iconData: FontAwesomeIcons.google,
                title: 'Google',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => GoogleSignPage()));
                },
              ),
              AuthButton(
                iconData: Icons.two_wheeler_sharp,
                title: 'twitter',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
