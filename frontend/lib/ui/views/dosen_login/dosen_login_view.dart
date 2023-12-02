import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Login Dosen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              keyboardType: TextInputType.name,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.number,
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: () {},
              child: Text('Login'),
            ),
            verticalSpaceTiny,
            TextButton(
                onPressed: viewModel.goToRegisterDosen,
                child: Text("Register Dosen")),
            verticalSpaceTiny,
            TextButton(
                onPressed: viewModel.goToOTP, child: Text("Verify Student OTP"))
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(DosenLoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  DosenLoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DosenLoginViewModel();
}
