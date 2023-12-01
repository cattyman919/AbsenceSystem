import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'mahasiswa_viewmodel.dart';

class MahasiswaView extends StackedView<MahasiswaViewModel> {
  const MahasiswaView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MahasiswaViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  MahasiswaViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MahasiswaViewModel();
}
