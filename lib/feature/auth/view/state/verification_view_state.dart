import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../product/constants/navigation_constants.dart';
import '../../../../product/service/navigation/navigation_service.dart';
import '../../viewmodel/auth_view_model.dart';
import '../components/mobile_form_state_widget.dart';
import '../components/otp_state_widget.dart';
import '../components/user_form_state_widget.dart';

enum VerificationState { MOBILE_FORM_STATE, OTP_STATE, USER_FORM_STATE }

Future<Map<Permission, PermissionStatus>> get statuses async => await [
      Permission.camera,
      Permission.contacts,
    ].request();

extension VerificationViewStateExtension on VerificationState {
  Widget fetchViewByState(
    BuildContext context,
    AuthViewModel vm,
  ) {
    switch (this) {
      case VerificationState.MOBILE_FORM_STATE:
        return MobileFormStateWidget(
          controller: vm.inputPhoneNumberController,
          buttonText: 'VERIFY',
          onPressed: () async {
            vm.isLoadingVerification = true;
            await vm.verifyPhoneNumber(context);
          },
        );
      case VerificationState.OTP_STATE:
        return OTPStateWidget(
          controller: vm.inputVerificationIdController,
          buttonText: 'CONFIRM',
          duration: vm.timeOTPConfirmDuration,
          onPressedResendButton: (startTimer, btnState) {
            if (btnState == ButtonState.Idle) {
              vm.reSendOTPCode(context);
              startTimer(vm.timeOTPConfirmDuration);
            }
          },
          onPressed: () async {
            final _currentUser = await vm.verifyOTPCode();
            vm.user = _currentUser;
            vm.currentState = VerificationState.USER_FORM_STATE;
          },
        );
      case VerificationState.USER_FORM_STATE:
        return UserFormStateWidget(
            user: vm.user!,
            phoneNumber: vm.inputPhoneNumberController.text,
            controller: vm.inputNameSurnameController,
            image: vm.image,
            pickImageFromCamera: () async =>
                await vm.pickImage(ImageSource.camera),
            pickImageFromGallery: () async =>
                await vm.pickImage(ImageSource.gallery),
            onPressed: () async {
              vm.isLoadingUploadData = true;
              await vm.uploadProfilePhoto(vm.user!.uid);
              vm.userModel!.nameSurname = vm.inputNameSurnameController.text;
              vm.userModel!.userid = vm.user!.uid;
              vm.userModel!.phoneNumber = vm.inputPhoneNumberController.text;
              vm.userModel!.imageUrl =
                  await vm.getProfilePhotoUrl(vm.user!.uid);
              await vm.saveUserDataFireStore(vm.userModel);
              await statuses;

              await NavigationService.instance.navigateToPageClear(
                  path: NavigationConstants.TAB, data: vm.user);
              vm.isLoadingUploadData = false;
            });

      default:
        return MobileFormStateWidget(
          controller: vm.inputPhoneNumberController,
          buttonText: 'VERIFY',
          onPressed: () async {
            vm.isLoadingVerification = true;
            await vm.verifyPhoneNumber(context);
          },
        );
    }
  }
}
