import 'package:finances/core/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Function used to validate a [String]
///
/// If the [String] is valid, returns null. Otherwise, returns an error message.
typedef StringValidator = String? Function(String? text);

class AppFormField extends ConsumerWidget {
  const AppFormField({
    Key? key,
    required this.label,
    required this.obscureText,
    required this.semanticLabel,
    required this.validator,
    required this.controller,
    required this.isPassword,
    this.toogleObscured,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final String label;
  final String semanticLabel;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final VoidCallback? toogleObscured;
  final StringValidator validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(textThemeProvider);
    // Define an alternatif text for the screen reader
    return Semantics(
      label: isPassword ? null : semanticLabel,
      textField: true,
      excludeSemantics: !isPassword,
      // Exclude the TextFormFiel semantic (the labelText) in order to avoid redundancy
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: validator,
        obscureText: obscureText,
        style: styles.subtitle.primary,
        decoration: InputDecoration(
         
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          suffixIcon: isPassword
              ? Semantics(
                  container: true,
                  checked: !obscureText,
                  label: '',
                  child: GestureDetector(
                    onTap: toogleObscured,
                    child: Icon(
                      obscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                  ),
                )
              : null,
          labelText: label,
        ),
      ),
    );
  }
}
