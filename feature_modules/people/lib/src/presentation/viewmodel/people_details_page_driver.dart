import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';

import '../../application/usecase/get_people_usecase.dart';
import '../../domain/model/people.dart';

part 'people_details_page_driver.g.dart';

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  PeopleDetailsPageDriver({
    @driverProvidableProperty required int personId,
  }) : _personId = personId;

  late int _personId;

  @override
  int get personId => _personId;

  final _usecase = GetIt.I.get<GetPeopleUsecase>();

  late LmuLocalizations _localizations;

  String get loadingText => _localizations.people.loading;
  String get personNotFoundText => _localizations.people.personNotFound;
  String get facultyAndRoleText => _localizations.people.facultyAndRole;
  String get contactText => _localizations.people.contact;
  String get emailText => _localizations.people.email;
  String get phoneText => _localizations.people.phone;
  String get websiteText => _localizations.people.website;
  String get roomText => _localizations.people.room;
  String get consultationHoursText => _localizations.people.consultationHours;

  People? get person => _usecase.data.where((p) => p.id == personId).firstOrNull;
  bool get isLoading => _usecase.loadState != PeopleLoadState.success;

  String get faculty => person?.faculty ?? '';
  String get role => person?.role ?? '';
  String get email => person?.email ?? '';
  String get phone => person?.phone ?? '';
  String get website => person?.website ?? '';
  String get room => person?.room ?? '';
  String get consultation => person?.consultation ?? '';

  Future<void> onEmailTap(BuildContext context) async {
    await LmuUrlLauncher.launchEmail(email: email, context: context);
  }

  Future<void> onPhoneTap(BuildContext context) async {
    await LmuUrlLauncher.launchPhone(phoneNumber: phone, context: context);
  }

  Future<void> onWebsiteTap(BuildContext context) async {
    await LmuUrlLauncher.launchWebsite(url: website, context: context);
  }

  Future<void> onRoomTap() async {
    // TODO: Implement room tap functionality (e.g., open maps)
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
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
    super.dispose();
  }
}
