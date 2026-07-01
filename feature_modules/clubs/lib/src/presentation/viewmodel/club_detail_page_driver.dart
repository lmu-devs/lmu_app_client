import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club.dart';

part 'club_detail_page_driver.g.dart';

@GenerateTestDriver()
class ClubDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  ClubDetailPageDriver({
    @driverProvidableProperty required Club club,
  }) : _club = club;

  late Club _club;

  bool get hasExternalLink => _club.instagramUrl != null || _club.linkedinUrl != null || _club.url != null;

  bool get hasEmail => _club.email != null && _club.email!.isNotEmpty;

  bool get hasImage => _club.image != null && _club.image!.url.isNotEmpty;

  bool get hasContent => _club.content != null && _club.content!.isNotEmpty;

  bool get hasFoundingYear => _club.foundingYear != null;

  bool get hasLocation => _club.location != null && _club.location!.address.isNotEmpty;

  @override
  void didUpdateProvidedProperties({
    required Club newClub,
  }) {
    _club = newClub;
  }
}
