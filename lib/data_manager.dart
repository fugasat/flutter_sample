import 'package:flutter_sample/data_model.dart';

class DataManager {
  List<DataModel> models = [];

  void setModels(List<DataModel> newModels) {
    models = newModels;
  }

  void add() {
    int newModelId;
    if (models.isEmpty) {
      newModelId = 0;
    } else {
      newModelId = models.last.id + 1;
    }
    models.add(DataModel(newModelId));
  }

  void remove(DataModel removeModel) {
    int removeIndex = models.indexOf(removeModel);
    if (removeIndex >= 0) {
      models.removeAt(removeIndex);
    }
  }

}
