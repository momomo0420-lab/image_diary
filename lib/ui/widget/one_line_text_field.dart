import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OneLineTextField extends HookWidget {
  final String? _initText;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;
  final Function()? _onClear;

  const OneLineTextField({
    super.key,
    String? initText,
    String? label,
    String? hint,
    Function(String value)? onChanged,
    Function()? onClear,
  }): _initText = initText,
        _label = label,
        _hint = hint,
        _onChanged = onChanged,
        _onClear = onClear;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initText);

    return TextFormField(
      // style: const TextStyle(fontSize: 25),
      textAlign: TextAlign.start,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            if(_onClear != null) _onClear!();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: _onChanged,
    );
  }
}
