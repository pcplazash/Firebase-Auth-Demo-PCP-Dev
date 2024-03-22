

import 'package:firebase_auth_demo/utils/font_theme.dart';

import '../../barrel.dart';

class EmailPassPage extends StatelessWidget {
  const EmailPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Consumer<AuthProviderDemo>(
      builder: (context, model, _) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if(!snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: color.primaryContainer,
                  title: Text('Login Screen', style: titleFontStyle(context, color.primary).copyWith(fontWeight: FontWeight.w600,)),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          controller: model.emailController,
                          iconData: Icons.email,
                          hintText: 'Email',
                        ),
                        if (model.authType == AuthType.signUp)
                          CustomTextField(
                            controller: model.userNameController,
                            iconData: Icons.person,
                            hintText: 'Username',
                          ),
                        CustomTextField(
                          controller: model.passwordController,
                          iconData: Icons.password_rounded,
                          hintText: 'Password',
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () {
                              model.authenticate();
                            },
                            child: model.authType == AuthType.signUp
                                ? Text('Sign Up', style: bodyFontStyle(context, color.secondary),)
                                : Text('Sign in', style: bodyFontStyle(context, color.secondary),)),
                        ElevatedButton(
                          onPressed: () {
                            model.setAuthType();
                          },
                          child: model.authType == AuthType.signUp
                              ? Text('Already have an Account?', style: bodyFontStyle(context, color.secondary),)
                              : Text('Create an Account', style: bodyFontStyle(context, color.secondary),),
                        ),
                        if(model.authType==AuthType.signIn)
                        ElevatedButton(
                          onPressed: (){
                            model.resetPassword(context);
                          },
                          child: Text('Reset password', style: bodyFontStyle(context, color.secondary),),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }else{
            return HomePage();
          }
          }),
    );
  }
}
