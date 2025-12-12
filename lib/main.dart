import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hybrid Test',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        useMaterial3: true,
      ),
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

  // Контроллер для WebView (вкладка 3)
  late final WebViewController _webController;

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <body style="background-color:#e0f7fa; display:flex; justify-content:center; align-items:center; height:100vh; margin:0;">
          <h1 style="color:#006064; font-family:sans-serif; text-align:center;">
            а это вебвью на простом html
          </h1>
        </body>
        </html>
      ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(_selectedIndex)),
        backgroundColor: Colors.cyan,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Вкладка 1: Flutter
          const Center(
            child: Text('Меню 1 (Flutter Text)', style: TextStyle(fontSize: 24)),
          ),
          
          // Вкладка 2: NATIVE VIEW (AndroidView)
          // Flutter просит Android отрендерить 'native_text_view'
          const AndroidView(
            viewType: 'native_text_view',
            layoutDirection: TextDirection.ltr,
          ),

          // Вкладка 3: WebView
          WebViewWidget(controller: _webController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'Flutter'),
          BottomNavigationBarItem(icon: Icon(Icons.android), label: 'Native'),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: 'WebView'),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0: return 'Pure Flutter';
      case 1: return 'Native Kotlin';
      case 2: return 'WebView HTML';
      default: return 'App';
    }
  }
}
