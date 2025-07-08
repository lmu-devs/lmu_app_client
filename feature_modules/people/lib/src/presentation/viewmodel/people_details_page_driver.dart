import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:url_launcher/url_launcher.dart';

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

  People? get person => _usecase.data.where((p) => p.id == personId).firstOrNull;
  bool get isLoading => _usecase.loadState != PeopleLoadState.success;

  String get faculty => person?.faculty ?? '';
  String get role => person?.role ?? '';
  String get email => person?.email ?? '';
  String get phone => person?.phone ?? '';
  String get website => person?.website ?? '';
  String get room => person?.room ?? '';
  String get consultation => person?.consultation ?? '';

  Future<void> onEmailTap() async {
    print('onEmailTap');
  }

  Future<void> onPhoneTap() async {
    print('onPhoneTap');
  }

  Future<void> onWebsiteTap() async {
    final webUrl = Uri.parse(website);
    if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> onRoomTap() async {
    print('onRoomTap');
  }

  Future<void> onConsultationTap() async {
    print('onConsultationTap');
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
