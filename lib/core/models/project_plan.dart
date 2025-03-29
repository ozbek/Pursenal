import 'package:pursenal/core/db/database.dart';

class ProjectPlan {
  final Project project;
  final List<ProjectPhoto> photos;

  ProjectPlan({
    required this.project,
    required this.photos,
  });
}
