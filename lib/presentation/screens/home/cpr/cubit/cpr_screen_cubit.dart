import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/repositories/cpr_repository.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';

part 'cpr_screen_state.dart';

class CprScreenCubit extends Cubit<CprScreenState> {
  final SensorsRepository _sensorsRepository;
  final CprRepository _cprRepository;

  CprScreenCubit({
    required SensorsRepository sensorsRepository,
    required CprRepository cprRepository,
  })  : _sensorsRepository = sensorsRepository,
        _cprRepository = cprRepository,
        super(CprInitial());

  Future<void> onScreenOpened() async => emit(CprInformation(
        shouldShowCprInstruction:
            await _cprRepository.shouldShowCprInstruction(),
      ));

  void onCprInstructionPop() => _cprRepository.cprInstructionClosed();

  void onCprSessionStart() {
    emit(CprSessionWaiting());
    _startReceivingDataAfterCountdown();
  }

  Future<void> _startReceivingDataAfterCountdown() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(CprSessionProgress());
    _sensorsRepository.onCprSessionStart();
  }

  void onCprSessionEnd() {
    emit(const CprInformation(shouldShowCprInstruction: false));
    _sensorsRepository.changeAccelerometerStreamState();
    _sensorsRepository.onCprSessionEnd();
  }
}
