import 'package:flutter/material.dart';

class ContentTextField extends StatelessWidget {
  final TextEditingController _controller;
  final Function(String)? _onSubmitted;

  const ContentTextField({
    super.key,
    required TextEditingController controller,
    Function(String)? onSubmitted,
  }): _onSubmitted = onSubmitted,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(
              fontSize: 25
            ),
            textAlign: TextAlign.start,
            controller: _controller,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            onFieldSubmitted: (text) => (_onSubmitted == null) ? null : _onSubmitted!(text),
            decoration: const InputDecoration(
              hintText: 'ここに本文を入力',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
