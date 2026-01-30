import 'package:flutter/material.dart';

const List<WorkerCategory> workerCategories = [
  WorkerCategory(title: 'Plumber', icon: Icons.plumbing),
  WorkerCategory(title: 'Electrician', icon: Icons.electrical_services),
  WorkerCategory(title: 'Carpenter', icon: Icons.handyman),
  WorkerCategory(title: 'Painter', icon: Icons.format_paint),
  WorkerCategory(title: 'Mechanic', icon: Icons.car_repair),
  WorkerCategory(title: 'Cleaner', icon: Icons.cleaning_services),
  WorkerCategory(title: 'AC Technician', icon: Icons.ac_unit),
];

class WorkerCategory {
  final String title;
  final IconData icon;

  const WorkerCategory({required this.title, required this.icon});
}
