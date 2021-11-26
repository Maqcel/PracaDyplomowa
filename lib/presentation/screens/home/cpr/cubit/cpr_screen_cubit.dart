import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';

part 'cpr_screen_state.dart';

class CprScreenCubit extends Cubit<CprScreenState> {
  final SensorsRepository _sensorsRepository;

  CprScreenCubit({required SensorsRepository sensorsRepository})
      : _sensorsRepository = sensorsRepository,
        super(CprLoading());

  void onScreenOpened() =>
      _sensorsRepository.onAccelerometerDataStartPrinting();

  void onScreenClosed() => _sensorsRepository.changeAccelerometerStreamState();
}
