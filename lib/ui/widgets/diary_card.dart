import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  final String _image;
  final String _date;
  final Function() _onTap;

  const DiaryCard({
    super.key,
    required String image,
    required String date,
    required Function() onTap,
  }): _image = image,
        _date = date,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 280,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: _onTap,
              child: Column(
                children: [
                  Image.asset(
                    _image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _date,
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
