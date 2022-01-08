import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/models/session_result.dart';
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
    emit(CprSessionProgress(
      timeLeft: 0,
      currentResults: SessionResult(
        sessionDate: DateTime.now(),
        numberOfChestCompressions: 0,
        averageCompressionsRate: 0.0,
        temporaryCompressionRate: const [],
      ),
    ));
    _setCprSessionTimerWithPeriodicUpdates();
    _sensorsRepository.onCprSessionStart();
  }

  Future<void> _setCprSessionTimerWithPeriodicUpdates() async {
    Timer _updateTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => emit(
        (state as CprSessionProgress).copyWith(
          timeLeft: 60 - timer.tick,
          currentResults: _sensorsRepository.calculateSessionResult(),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 60));
    _updateTimer.cancel();
    _onCprSessionEnd();
  }

  void _onCprSessionEnd() {
    emit(CprSessionSubmit(
      sessionResult: _sensorsRepository.calculateSessionResult(),
    ));
    _sensorsRepository.changeAccelerometerStreamState();
    _sensorsRepository.onCprSessionEnd();
  }

  void onCprSessionSubmitted() =>
      emit(const CprInformation(shouldShowCprInstruction: false));
}
