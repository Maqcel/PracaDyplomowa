import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/domain/repositories/auth_repository.dart';
import 'package:praca_inz/domain/repositories/sensors_repository.dart';
import 'package:praca_inz/domain/repositories/user_repository.dart';

class AppRepositoryProviders {
  List<RepositoryProvider> get providers => [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<SensorsRepository>(
          create: (context) => SensorsRepository(
            accelerometerSensor:
                ServiceLocator.get<AccelerometerSensorService>(),
            gyroscopeSensor: ServiceLocator.get<GyroscopeSensorService>(),
          ),
        )
      ];
}
