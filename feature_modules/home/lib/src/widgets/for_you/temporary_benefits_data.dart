import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class TemporaryBenefitsData {
  const TemporaryBenefitsData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.url,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String url;
}

List<TemporaryBenefitsData> getBenefits(BuildContext context) {
  final locals = context.locals.home;
  return [
    TemporaryBenefitsData(
      title: locals.mvgTitle,
      subtitle: locals.mvgDescription,
      icon: LucideIcons.bus_front,
      url: 'https://www.mvg.de/abos-tickets/abos/ermaessigungsticket.html',
    ),
    TemporaryBenefitsData(
      title: locals.newsTitle,
      subtitle: locals.newsDescription,
      icon: LucideIcons.newspaper,
      url: 'https://emedien.ub.uni-muenchen.de/login?url=https://www.pressreader.com/',
    ),
    TemporaryBenefitsData(
      title: locals.philarmonikerTitle,
      subtitle: locals.philarmonikerDescription,
      icon: LucideIcons.piano,
      url: 'https://www.mphil.de/',
    ),
    TemporaryBenefitsData(
      title: locals.operaTitle,
      subtitle: locals.operaDescription,
      icon: LucideIcons.theater,
      url: 'https://www.staatsoper.de/kleiner30',
    ),
  ];
}
