// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'home/model/cart_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3497308603229900853),
      name: 'CartModel',
      lastPropertyId: const IdUid(5, 4647524466784501604),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3728499011406573678),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6576479412679270185),
            name: 'price',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2209277687382541823),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 414760900633383377),
            name: 'count',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4647524466784501604),
            name: 'itemID',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 3497308603229900853),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CartModel: EntityDefinition<CartModel>(
        model: _entities[0],
        toOneRelations: (CartModel object) => [],
        toManyRelations: (CartModel object) => {},
        getId: (CartModel object) => object.id,
        setId: (CartModel object, int id) {
          object.id = id;
        },
        objectToFB: (CartModel object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(1, object.price);
          fbb.addOffset(2, nameOffset);
          fbb.addInt64(3, object.count);
          fbb.addInt64(4, object.itemID);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CartModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              itemID:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0),
              price:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 6, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              count:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CartModel] entity fields to define ObjectBox queries.
class CartModel_ {
  /// see [CartModel.id]
  static final id = QueryIntegerProperty<CartModel>(_entities[0].properties[0]);

  /// see [CartModel.price]
  static final price =
      QueryDoubleProperty<CartModel>(_entities[0].properties[1]);

  /// see [CartModel.name]
  static final name =
      QueryStringProperty<CartModel>(_entities[0].properties[2]);

  /// see [CartModel.count]
  static final count =
      QueryIntegerProperty<CartModel>(_entities[0].properties[3]);

  /// see [CartModel.itemID]
  static final itemID =
      QueryIntegerProperty<CartModel>(_entities[0].properties[4]);
}
