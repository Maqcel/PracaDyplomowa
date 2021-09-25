import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RouteDefinition extends Equatable {
  final String name;
  final ValueKey<String> valueKey;

  const RouteDefinition({
    required this.name,
    required this.valueKey,
  });

  @override
  List<Object?> get props => [
        valueKey,
        name,
      ];
}
