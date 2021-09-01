import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../viewmodel/auth_view_model.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

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
            key: _authVM.formKeyRegister,
            child: Column(
              children: [
                buildTextFormField(
                    hintText: 'Email',
                    controller: _authVM.inputEmailController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        _authVM.userModel.email =
                            _authVM.inputEmailController.text;
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
                        _authVM.userModel.password =
                            _authVM.inputPasswordController.text;
                        return null;
                      }
                      return 'Please enter valid password';
                    }),
                buildTextFormField(
                    hintText: 'Name',
                    controller: _authVM.inputNameController,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length >= 3) {
                        _authVM.userModel.name =
                            _authVM.inputNameController.text;
                        return null;
                      }
                      return 'Please enter valid name';
                    }),
                buildTextFormField(
                    hintText: 'Surname',
                    controller: _authVM.inputSurnameController,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length >= 2) {
                        _authVM.userModel.surname =
                            _authVM.inputSurnameController.text;
                        return null;
                      }
                      return 'Please enter valid surname';
                    }),
                TextButton(
                    onPressed: () async {
                      if (_authVM.formKeyRegister.currentState!.validate()) {
                        _authVM.firebaseAuthService
                            .createUserWithEmailAndPassword(_authVM.userModel);

                        await NavigationService.instance
                            .navigateToPage(path: NavigationConstants.LOGIN);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please control your informations.')),
                        );
                      }
                    },
                    child: Text('REGISTER')),
                InkWell(
                  onTap: () => NavigationService.instance
                      .navigateToPage(path: NavigationConstants.LOGIN),
                  child: Text(
                    'Login',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      {String? hintText,
      String? Function(String?)? validator,
      TextEditingController? controller,
      bool? secureText}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
        focusColor: Colors.blue,
      ),
      obscureText: secureText ?? false,
      validator: validator,
    );
  }
}
