class ProjectModel {
  final String name;
  final String description;
  final String githubUrl;
  final String category;
  final List<String> techStack;
  final int stars;

  ProjectModel({
    required this.name,
    required this.description,
    required this.githubUrl,
    required this.category,
    required this.techStack,
    required this.stars,
  });
}
