import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pet name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      ),
      home: const MainPage(title: 'pet name'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: screenHeight,
        color: Colors.white,
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          height: screenHeight * 0.20, // 원하는 너비로 설정합니다.
          child: BottomNavigationBar(
            showSelectedLabels: false,
            // showUnselectedLabels: false,
            currentIndex: 1,
            onTap: (int index) => setState(() => _index = index),
            items: [
              BottomNavigationBarItem(
                // tooltip: 'show/hide',
                icon: Icon(
                  Icons.add_to_queue_sharp,
                  weight: 0.01,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/dot.png',
                  height: screenHeight * 0.12,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '불러오기',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
