import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Для MethodChannel
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hybrid Activity',
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  // Канал для общения с Android
  static const platform = MethodChannel('com.example.hybrid/nav');

  late final WebViewController _webController;

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString('''
        <!DOCTYPE html><html><body style="background:#e0f2f1;display:flex;justify-content:center;align-items:center;height:100vh;margin:0">
        <h1 style="color:#00695c;font-family:sans-serif">а это вебвью на простом html</h1>
        </body></html>
      ''');
  }

  // Метод запуска нативного Activity
  Future<void> _launchNative() async {
    try {
      await platform.invokeMethod('openNativeScreen');
    } on PlatformException catch (e) {
      debugPrint("Не удалось открыть натив: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hybrid App"), backgroundColor: Colors.orange),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // 1. Flutter
          const Center(child: Text("Меню 1: Flutter", style: TextStyle(fontSize: 24))),
          
          // 2. Native Launcher (вместо embedded view)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.android, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                const Text("Нативный экран (Activity)", style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _launchNative, // Вызываем Kotlin
                  child: const Text("ОТКРЫТЬ NATIVE ACTIVITY"),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Это откроет отдельный Kotlin экран поверх Flutter", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),

          // 3. WebView
          WebViewWidget(controller: _webController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.orange[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'Flutter'),
          BottomNavigationBarItem(icon: Icon(Icons.android), label: 'Native'),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: 'WebView'),
        ],
      ),
    );
  }
}
