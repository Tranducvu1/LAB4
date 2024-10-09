import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("Ask me anything"),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
        ),
        body: const Ball(),
      ),
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  State<Ball> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Ball> {
  int ballNumber = 1;

  void updateImage() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // This is the outer glow or shadow effect
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 20,
                  blurRadius: 50,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Image.asset("images/ball$ballNumber.png"),
          ),
          CustomPaint(
            size: const Size(250, 250), // Kích thước tam giác
            painter: TrianglePainter(),
          ),
          // Optionally, you can add a highlight overlay here
          Positioned(
            top: 50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.black.withOpacity(0.2), Colors.transparent],
                  radius: 0.6,
                  center: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade100.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Dịch canvas lên trên 10 đơn vị
    canvas.translate(0, -40);

    // Xác định ba điểm của tam giác
    final path = Path()
      ..moveTo(size.width / 2, 0) // Đỉnh tam giác
      ..lineTo(0, size.height) // Góc trái dưới
      ..lineTo(size.width, size.height) // Góc phải dưới
      ..close(); // Đóng đường path

    // Vẽ tam giác lên canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
