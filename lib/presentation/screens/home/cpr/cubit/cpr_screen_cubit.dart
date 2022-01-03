import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/common/failure.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';

part 'cpr_screen_state.dart';

class CprScreenCubit extends Cubit<CprScreenState> {
  final SensorsRepository _sensorsRepository;

  CprScreenCubit({required SensorsRepository sensorsRepository})
      : _sensorsRepository = sensorsRepository,
        super(CprInitial());

  void onScreenOpened() => _sensorsRepository.onCprSessionStart();

  void printRaw() => _sensorsRepository.logRaw();

  void onCprSessionEnd() => _sensorsRepository.onCprSessionEnd();

  void onScreenClosed() => _sensorsRepository.changeAccelerometerStreamState();
}
