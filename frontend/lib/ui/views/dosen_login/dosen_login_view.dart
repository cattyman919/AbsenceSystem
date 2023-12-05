import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/dosen/dosen_viewmodel.dart';
import 'package:iot/ui/views/dosen_login/dosen_login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'dosen_login_viewmodel.dart';

@FormView(
    fields: [FormTextField(name: 'username'), FormTextField(name: 'password')])
class DosenLoginView extends StackedView<DosenLoginViewModel>
    with $DosenLoginView {
  const DosenLoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DosenLoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Moderately dark background
      appBar: AppBar(
        title: Text('Dosen Login'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Login Dosen",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              verticalSpaceMedium,
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.name,
              ),
              verticalSpaceSmall,
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              verticalSpaceMedium,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 40),
                ),
                onPressed: viewModel.loginDosen,
                child: !viewModel.isBusy
                    ? const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )
                    : const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )),
              ),
              verticalSpaceTiny,
              additionalNavigation(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget additionalNavigation(DosenLoginViewModel viewModel) {
    return Column(
      children: [
        actionLink('Register Dosen', viewModel.goToRegisterDosen),
        actionLink('Verify Student OTP', viewModel.goToOTP),
      ],
    );
  }

  Widget actionLink(String text, VoidCallback action) {
    return TextButton(
      onPressed: action,
      child: Text(
        text,
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  @override
  void onViewModelReady(DosenLoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.init();
  }

  @override
  DosenLoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DosenLoginViewModel();
}
