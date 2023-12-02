// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NamaValueKey = 'nama';
const String NpmValueKey = 'npm';

final Map<String, TextEditingController>
    _MahasiswaRegisterViewTextEditingControllers = {};

final Map<String, FocusNode> _MahasiswaRegisterViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _MahasiswaRegisterViewTextValidations = {
  NamaValueKey: null,
  NpmValueKey: null,
};

mixin $MahasiswaRegisterView {
  TextEditingController get namaController =>
      _getFormTextEditingController(NamaValueKey);
  TextEditingController get npmController =>
      _getFormTextEditingController(NpmValueKey);

  FocusNode get namaFocusNode => _getFormFocusNode(NamaValueKey);
  FocusNode get npmFocusNode => _getFormFocusNode(NpmValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_MahasiswaRegisterViewTextEditingControllers.containsKey(key)) {
      return _MahasiswaRegisterViewTextEditingControllers[key]!;
    }

    _MahasiswaRegisterViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _MahasiswaRegisterViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MahasiswaRegisterViewFocusNodes.containsKey(key)) {
      return _MahasiswaRegisterViewFocusNodes[key]!;
    }
    _MahasiswaRegisterViewFocusNodes[key] = FocusNode();
    return _MahasiswaRegisterViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    namaController.addListener(() => _updateFormData(model));
    npmController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    namaController.addListener(() => _updateFormData(model));
    npmController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NamaValueKey: namaController.text,
          NpmValueKey: npmController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _MahasiswaRegisterViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MahasiswaRegisterViewFocusNodes.values) {
      focusNode.dispose();
    }

    _MahasiswaRegisterViewTextEditingControllers.clear();
    _MahasiswaRegisterViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get namaValue => this.formValueMap[NamaValueKey] as String?;
  String? get npmValue => this.formValueMap[NpmValueKey] as String?;

  set namaValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NamaValueKey: value}),
    );

    if (_MahasiswaRegisterViewTextEditingControllers.containsKey(
        NamaValueKey)) {
      _MahasiswaRegisterViewTextEditingControllers[NamaValueKey]?.text =
          value ?? '';
    }
  }

  set npmValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NpmValueKey: value}),
    );

    if (_MahasiswaRegisterViewTextEditingControllers.containsKey(NpmValueKey)) {
      _MahasiswaRegisterViewTextEditingControllers[NpmValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasNama =>
      this.formValueMap.containsKey(NamaValueKey) &&
      (namaValue?.isNotEmpty ?? false);
  bool get hasNpm =>
      this.formValueMap.containsKey(NpmValueKey) &&
      (npmValue?.isNotEmpty ?? false);

  bool get hasNamaValidationMessage =>
      this.fieldsValidationMessages[NamaValueKey]?.isNotEmpty ?? false;
  bool get hasNpmValidationMessage =>
      this.fieldsValidationMessages[NpmValueKey]?.isNotEmpty ?? false;

  String? get namaValidationMessage =>
      this.fieldsValidationMessages[NamaValueKey];
  String? get npmValidationMessage =>
      this.fieldsValidationMessages[NpmValueKey];
}

extension Methods on FormStateHelper {
  setNamaValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NamaValueKey] = validationMessage;
  setNpmValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NpmValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    namaValue = '';
    npmValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NamaValueKey: getValidationMessage(NamaValueKey),
      NpmValueKey: getValidationMessage(NpmValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _MahasiswaRegisterViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _MahasiswaRegisterViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NamaValueKey: getValidationMessage(NamaValueKey),
      NpmValueKey: getValidationMessage(NpmValueKey),
    });
