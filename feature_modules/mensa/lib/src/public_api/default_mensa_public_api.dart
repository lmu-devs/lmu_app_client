import 'package:get_it/get_it.dart';
import 'package:mensa/src/public_api/models/mensa_location_data.dart';

import '../bloc/mensa_cubit/cubit.dart';
import 'mensa_public_api.dart';

class DefaultMensaPublicApi implements MensaPublicApi {
  @override
  String get test => 'test';

  @override
  List<MensaLocationData> get testLocations {
    final mensaCubitState = GetIt.I.get<MensaCubit>().state;
    if (mensaCubitState is! MensaLoadSuccess) {
      return [];
    }

    final mensaLocations = mensaCubitState.mensaModels.map((e) => e.location).toList();
    return mensaLocations;
  }
}
