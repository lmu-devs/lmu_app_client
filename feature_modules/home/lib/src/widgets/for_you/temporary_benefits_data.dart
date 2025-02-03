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

final benefits = [
  const TemporaryBenefitsData(
    title: 'MVG Ermäßigungsticket',
    subtitle: 'Vergünstigtes Deutschlandticket für 38€ pro Monat',
    icon: LucideIcons.bus_front,
    url: 'https://www.mvg.de/abos-tickets/abos/ermaessigungsticket.html',
  ),
  const TemporaryBenefitsData(
    title: 'Zeitung und Zeitschriften',
    subtitle: 'Kostenfreier Zugriff auf verschiedene Zeitungen und Zeitschriften',
    icon: LucideIcons.newspaper,
    url: 'https://emedien.ub.uni-muenchen.de/login?url=https://www.pressreader.com/',
  ),
  const TemporaryBenefitsData(
    title: 'Münchner Philharmoniker',
    subtitle: 'Günstige Abos oder Einzeltickets',
    icon: LucideIcons.piano,
    url: 'https://www.mphil.de/',
  ),
  const TemporaryBenefitsData(
    title: 'Stattsoper',
    subtitle: 'Großes Angebot für günstige Tickets',
    icon: LucideIcons.theater,
    url: 'https://www.staatsoper.de/kleiner30',
  ),
];
