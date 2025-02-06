// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart' hide Path;

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: MapController(),
          options: MapOptions(
              initialCenter: const LatLng(48.151775, 11.570614),
              initialZoom: 14,
              onMapReady: () {
                "Map is ready";
              }),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/bitterschoki/cm6sdggxw00cg01s1czpmep1y/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYml0dGVyc2Nob2tpIiwiYSI6ImNrbmVtOGhyNzA4ZmQyb2tiaWg0dDhvdnMifQ.JQ08j5SQHJovNu30K54Ftw/draft',
              additionalOptions: {
                "accessToken":
                    "pk.eyJ1IjoiYml0dGVyc2Nob2tpIiwiYSI6ImNrbmVtOGhyNzA4ZmQyb2tiaWg0dDhvdnMifQ.JQ08j5SQHJovNu30K54Ftw",
                "id": "mapbox.mapbox-streets-v8",
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(48.151775, 11.570614),
                  child: SvgPicture.asset(
                    'feature_modules/explore/assets/Shape.svg',
                  ),
                ),
                Marker(
                  point: const LatLng(48.151775, 11.580614),
                  child: SvgPicture.asset(
                    'feature_modules/explore/assets/Shape.svg',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PinExample extends StatelessWidget {
  const PinExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: RPSCustomPainter(
            contentColor: context.colors.mensaColors.textColors.mensa,
            borderColor: Colors.white.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  const RPSCustomPainter({
    required this.contentColor,
    required this.borderColor,
  });

  final Color contentColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(48, 24.4717);
    path_0.cubicTo(48, 31.095, 45.3385, 37.1292, 41, 41.4717);
    path_0.cubicTo(38.4349, 44.0392, 32.9375, 48.1469, 28.8657, 51.0803);
    path_0.cubicTo(25.9009, 53.2161, 21.9194, 53.1999, 18.9705, 51.0425);
    path_0.cubicTo(14.957, 48.1062, 9.55477, 44.0143, 7, 41.467);
    path_0.cubicTo(2.6423, 37.1219, 0, 31.1117, 0, 24.4717);
    path_0.cubicTo(0, 11.2168, 10.7452, 0.47168, 24, 0.47168);
    path_0.cubicTo(37.2548, 0.47168, 48, 11.2168, 48, 24.4717);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = contentColor.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(46.9048, 24.4717);
    path_1.cubicTo(46.9048, 30.7974, 44.3638, 36.5552, 40.2252, 40.6976);
    path_1.cubicTo(37.7349, 43.1902, 32.3159, 47.2449, 28.2255, 50.1917);
    path_1.cubicTo(25.6458, 52.0501, 22.1837, 52.0363, 19.6171, 50.1586);
    path_1.cubicTo(15.5868, 47.2099, 10.2575, 43.1684, 7.77331, 40.6914);
    path_1.cubicTo(3.61779, 36.5479, 1.09521, 30.8152, 1.09521, 24.4717);
    path_1.cubicTo(1.09521, 11.8217, 11.35, 1.56689, 24, 1.56689);
    path_1.cubicTo(36.65, 1.56689, 46.9048, 11.8217, 46.9048, 24.4717);
    path_1.close();

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;
    paint_1_stroke.color = Colors.white.withOpacity(0.3);
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = contentColor.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
