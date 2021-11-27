import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';

part 'cpr_screen_state.dart';

class CprScreenCubit extends Cubit<CprScreenState> {
  final SensorsRepository _sensorsRepository;

  CprScreenCubit({required SensorsRepository sensorsRepository})
      : _sensorsRepository = sensorsRepository,
        super(CprLoading());

  void onScreenOpened() {
    ServiceLocator.get<AccelerometerSensorService>()
        .initAccelerometerSensorStream();
    ServiceLocator.get<GyroscopeSensorService>().initGyroscopeSensorStream();
    log('Sensors: Initialized');
    _sensorsRepository.onAccelerometerDataStartPrinting();
  }

  void onScreenClosed() => _sensorsRepository.changeAccelerometerStreamState();
}
