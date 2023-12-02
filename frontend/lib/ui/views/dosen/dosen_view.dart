import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dosen_viewmodel.dart';

class DosenView extends StackedView<DosenViewModel> {
  const DosenView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DosenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: viewModel.isBusy
                ? Container(
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 64,
                            height: 64,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            )),
                        Padding(
                            child: Text("Fetching data..."),
                            padding: EdgeInsets.only(top: 20)),
                      ],
                    ),
                  )
                : kelasListWidget(viewModel)));
  }

  Widget kelasListWidget(DosenViewModel viewModel) {
    return ListView.builder(
        itemCount: viewModel.kelas.length,
        itemBuilder: (context, index) {
          final kelas = viewModel.kelas[index];
          return Card(
            elevation: 2.0, // Adds a subtle shadow.
            margin: EdgeInsets.all(8.0), // Spacing around the card.

            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0), // Padding inside the container.

              child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Use the minimum space that the child widgets need.
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the text horizontally.
                  children: [
                    Text(
                      kelas.nama!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black, // Text color.
                        fontWeight: FontWeight.bold, // Font weight.
                        fontSize: 24.0, // Font size.
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  @override
  void onViewModelReady(DosenViewModel viewModel) {
    viewModel.init();
  }

  @override
  DosenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DosenViewModel();
}
