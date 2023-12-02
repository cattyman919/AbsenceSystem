import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'kelas_viewmodel.dart';

class KelasView extends StackedView<KelasViewModel> {
  const KelasView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    KelasViewModel viewModel,
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
  KelasViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      KelasViewModel();
}
