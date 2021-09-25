enum BuildType {
  development,
  production,
}

abstract class BuildEnvironment {
  abstract final BuildType buildType;
}

class DevelopmentEnvironment implements BuildEnvironment {
  @override
  BuildType buildType = BuildType.development;
}

class ProductionEnvironment implements BuildEnvironment {
  @override
  BuildType buildType = BuildType.production;
}
