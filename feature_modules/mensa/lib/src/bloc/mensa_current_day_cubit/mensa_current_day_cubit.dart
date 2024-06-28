import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/mensa_day.dart';

class MensaCurrentDayCubit extends Cubit<MensaDay> {
  MensaCurrentDayCubit() : super(MensaDay.now());

  void setCurrentMensaDay({required MensaDay newMensaDay}) {
    emit(newMensaDay);
  }
}
