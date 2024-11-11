import 'package:flutter/material.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class SoftBlur extends StatelessWidget {
  final Widget child;

  const SoftBlur({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SoftEdgeBlur(
      edges: [
        EdgeBlur(
          type: EdgeType.topEdge,
          size: MediaQuery.of(context).padding.top,
          sigma: 25,
          controlPoints: [
            ControlPoint(
              position: 0.5,
              type: ControlPointType.visible,
            ),
            ControlPoint(
              position: 1,
              type: ControlPointType.transparent,
            ),
          ],
        ),
      ],
      child: child,
    );
  }
}
