import 'package:flutter/material.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../viewmodel/auth_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _authVM = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FluChat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            key: _authVM.formKeyLogin,
            child: Column(
              children: [
                buildTextFormField(
                    hintText: 'Email',
                    controller: _authVM.inputEmailController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'Please enter valid email';
                    }),
                buildTextFormField(
                    hintText: 'Password',
                    secureText: true,
                    controller: _authVM.inputPasswordController,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length >= 6) {
                        return null;
                      }
                      return 'Please enter valid password';
                    }),
                TextButton(
                    onPressed: () async {
                      if (_authVM.formKeyLogin.currentState!.validate()) {
                        _authVM.firebaseAuthService.signInWithEmailAndPassword(
                            _authVM.inputEmailController.text,
                            _authVM.inputPasswordController.text);
                        await NavigationService.instance.navigateToPage(
                            path: NavigationConstants.USERS,
                            data: _authVM.firebaseAuthService.auth.currentUser);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please control your informations.')),
                        );
                      }
                    },
                    child: Text('LOGIN')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildTextFormField({
    String? hintText,
    String? Function(String?)? validator,
    TextEditingController? controller,
    bool? secureText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: secureText ?? false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: hintText, focusColor: Colors.blue),
      validator: validator,
    );
  }
}
