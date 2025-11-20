import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_courses_usecase.dart';
import '../../application/usecase/get_course_details_usecase.dart';
import '../../application/usecase/get_courses_usecase.dart';
import '../../domain/model/course_details_model.dart';

part 'course_details_page_driver.g.dart';

@GenerateTestDriver()
class CourseDetailsPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  CourseDetailsPageDriver({@driverProvidableProperty required int courseId})
      : _courseId = courseId;

  late int _courseId;

  int get courseId => _courseId;

  final _usecase = GetIt.I.get<GetCourseDetailsUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteCoursesUsecase>();

  late LmuLocalizations _localizations;

  /**
      String get loadingText => _localizations.courses.loading;
      String get courseNotFoundText => _localizations.courses.courseNotFound;
      String get contactText => _localizations.courses.contact;
      String get emailText => _localizations.courses.email;
      String get phoneText => _localizations.courses.phone;
      String get websiteText => "Website";
      String get roomText => _localizations.courses.room;
      String get consultationHoursText => _localizations.courses.consultationHours;
      String get copiedEmailText => _localizations.courses.copiedEmail;
      String get copiedPhoneText => _localizations.app.copiedPhone;
      String get copiedWebsiteText => _localizations.courses.copiedWebsite;
      String get addedToFavoritesText => _localizations.app.favoriteAdded;
      String get removedFromFavoritesText => _localizations.app.favoriteRemoved;
   **/

  CourseDetailsModel? get courseDetails => _usecase.data;

  bool get isLoading =>
      _usecase.loadState == CoursesLoadState.loading ||
          _usecase.loadState == CoursesLoadState.initial;

  bool get isFavorite => _favoritesUsecase.isFavorite(courseId);
  Future<void> toggleFavorite(int id) async {
    await _favoritesUsecase.toggleFavorite(id);
  }

  /**
      String get faculty => course?.faculty ?? '';
      String get role => course?.role ?? '';
      String get title => course?.title ?? '';
      String get email => course?.email ?? '';
      String get phone => course?.phone ?? '';
      String get website => course?.website ?? '';
      String get room => course?.room ?? '';
      String get consultation => course?.consultation ?? '';
   **/

  /**
      Future<void> onEmailTap(BuildContext context) async {
      await LmuUrlLauncher.launchEmail(email: email, context: context);
      }

      Future<void> onPhoneTap(BuildContext context) async {
      await LmuUrlLauncher.launchPhone(phoneNumber: phone, context: context);
      }

      Future<void> onWebsiteTap(BuildContext context) async {
      await LmuUrlLauncher.launchWebsite(url: website, context: context, mode: LmuUrlLauncherMode.inAppWebView);
      }

      Future<void> onRoomTap() async {}

      Future<void> onConsultationTap() async {}

      Future<void> onFavoriteTap(BuildContext context) async {
      final wasFavorite = isFavorite;
      await _favoritesUsecase.toggleFavorite(courseId);
      final nowFavorite = isFavorite;
      final toast = LmuToast.of(context);
      if (nowFavorite && !wasFavorite) {
      toast.showToast(message: addedToFavoritesText, type: ToastType.success);
      } else if (!nowFavorite && wasFavorite) {
      toast.showToast(message: removedFromFavoritesText, type: ToastType.success);
      }
      }
   **/

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);
    _usecase.load(courseId);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({
    required int newCourseId,
  }) {
    if (_courseId != newCourseId) {
      _courseId = newCourseId;
      _usecase.load(_courseId);
    }
  }

  void _onStateChanged() {
    notifyWidget();
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
