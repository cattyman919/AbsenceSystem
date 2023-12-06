import 'package:flutter/material.dart';
import 'package:iot/ui/common/app_colors.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_kelas_dialog_model.dart';

const double _graphicSize = 60;

class NewKelasDialog extends StackedView<NewKelasDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const NewKelasDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NewKelasDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Buat Kelas Baru',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            TextField(
              controller: viewModel.namaKelasController,
              decoration: const InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: OutlineInputBorder()),
              style: const TextStyle(color: Colors.white, fontSize: 15),
              keyboardType: TextInputType.name,
            ),
            verticalSpaceMedium,
            Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () => viewModel.createNewKelas(completer),
                    child: viewModel.isBusy
                        ? loadingSpinnerSmall()
                        : const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ))),
            verticalSpaceSmall,
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  NewKelasDialogModel viewModelBuilder(BuildContext context) =>
      NewKelasDialogModel();

  Widget loadingSpinnerSmall() {
    return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ));
  }
}
