import 'dart:html';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

import 'package:petname/petNameInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pet name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      ),
      home: MainPage(
        title: 'pet name',
        camera: camera,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;
  final CameraDescription camera;

  const MainPage({super.key, required this.title, required this.camera});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void test() {
    print('되고있는거임?');
  }

  void navigateToNextScreen(XFile image, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PetNameInfo(image: image, imagePath: imagePath)),
    );
  }

  Future<void> captureAndSaveImage() async {
    await _initializeControllerFuture;
    final image = await _controller.takePicture();

    // print('Image ??? ==========: $image');

    // 앱의 로컬 디렉토리 경로 가져오기
    // final appDir = await getApplicationDocumentsDirectory();
    // final random = Random().nextInt(100000);
    // final imageName = 'image_$random.jpg';
    // final imagePath = path.join(appDir.path, imageName);

    // // 이미지 저장
    // await image.saveTo(imagePath);

    const imagePath = "test path";
    navigateToNextScreen(image, imagePath);

    // 저장된 이미지의 로컬 경로 출력
    // print('Image saved to: $imagePath');
  }

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
        // camera setting
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // 컨트롤러 초기화가 완료되면 카메라 미리보기를 표시합니다.
              return CameraPreview(_controller);
            } else {
              // 컨트롤러 초기화가 진행 중이면 로딩 인디케이터를 표시합니다.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          height: screenHeight * 0.20, // 원하는 너비로 설정합니다.
          child: BottomNavigationBar(
            showSelectedLabels: false,
            currentIndex: 1,
            onTap: (int index) {
              if (index == 1) {
                captureAndSaveImage();
              }
            },
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
