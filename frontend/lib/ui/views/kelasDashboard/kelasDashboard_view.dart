import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';

import 'kelasDashboard_viewmodel.dart';

class DosenView extends StackedView<DosenViewModel> {
  const DosenView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DosenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Colors.grey[850], // Moderately dark background
        appBar: AppBar(
          title: const Text('Kelas Dashboard'),
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.showDialogKelasBaru,
          backgroundColor: Colors.grey[800],
          child: const Icon(Icons.add),
        ),
        body: SmartRefresher(
          controller: viewModel.refreshController,
          onRefresh: viewModel.onRefresh,
          enablePullDown: true,
          child: Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25),
              child: viewModel.isBusy
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.only(top: 30),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 64,
                              height: 64,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                                strokeWidth: 3,
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Fetching data...",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ],
                      ),
                    )
                  : Column(children: [
                      const Text(
                        "Kelas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      verticalSpaceSmall,
                      Expanded(child: kelasListWidget(viewModel))
                    ])),
        ));
  }

  Widget kelasListWidget(DosenViewModel viewModel) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.kelas.length,
        itemBuilder: (context, index) {
          final kelas = viewModel.kelas[index];
          return Card(
            color: Colors.grey[800],
            elevation: 2.0, // Adds a subtle shadow.
            margin: const EdgeInsets.symmetric(
                vertical: 8.0), // Spacing around the card.
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0), // Padding inside the container.
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      kelas.nama!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () => viewModel.deleteKelas(kelas.id!),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        )),
                  ],
                ),
                onTap: () => viewModel.goToKelas(kelas.id!, kelas.nama!),
              ),
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
