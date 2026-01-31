import 'package:servicenear/common/core/images.dart';

String getWorkerImage(String? specialty) {
  switch (specialty?.toLowerCase()) {
    case 'plumber':
      return Assets.plumber;
    case 'electrician':
      return Assets.worker;
    case 'carpenter':
      return Assets.carpenter;
    case 'painter':
      return Assets.painter;
    case 'mechanic':
      return Assets.mechanic;
    case 'cleaner':
      return Assets.cleaner;
    case 'ac technician':
      return Assets.acTechnician;
    case 'garage':
      return Assets.garage;
    case 'supermarket':
      return Assets.supermarket;
    default:
      return Assets.worker;
  }
}
