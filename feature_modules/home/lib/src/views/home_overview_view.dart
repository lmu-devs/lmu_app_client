import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import '../repository/api/models/home_model.dart';
import 'home_links_view.dart';

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({
    super.key,
    required this.homeData,
  });

  final HomeModel homeData;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: LmuSizes.size_24),
      HomeLinksView(links: homeData.links),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: LmuSizes.size_16, vertical: LmuSizes.size_16),
        child: LmuContentTile(
          content: [
            LmuListItem.base(
              title: "Studienbeitrag",
              trailingTitleInTextVisuals: [
                LmuInTextVisual.text(
                    title: homeData.submissionFee,
                    color: Colors.deepOrangeAccent),
              ],
              mainContentAlignment: MainContentAlignment.center,
            ),
            LmuListItem.base(
              title: "Vorlesungszeit",
              trailingTitleInTextVisuals: [
                LmuInTextVisual.text(
                    title: homeData.lectureTime, color: Colors.blue),
              ],
              mainContentAlignment: MainContentAlignment.center,
            ),
            LmuListItem.base(
              title: "Vorlesungsfreiezeit",
              trailingTitleInTextVisuals: [
                LmuInTextVisual.text(
                    title: homeData.lectureFreeTime, color: Colors.blue),
              ],
              mainContentAlignment: MainContentAlignment.center,
            ),
          ],
        ),
      ),
    ]);
  }
}
