import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/product.dart';


class ProductIllustration extends StatelessWidget {
  const ProductIllustration({
    super.key,
    required this.art,
    required this.color,
  });

  final ProductArt art;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(painter: _ArtPainter(art, color)),
    );
  }
}

class _ArtPainter extends CustomPainter {
  _ArtPainter(this.art, this.accent);

  final ProductArt art;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
   
    final scale = math.min(size.width, size.height) / 200;
    canvas.save();
    canvas.translate(
      (size.width - 200 * scale) / 2,
      (size.height - 200 * scale) / 2,
    );
    canvas.scale(scale);

    switch (art) {
      case ProductArt.shoes:
        _shoes(canvas);
        break;
      case ProductArt.backpack:
        _backpack(canvas);
        break;
      case ProductArt.watch:
        _watch(canvas);
        break;
      case ProductArt.headphone:
        _headphone(canvas);
        break;
      case ProductArt.bottle:
        _bottle(canvas);
        break;
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArtPainter oldDelegate) =>
      oldDelegate.art != art || oldDelegate.accent != accent;

  
  void _shoes(Canvas canvas) {
    _shadow(canvas, const Offset(108, 170), 176);

   
    final sole = Path()
      ..moveTo(24, 142)
      ..lineTo(184, 142)
      ..quadraticBezierTo(194, 142, 192, 152)
      ..quadraticBezierTo(190, 164, 174, 164)
      ..lineTo(42, 164)
      ..quadraticBezierTo(24, 164, 24, 150)
      ..close();
    canvas.drawPath(sole, _fill(Colors.white));
    canvas.save();
    canvas.clipPath(sole);
    canvas.drawRect(
      const Rect.fromLTWH(0, 157, 200, 12),
      _fill(const Color(0xFF2B2D42)),
    );
    for (final x in [56.0, 90.0, 124.0, 158.0]) {
      canvas.drawCircle(
        Offset(x, 150),
        3,
        _fill(const Color(0xFFE3E6EF)),
      );
    }
    canvas.restore();
    canvas.drawPath(sole, _stroke(const Color(0xFFD5D9E6), 1.5));

    
    final upper = Path()
      ..moveTo(26, 142)
      ..lineTo(28, 100)
      ..quadraticBezierTo(29, 84, 46, 82)
      ..lineTo(64, 82)
      ..quadraticBezierTo(76, 82, 82, 94)
      ..quadraticBezierTo(90, 108, 108, 110)
      ..lineTo(138, 112)
      ..quadraticBezierTo(180, 118, 190, 140)
      ..lineTo(190, 144)
      ..lineTo(26, 144)
      ..close();
    canvas.drawPath(upper, _fill(accent));
    canvas.save();
    canvas.clipPath(upper);
    
    canvas.drawRect(
      const Rect.fromLTWH(20, 80, 26, 70),
      _fill(_tone(accent, l: 0.38)),
    );
   
    final swoosh = Path()
      ..moveTo(44, 136)
      ..quadraticBezierTo(100, 112, 178, 134);
    canvas.drawPath(swoosh, _stroke(Colors.white, 7));
    canvas.restore();

   
    final tongue = Path()
      ..moveTo(60, 86)
      ..quadraticBezierTo(58, 62, 76, 64)
      ..quadraticBezierTo(92, 66, 90, 96)
      ..close();
    canvas.drawPath(tongue, _fill(_tone(accent, l: 0.62)));

    
    for (var i = 0; i < 4; i++) {
      final x = 88.0 + i * 14;
      final y = 96 + i * 4.5;
      canvas.drawLine(
        Offset(x, y - 6),
        Offset(x + 8, y + 8),
        _stroke(Colors.white, 3.5),
      );
    }
  }

  
  void _backpack(Canvas canvas) {
    _shadow(canvas, const Offset(100, 176), 110);

    final dark = _tone(accent, l: 0.30);
    final pocketColor = _tone(accent, l: 0.38);

   
    final handle = Path()
      ..moveTo(84, 42)
      ..quadraticBezierTo(100, 14, 116, 42);
    canvas.drawPath(handle, _stroke(dark, 7));

    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(40, 100, 24, 60),
        const Radius.circular(11),
      ),
      _fill(dark),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(136, 100, 24, 60),
        const Radius.circular(11),
      ),
      _fill(dark),
    );

    
    const bodyRect = Rect.fromLTWH(52, 36, 96, 136);
    final body = RRect.fromRectAndCorners(
      bodyRect,
      topLeft: const Radius.circular(44),
      topRight: const Radius.circular(44),
      bottomLeft: const Radius.circular(22),
      bottomRight: const Radius.circular(22),
    );
    canvas.drawRRect(
      body,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_tone(accent, l: 0.62), accent, _tone(accent, l: 0.38)],
        ).createShader(bodyRect),
    );

   
    final seam = Path()
      ..moveTo(58, 80)
      ..quadraticBezierTo(100, 64, 142, 80);
    canvas.drawPath(seam, _stroke(dark, 2.5));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(96, 68, 8, 14),
        const Radius.circular(3),
      ),
      _fill(Colors.white),
    );

   
    final pocket = RRect.fromRectAndCorners(
      const Rect.fromLTWH(64, 106, 72, 58),
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: const Radius.circular(14),
      bottomRight: const Radius.circular(14),
    );
    canvas.drawRRect(pocket, _fill(pocketColor));
    canvas.drawLine(
      const Offset(72, 118),
      const Offset(128, 118),
      _stroke(Colors.white.withAlpha(190), 2),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(96, 114, 8, 10),
        const Radius.circular(3),
      ),
      _fill(Colors.white),
    );

    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(84, 134, 32, 16),
        const Radius.circular(5),
      ),
      _fill(Colors.white),
    );
    _text(canvas, '20L', const Offset(100, 142), 9, accent);
  }

  
  void _watch(Canvas canvas) {
    const strap = Color(0xFF3B2A25);
    const c = Offset(100, 100);

   
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(80, 6, 40, 66),
        const Radius.circular(10),
      ),
      _fill(strap),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(80, 128, 40, 66),
        const Radius.circular(10),
      ),
      _fill(strap),
    );
    
    for (final x in [85.0, 115.0]) {
      canvas.drawLine(
        Offset(x, 12),
        Offset(x, 62),
        _stroke(Colors.white.withAlpha(70), 1.2),
      );
      canvas.drawLine(
        Offset(x, 138),
        Offset(x, 188),
        _stroke(Colors.white.withAlpha(70), 1.2),
      );
    }
    
    for (final y in [152.0, 164.0, 176.0]) {
      canvas.drawCircle(Offset(100, y), 2.6, _fill(const Color(0xFF1B1210)));
    }

   
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(146, 94, 13, 12),
        const Radius.circular(3),
      ),
      _fill(_tone(accent, l: 0.45)),
    );

    
    final caseRect = Rect.fromCircle(center: c, radius: 50);
    canvas.drawCircle(
      c,
      50,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_tone(accent, l: 0.85), accent, _tone(accent, l: 0.28)],
        ).createShader(caseRect),
    );
    canvas.drawCircle(c, 46, _stroke(Colors.white.withAlpha(120), 1.5));

    
    canvas.drawCircle(c, 40, _fill(const Color(0xFFFFFBF2)));
    canvas.drawCircle(c, 40, _stroke(const Color(0xFFD9D2C0), 1.5));

    
    for (var i = 0; i < 12; i++) {
      final r = i * 30 * math.pi / 180;
      final dir = Offset(math.sin(r), -math.cos(r));
      final major = i % 3 == 0;
      canvas.drawLine(
        c + dir * (major ? 29.0 : 33.0),
        c + dir * 37.0,
        _stroke(const Color(0xFF3A3A3A), major ? 3 : 1.8),
      );
    }

    _text(canvas, 'WR 50M', const Offset(100, 122), 6, const Color(0xFF8A8577));

    
    _hand(canvas, c, 305, 22, 4.5, const Color(0xFF222222));
    _hand(canvas, c, 60, 32, 3, const Color(0xFF222222));
    _hand(canvas, c, 120, 34, 1.5, const Color(0xFFE11D48), tail: 8);
    canvas.drawCircle(c, 4.5, _fill(accent));
    canvas.drawCircle(c, 1.8, _fill(const Color(0xFFE11D48)));
  }

  void _hand(
    Canvas canvas,
    Offset c,
    double deg,
    double len,
    double w,
    Color color, {
    double tail = 0,
  }) {
    final r = deg * math.pi / 180;
    final dir = Offset(math.sin(r), -math.cos(r));
    canvas.drawLine(c - dir * tail, c + dir * len, _stroke(color, w));
  }

  // --------------------------------------------------------------- HEADPHONE
  void _headphone(Canvas canvas) {
    const dark = Color(0xFF2B2D42);
    _shadow(canvas, const Offset(100, 176), 120);

    // Bando kepala
    final band = Path()
      ..moveTo(39, 98)
      ..cubicTo(34, 6, 166, 6, 161, 98);
    canvas.drawPath(band, _stroke(dark, 11));
    canvas.drawPath(band, _stroke(accent, 4));

    // Bantalan telinga (sisi dalam)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(50, 100, 18, 54),
        const Radius.circular(9),
      ),
      _fill(dark),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(132, 100, 18, 54),
        const Radius.circular(9),
      ),
      _fill(dark),
    );

    // Cangkang earcup
    const shellL = Rect.fromLTWH(22, 92, 34, 70);
    const shellR = Rect.fromLTWH(144, 92, 34, 70);
    for (final r in [shellL, shellR]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(17)),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_tone(accent, l: 0.62), _tone(accent, l: 0.40)],
          ).createShader(r),
      );
    }

    
    for (final cx in [39.0, 161.0]) {
      canvas.drawCircle(
        Offset(cx, 127),
        9,
        _stroke(Colors.white.withAlpha(200), 2),
      );
      canvas.drawCircle(Offset(cx, 127), 2.6, _fill(Colors.white));
    }
    canvas.drawCircle(const Offset(39, 108), 2, _fill(const Color(0xFF4ADE80)));
  }

  
  void _bottle(Canvas canvas) {
    const dark = Color(0xFF2B2D42);
    _shadow(canvas, const Offset(100, 188), 84);

    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(94, 8, 32, 26),
        const Radius.circular(10),
      ),
      _stroke(dark, 5),
    );

   
    final body = Path()
      ..moveTo(64, 84)
      ..quadraticBezierTo(64, 60, 80, 54)
      ..lineTo(120, 54)
      ..quadraticBezierTo(136, 60, 136, 84)
      ..lineTo(136, 176)
      ..quadraticBezierTo(136, 186, 126, 186)
      ..lineTo(74, 186)
      ..quadraticBezierTo(64, 186, 64, 176)
      ..close();
    const bodyRect = Rect.fromLTWH(64, 54, 72, 132);
    canvas.drawPath(
      body,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_tone(accent, l: 0.68), accent, _tone(accent, l: 0.30)],
          stops: const [0.0, 0.35, 1.0],
        ).createShader(bodyRect),
    );

    canvas.save();
    canvas.clipPath(body);
    
    canvas.drawRect(
      const Rect.fromLTWH(64, 112, 72, 28),
      _fill(Colors.white.withAlpha(235)),
    );
    _text(canvas, '750 ml', const Offset(100, 126), 10, _tone(accent, l: 0.30));
   
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(72, 62, 7, 112),
        const Radius.circular(4),
      ),
      _fill(Colors.white.withAlpha(80)),
    );
    canvas.restore();

    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(80, 50, 40, 8),
        const Radius.circular(3),
      ),
      _fill(const Color(0xFFCBD5E1)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(78, 26, 44, 26),
        const Radius.circular(8),
      ),
      _fill(dark),
    );
    for (var i = 0; i < 5; i++) {
      final x = 86.0 + i * 7;
      canvas.drawLine(
        Offset(x, 31),
        Offset(x, 46),
        _stroke(Colors.white.withAlpha(45), 2),
      );
    }
  }
}


Paint _fill(Color c) => Paint()
  ..color = c
  ..style = PaintingStyle.fill
  ..isAntiAlias = true;

Paint _stroke(Color c, double w) => Paint()
  ..color = c
  ..style = PaintingStyle.stroke
  ..strokeWidth = w
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..isAntiAlias = true;

void _shadow(Canvas canvas, Offset center, double width) {
  canvas.drawOval(
    Rect.fromCenter(center: center, width: width, height: 12),
    Paint()
      ..color = const Color(0x26000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
  );
}

Color _tone(Color c, {double? l}) {
  final h = HSLColor.fromColor(c);
  return h.withLightness(l ?? h.lightness).toColor();
}

void _text(
  Canvas canvas,
  String text,
  Offset center,
  double size,
  Color color,
) {
  final tp = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
}
