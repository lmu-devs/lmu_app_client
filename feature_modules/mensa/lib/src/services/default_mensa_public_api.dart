import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import '../bloc/mensa_cubit/cubit.dart';

class DefaultMensaService implements MensaService {
  @override
  List<MensaLocationData> get mensaData {
    final mensaCubitState = GetIt.I.get<MensaCubit>().state;
    if (mensaCubitState is! MensaLoadSuccess) {
      return [];
    }

    final mensaLocations = mensaCubitState.mensaModels
        .map(
          (e) => MensaLocationData(
            id: e.canteenId,
            address: e.location.address,
            latitude: e.location.latitude,
            longitude: e.location.longitude,
            type: e.type,
          ),
        )
        .toList();
    return mensaLocations;
  }
}
