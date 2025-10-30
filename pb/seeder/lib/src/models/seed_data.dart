import 'failure.dart';
import 'result.dart';

final class SeedData {
  const SeedData._();
}

Result<SeedData, Failure> resolveSeedData({
  required String seedDataDir,
}) {
  const result = SeedData._();

  return Result.success(result);
}
