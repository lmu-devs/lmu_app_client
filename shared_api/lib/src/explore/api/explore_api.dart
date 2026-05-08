import '../../../explore.dart';

abstract class ExploreApi {
  void applyFilter(ExploreFilterType filter);

  void selectLocation(String locationId);
}
