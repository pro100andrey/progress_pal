import '../service_locator.dart';

bool sessionIsValid() => getPocketBase.authStore.isValid;
