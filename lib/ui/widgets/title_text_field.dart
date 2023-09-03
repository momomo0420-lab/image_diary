import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController _controller;
  final Function(String)? _onSubmitted;

  const TitleTextField({
    super.key,
    required TextEditingController controller,
    Function(String)? onSubmitted,
  }) : _onSubmitted = onSubmitted,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.start,
            controller: _controller,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (text) => (_onSubmitted == null) ? null : _onSubmitted!(text),
            decoration: InputDecoration(
              hintText: '題名',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
