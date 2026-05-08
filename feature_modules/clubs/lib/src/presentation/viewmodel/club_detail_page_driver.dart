import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club.dart';
import '../../domain/models/club_category_type.dart';
import '../../domain/models/club_type.dart';

part 'club_detail_page_driver.g.dart';

@GenerateTestDriver()
class ClubDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  ClubDetailPageDriver({
    @driverProvidableProperty required Club club,
  }) : _club = club;

  late Club _club;

  @TestDriverDefaultValue(Club(
      id: '',
      universityId: '',
      type: ClubType.fachschaft,
      title: '',
      description: '',
      category: ClubCategoryType.academic))
  Club get club => _club;

  @override
  void didUpdateProvidedProperties({
    required Club newClub,
  }) {
    _club = newClub;
  }
}
