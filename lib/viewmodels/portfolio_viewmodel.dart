import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';

class PortfolioViewModel extends ChangeNotifier {
  final List<SkillModel> _skills = [
    SkillModel(name: 'Flutter & Dart', iconPath: 'assets/icons/flutter.svg', percentage: 0.95),
    SkillModel(name: 'Firebase', iconPath: 'assets/icons/firebase.svg', percentage: 0.85),
    SkillModel(name: 'REST APIs', iconPath: 'assets/icons/api.svg', percentage: 0.90),
    SkillModel(name: 'State Management', iconPath: 'assets/icons/state.svg', percentage: 0.90),
    SkillModel(name: 'GetX', iconPath: 'assets/icons/getx.png', percentage: 0.85),
    SkillModel(name: 'UI/UX Design', iconPath: 'assets/icons/design.svg', percentage: 0.80),
    SkillModel(name: 'Git & GitHub', iconPath: 'assets/icons/git.svg', percentage: 0.85),
  ];

  final List<ProjectModel> _projects = [
    ProjectModel(
      name: 'Finance App',
      description: 'A personal finance management app',
      githubUrl: 'https://github.com/UmairAhmad03003/finance-app',
      category: 'Apps',
      techStack: ['Flutter', 'Dart'],
      stars: 3,
    ),
    ProjectModel(
      name: 'E-Commerce App',
      description: 'A full-featured e-commerce mobile app',
      githubUrl: 'https://github.com/UmairAhmad03003/e-commarce-app',
      category: 'Apps',
      techStack: ['Flutter', 'Dart'],
      stars: 3,
    ),
    ProjectModel(
      name: 'Flutter Course',
      description: 'Course project files and Flutter learning resources',
      githubUrl: 'https://github.com/UmairAhmad03003/flutter-course',
      category: 'Teaching',
      techStack: ['Flutter', 'Dart'],
      stars: 3,
    ),
    ProjectModel(
      name: 'Firebase Topics',
      description: 'Covers various Firebase integration topics',
      githubUrl: 'https://github.com/UmairAhmad03003/firebase-topics',
      category: 'Apps',
      techStack: ['Flutter', 'Dart'],
      stars: 3,
    ),
  ];

  final List<ExperienceModel> _experiences = [
    ExperienceModel(
      role: 'Flutter Instructor',
      company: 'Infusible Coder',
      duration: 'Part of 2.5-year journey',
      description: 'Teaching Flutter development to students at Infusible Coder software house',
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Freelance / Projects',
      duration: '2.5 Years',
      description: 'Building production-level cross-platform mobile applications using Flutter, Dart, Firebase, REST APIs, and modern state management solutions',
    ),
  ];

  String _selectedProjectFilter = 'All';

  List<SkillModel> get skills => _skills;
  List<ExperienceModel> get experiences => _experiences;
  String get selectedProjectFilter => _selectedProjectFilter;

  List<ProjectModel> get filteredProjects {
    if (_selectedProjectFilter == 'All') {
      return _projects;
    }
    return _projects.where((project) => project.category == _selectedProjectFilter).toList();
  }

  void setFilter(String category) {
    _selectedProjectFilter = category;
    notifyListeners();
  }
}
