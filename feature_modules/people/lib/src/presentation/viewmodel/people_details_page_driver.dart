import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_people_usecase.dart';
import '../../application/usecase/get_people_usecase.dart';
import '../../domain/model/people.dart';

part 'people_details_page_driver.g.dart';

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  PeopleDetailsPageDriver({
    @driverProvidableProperty required int personId,
  }) : _personId = personId;

  late int _personId;

  int get personId => _personId;

  final _usecase = GetIt.I.get<GetPeopleUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoritePeopleUsecase>();

  late LmuLocalizations _localizations;

  String get loadingText => _localizations.people.loading;
  String get personNotFoundText => _localizations.people.personNotFound;
  String get contactText => _localizations.people.contact;
  String get emailText => _localizations.people.email;
  String get phoneText => _localizations.people.phone;
  String get websiteText => "Website";
  String get roomText => _localizations.people.room;
  String get consultationHoursText => _localizations.people.consultationHours;
  String get copiedEmailText => _localizations.people.copiedEmail;
  String get copiedPhoneText => _localizations.people.copiedPhone;
  String get copiedWebsiteText => _localizations.people.copiedWebsite;
  String get addedToFavoritesText => _localizations.app.favoriteAdded;
  String get removedFromFavoritesText => _localizations.app.favoriteRemoved;

  People? get person => _usecase.data.where((p) => p.id == personId).firstOrNull;
  bool get isLoading => _usecase.loadState != PeopleLoadState.success;
  bool get isFavorite => _favoritesUsecase.isFavorite(personId);

  String get faculty => person?.faculty ?? '';
  String get role => person?.role ?? '';
  String get title => person?.title ?? '';
  String get email => person?.email ?? '';
  String get phone => person?.phone ?? '';
  String get website => person?.website ?? '';
  String get room => person?.room ?? '';
  String get consultation => person?.consultation ?? '';

  String get facultyAndRole {
    final facultyText = faculty.isNotEmpty ? faculty : '';
    final titleText = title.isNotEmpty ? title : '';

    if (facultyText.isNotEmpty && titleText.isNotEmpty) {
      return '$titleText, $facultyText';
    } else if (facultyText.isNotEmpty) {
      return facultyText;
    } else if (titleText.isNotEmpty) {
      return titleText;
    }
    return '';
  }

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
    await _favoritesUsecase.toggleFavorite(personId);
    final nowFavorite = isFavorite;
    final toast = LmuToast.of(context);
    if (nowFavorite && !wasFavorite) {
      toast.showToast(message: addedToFavoritesText, type: ToastType.success);
    } else if (!nowFavorite && wasFavorite) {
      toast.showToast(message: removedFromFavoritesText, type: ToastType.success);
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);
    if (_usecase.data.isEmpty) {
      _usecase.load();
    }
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({
    required int newPersonId,
  }) {
    _personId = newPersonId;
    notifyWidget();
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
