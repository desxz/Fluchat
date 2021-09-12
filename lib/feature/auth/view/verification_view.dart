import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/viewmodel_constants.dart';
import 'state/verification_view_state.dart';

// ignore: constant_identifier_names

class VerificationView extends StatelessWidget {
  VerificationView({Key? key}) : super(key: key);

  final _authVM = ViewModelConstants.AUTH;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _authVM.scaffoldKey,
      body: Observer(
        builder: (_) =>
            _authVM.isLoadingVerification || _authVM.isLoadingUploadData
                ? _buildLoadingIndicator
                : _authVM.currentState.fetchViewByState(context, _authVM),
      ),
    );
  }

  Card get _buildLoadingIndicator => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator.adaptive()),
            SizedBox(height: 20),
            Text('Loading...')
          ],
        ),
      );
}
