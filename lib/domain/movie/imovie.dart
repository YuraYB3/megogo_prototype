import '../ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String title;
  final String poster;

  IMovie({required this.poster, required this.title});
}
