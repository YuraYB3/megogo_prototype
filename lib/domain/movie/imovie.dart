import '../ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String title;
  final String poster;
  final List<dynamic> trailer;
  IMovie({required this.poster, required this.title, required this.trailer});
}
