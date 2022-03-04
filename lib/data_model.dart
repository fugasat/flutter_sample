import 'package:sprintf/sprintf.dart';

class DataModel {
  int id;
  DataModel(this.id);

  String getName() {
    return sprintf("Model %i", [id]);
  }
}
