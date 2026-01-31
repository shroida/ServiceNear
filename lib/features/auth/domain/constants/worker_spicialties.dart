import 'package:flutter/material.dart';
import 'package:servicenear/common/core/images.dart';

const List<WorkerCategory> workerCategories = [
  WorkerCategory(title: 'Plumber', icon: Icons.plumbing, image: Assets.garage),
  WorkerCategory(
    title: 'Electrician',
    icon: Icons.electrical_services,
    image: Assets.acTechnician,
  ),
  WorkerCategory(
    title: 'Carpenter',
    icon: Icons.handyman,
    image: Assets.carpenter,
  ),
  WorkerCategory(
    title: 'Painter',
    icon: Icons.format_paint,
    image: Assets.painter,
  ),
  WorkerCategory(
    title: 'Mechanic',
    icon: Icons.car_repair,
    image: Assets.mechanic,
  ),
  WorkerCategory(
    title: 'Cleaner',
    icon: Icons.cleaning_services,
    image: Assets.cleaner,
  ),
  WorkerCategory(
    title: 'AC Technician',
    icon: Icons.ac_unit,
    image: Assets.acTechnician,
  ),
];

class WorkerCategory {
  final String title;
  final IconData icon;
  final String image;

  const WorkerCategory({
    required this.title,
    required this.icon,
    required this.image,
  });
}
