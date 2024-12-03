import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Şehir Ara'),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'örnek: bursa...',
                border: OutlineInputBorder(),
              ),
            ),


            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text.trim();
                if (city.isNotEmpty) {
                  Navigator.pop(context, city);
                }
              },
              child: const Text('Ara'),
            ),
          ],
        ),
      ),
    );
  }
}
