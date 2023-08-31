import 'package:flutter/material.dart';

void main() {
  runApp(const BlankWidget());
}

class BlankWidget extends StatelessWidget {
  const BlankWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
