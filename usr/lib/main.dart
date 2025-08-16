import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vector Embedding Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  String _embeddingResult = '';
  bool _isLoading = false;

  Future<void> _getEmbedding() async {
    setState(() {
      _isLoading = true;
      _embeddingResult = '';
    });

    final text = _textController.text;
    if (text.isEmpty) {
      setState(() {
        _embeddingResult = 'Please enter some text.';
        _isLoading = false;
      });
      return;
    }

    // --- Backend Integration Placeholder ---
    // In a real application, you would make a call to your backend here.
    // This backend service (e.g., a Supabase Edge Function) would then
    // use a machine learning model to generate the vector embedding.
    //
    // Since Supabase is not connected, we will simulate a network call
    // and return a placeholder message.

    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    setState(() {
      _embeddingResult =
          'Vector embedding requires a backend. Please connect to Supabase to implement this feature. \n\nFor now, here is a simulated vector for "$text":\n[0.123, 0.456, 0.789, ...]';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vector Embedding'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text for embedding',
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getEmbedding,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Get Embedding'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _embeddingResult,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
