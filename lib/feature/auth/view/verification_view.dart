import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../viewmodel/auth_view_model.dart';
import 'components/mobile_form_state_widget.dart';
import 'components/otp_state_widget.dart';

enum VerificationState { MOBILE_FORM_STATE, OTP_STATE }

class VerificationView extends StatelessWidget {
  VerificationView({Key? key}) : super(key: key);

  final _authVM = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _authVM.scaffoldKey,
      body: Observer(
        builder: (_) => _authVM.isLoadingVerification
            ? Center(child: CircularProgressIndicator.adaptive())
            : _authVM.currentState == VerificationState.MOBILE_FORM_STATE
                ? MobileFormStateWidget(
                    controller: _authVM.inputPhoneNumberController,
                    buttonText: 'VERIFY',
                    onPressed: () async {
                      _authVM.isLoadingVerification = true;
                      _authVM.verifyPhoneNumber(context);
                    },
                  )
                : OTPStateWidget(
                    controller: _authVM.inputVerificationIdController,
                    buttonText: 'CONFIRM',
                    onPressed: () async {
                      final _currentUser = await _authVM.verifyOTPCode();
                      await NavigationService.instance.navigateToPage(
                        path: NavigationConstants.REGISTER,
                        data: _currentUser,
                      );
                    },
                  ),
      ),
    );
  }
}
