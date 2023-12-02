import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/dosen_register/dosen_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'dosen_register_viewmodel.dart';

@FormView(
    fields: [FormTextField(name: 'username'), FormTextField(name: 'password')])
class DosenRegisterView extends StackedView<DosenRegisterViewModel>
    with $DosenRegisterView {
  const DosenRegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DosenRegisterViewModel viewModel,
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
            const Text(
              "Register Dosen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: viewModel.registerDosen,
              child: !viewModel.isBusy
                  ? const Text(
                      'Register',
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
            TextButton(
                onPressed: viewModel.goToLoginDosen,
                child: Text("Login Dosen")),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(DosenRegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  DosenRegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DosenRegisterViewModel();
}
