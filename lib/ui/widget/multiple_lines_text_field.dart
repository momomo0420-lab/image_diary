import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MultipleLinesTextField extends HookWidget {
  final String? _initText;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;

  const MultipleLinesTextField({
    super.key,
    String? initText,
    String? label,
    String? hint,
    Function(String value)? onChanged,
    Function()? onClear,
  }): _initText = initText,
        _label = label,
        _hint = hint,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initText);

    return TextFormField(
      // style: const TextStyle(fontSize: 25),
      textAlign: TextAlign.start,
      controller: controller,
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: _onChanged,
    );
  }
}
