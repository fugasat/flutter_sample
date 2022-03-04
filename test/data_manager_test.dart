import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sample/data_manager.dart';
import 'package:flutter_sample/data_model.dart';

void main() {
  test('get model name.', () {
    expect(DataModel(1).getName(), "Model 1");
    expect(DataModel(-1).getName(), "Model -1");
    expect(DataModel(100).getName(), "Model 100");
  });

  test('add model.', () {
    final manager = DataManager();
    expect(manager.models.length, 0);

    manager.add();
    expect(manager.models.length, 1);
    expect(manager.models.last.id, 0);

    manager.add();
    expect(manager.models.length, 2);
    expect(manager.models.last.id, 1);

    manager.setModels([DataModel(0), DataModel(10), DataModel(100)]);
    manager.add();
    expect(manager.models.length, 4);
    expect(manager.models.last.id, 101);
  });

  test('remove model.', () {
    final manager = DataManager();
    // Modelが格納されていない状態で削除を行なっても何も起きない
    manager.remove(DataModel(0));

    // Model登録
    manager.setModels([DataModel(0), DataModel(10), DataModel(100)]);

    // 指定Modelを削除
    manager.remove(manager.models[1]);
    expect(manager.models.length, 2);
    expect(manager.models[0].id, 0);
    expect(manager.models[1].id, 100);

    // 無効なModelを指定した時は何も起きない
    manager.remove(DataModel(20)); // 存在しないID
    expect(manager.models.length, 2);
    manager.remove(DataModel(100)); // IDは存在するが別インスタンス
    expect(manager.models.length, 2);

  });
}