class Assets {
  static const String garage = "assets/images/garage.jpg";
  static const String plumber = "assets/images/plumber.jpg";
  static const String supermarket = "assets/images/supermarket.jpg";
  static const String cleaner = "assets/images/cleaner.jpg";
  static const String acTechnician = "assets/images/acTechnician.jpg";
  static const String carpenter = "assets/images/carpenter.jpg";
  static const String mechanic = "assets/images/mechanic.jpg";
  static const String painter = "assets/images/painter.jpg";
  static const String worker = "assets/images/worker.jpg";
}

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
