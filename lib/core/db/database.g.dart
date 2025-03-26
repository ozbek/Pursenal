// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccTypesTable extends AccTypes with TableInfo<$AccTypesTable, AccType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PrimaryType, int> primary =
      GeneratedColumn<int>('primary', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PrimaryType>($AccTypesTable.$converterprimary);
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _isEditableMeta =
      const VerificationMeta('isEditable');
  @override
  late final GeneratedColumn<bool> isEditable = GeneratedColumn<bool>(
      'is_editable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_editable" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, primary, addedDate, updateDate, isEditable];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'acc_types';
  @override
  VerificationContext validateIntegrity(Insertable<AccType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    if (data.containsKey('is_editable')) {
      context.handle(
          _isEditableMeta,
          isEditable.isAcceptableOrUnknown(
              data['is_editable']!, _isEditableMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      primary: $AccTypesTable.$converterprimary.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}primary'])!),
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
      isEditable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_editable'])!,
    );
  }

  @override
  $AccTypesTable createAlias(String alias) {
    return $AccTypesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PrimaryType, int, int> $converterprimary =
      const EnumIndexConverter<PrimaryType>(PrimaryType.values);
}

class AccType extends DataClass implements Insertable<AccType> {
  final int id;
  final String name;
  final PrimaryType primary;
  final DateTime addedDate;
  final DateTime updateDate;
  final bool isEditable;
  const AccType(
      {required this.id,
      required this.name,
      required this.primary,
      required this.addedDate,
      required this.updateDate,
      required this.isEditable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['primary'] =
          Variable<int>($AccTypesTable.$converterprimary.toSql(primary));
    }
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    map['is_editable'] = Variable<bool>(isEditable);
    return map;
  }

  AccTypesCompanion toCompanion(bool nullToAbsent) {
    return AccTypesCompanion(
      id: Value(id),
      name: Value(name),
      primary: Value(primary),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
      isEditable: Value(isEditable),
    );
  }

  factory AccType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primary: $AccTypesTable.$converterprimary
          .fromJson(serializer.fromJson<int>(json['primary'])),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
      isEditable: serializer.fromJson<bool>(json['isEditable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'primary': serializer
          .toJson<int>($AccTypesTable.$converterprimary.toJson(primary)),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
      'isEditable': serializer.toJson<bool>(isEditable),
    };
  }

  AccType copyWith(
          {int? id,
          String? name,
          PrimaryType? primary,
          DateTime? addedDate,
          DateTime? updateDate,
          bool? isEditable}) =>
      AccType(
        id: id ?? this.id,
        name: name ?? this.name,
        primary: primary ?? this.primary,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
        isEditable: isEditable ?? this.isEditable,
      );
  AccType copyWithCompanion(AccTypesCompanion data) {
    return AccType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primary: data.primary.present ? data.primary.value : this.primary,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
      isEditable:
          data.isEditable.present ? data.isEditable.value : this.isEditable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primary: $primary, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate, ')
          ..write('isEditable: $isEditable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, primary, addedDate, updateDate, isEditable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccType &&
          other.id == this.id &&
          other.name == this.name &&
          other.primary == this.primary &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate &&
          other.isEditable == this.isEditable);
}

class AccTypesCompanion extends UpdateCompanion<AccType> {
  final Value<int> id;
  final Value<String> name;
  final Value<PrimaryType> primary;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  final Value<bool> isEditable;
  const AccTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primary = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
    this.isEditable = const Value.absent(),
  });
  AccTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required PrimaryType primary,
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
    this.isEditable = const Value.absent(),
  })  : name = Value(name),
        primary = Value(primary);
  static Insertable<AccType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? primary,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
    Expression<bool>? isEditable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primary != null) 'primary': primary,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
      if (isEditable != null) 'is_editable': isEditable,
    });
  }

  AccTypesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<PrimaryType>? primary,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate,
      Value<bool>? isEditable}) {
    return AccTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primary: primary ?? this.primary,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
      isEditable: isEditable ?? this.isEditable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primary.present) {
      map['primary'] =
          Variable<int>($AccTypesTable.$converterprimary.toSql(primary.value));
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    if (isEditable.present) {
      map['is_editable'] = Variable<bool>(isEditable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primary: $primary, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate, ')
          ..write('isEditable: $isEditable')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
      'alias', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 512),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _zipMeta = const VerificationMeta('zip');
  @override
  late final GeneratedColumn<String> zip = GeneratedColumn<String>(
      'zip', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 9),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 15),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _tinMeta = const VerificationMeta('tin');
  @override
  late final GeneratedColumn<String> tin = GeneratedColumn<String>(
      'tin', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 24),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _isSelectedMeta =
      const VerificationMeta('isSelected');
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
      'is_selected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_selected" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> currency =
      GeneratedColumn<int>('currency', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Currency>($ProfilesTable.$convertercurrency);
  static const VerificationMeta _globalIDMeta =
      const VerificationMeta('globalID');
  @override
  late final GeneratedColumn<String> globalID = GeneratedColumn<String>(
      'global_i_d', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _isLocalMeta =
      const VerificationMeta('isLocal');
  @override
  late final GeneratedColumn<bool> isLocal = GeneratedColumn<bool>(
      'is_local', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_local" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        alias,
        address,
        zip,
        email,
        phone,
        tin,
        isSelected,
        currency,
        globalID,
        isLocal,
        addedDate,
        updateDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
          _aliasMeta, alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('zip')) {
      context.handle(
          _zipMeta, zip.isAcceptableOrUnknown(data['zip']!, _zipMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('tin')) {
      context.handle(
          _tinMeta, tin.isAcceptableOrUnknown(data['tin']!, _tinMeta));
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected']!, _isSelectedMeta));
    }
    if (data.containsKey('global_i_d')) {
      context.handle(_globalIDMeta,
          globalID.isAcceptableOrUnknown(data['global_i_d']!, _globalIDMeta));
    }
    if (data.containsKey('is_local')) {
      context.handle(_isLocalMeta,
          isLocal.isAcceptableOrUnknown(data['is_local']!, _isLocalMeta));
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      alias: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alias']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      zip: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      tin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tin']),
      isSelected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_selected'])!,
      currency: $ProfilesTable.$convertercurrency.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}currency'])!),
      globalID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}global_i_d']),
      isLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_local'])!,
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Currency, int, int> $convertercurrency =
      const EnumIndexConverter<Currency>(Currency.values);
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String name;
  final String? alias;
  final String? address;
  final String? zip;
  final String? email;
  final String? phone;
  final String? tin;
  final bool isSelected;
  final Currency currency;
  final String? globalID;
  final bool isLocal;
  final DateTime addedDate;
  final DateTime updateDate;
  const Profile(
      {required this.id,
      required this.name,
      this.alias,
      this.address,
      this.zip,
      this.email,
      this.phone,
      this.tin,
      required this.isSelected,
      required this.currency,
      this.globalID,
      required this.isLocal,
      required this.addedDate,
      required this.updateDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || alias != null) {
      map['alias'] = Variable<String>(alias);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || zip != null) {
      map['zip'] = Variable<String>(zip);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || tin != null) {
      map['tin'] = Variable<String>(tin);
    }
    map['is_selected'] = Variable<bool>(isSelected);
    {
      map['currency'] =
          Variable<int>($ProfilesTable.$convertercurrency.toSql(currency));
    }
    if (!nullToAbsent || globalID != null) {
      map['global_i_d'] = Variable<String>(globalID);
    }
    map['is_local'] = Variable<bool>(isLocal);
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      name: Value(name),
      alias:
          alias == null && nullToAbsent ? const Value.absent() : Value(alias),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      zip: zip == null && nullToAbsent ? const Value.absent() : Value(zip),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      tin: tin == null && nullToAbsent ? const Value.absent() : Value(tin),
      isSelected: Value(isSelected),
      currency: Value(currency),
      globalID: globalID == null && nullToAbsent
          ? const Value.absent()
          : Value(globalID),
      isLocal: Value(isLocal),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      alias: serializer.fromJson<String?>(json['alias']),
      address: serializer.fromJson<String?>(json['address']),
      zip: serializer.fromJson<String?>(json['zip']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      tin: serializer.fromJson<String?>(json['tin']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      currency: $ProfilesTable.$convertercurrency
          .fromJson(serializer.fromJson<int>(json['currency'])),
      globalID: serializer.fromJson<String?>(json['globalID']),
      isLocal: serializer.fromJson<bool>(json['isLocal']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'alias': serializer.toJson<String?>(alias),
      'address': serializer.toJson<String?>(address),
      'zip': serializer.toJson<String?>(zip),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'tin': serializer.toJson<String?>(tin),
      'isSelected': serializer.toJson<bool>(isSelected),
      'currency': serializer
          .toJson<int>($ProfilesTable.$convertercurrency.toJson(currency)),
      'globalID': serializer.toJson<String?>(globalID),
      'isLocal': serializer.toJson<bool>(isLocal),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
    };
  }

  Profile copyWith(
          {int? id,
          String? name,
          Value<String?> alias = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> zip = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> tin = const Value.absent(),
          bool? isSelected,
          Currency? currency,
          Value<String?> globalID = const Value.absent(),
          bool? isLocal,
          DateTime? addedDate,
          DateTime? updateDate}) =>
      Profile(
        id: id ?? this.id,
        name: name ?? this.name,
        alias: alias.present ? alias.value : this.alias,
        address: address.present ? address.value : this.address,
        zip: zip.present ? zip.value : this.zip,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        tin: tin.present ? tin.value : this.tin,
        isSelected: isSelected ?? this.isSelected,
        currency: currency ?? this.currency,
        globalID: globalID.present ? globalID.value : this.globalID,
        isLocal: isLocal ?? this.isLocal,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      alias: data.alias.present ? data.alias.value : this.alias,
      address: data.address.present ? data.address.value : this.address,
      zip: data.zip.present ? data.zip.value : this.zip,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      tin: data.tin.present ? data.tin.value : this.tin,
      isSelected:
          data.isSelected.present ? data.isSelected.value : this.isSelected,
      currency: data.currency.present ? data.currency.value : this.currency,
      globalID: data.globalID.present ? data.globalID.value : this.globalID,
      isLocal: data.isLocal.present ? data.isLocal.value : this.isLocal,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('alias: $alias, ')
          ..write('address: $address, ')
          ..write('zip: $zip, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('tin: $tin, ')
          ..write('isSelected: $isSelected, ')
          ..write('currency: $currency, ')
          ..write('globalID: $globalID, ')
          ..write('isLocal: $isLocal, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, alias, address, zip, email, phone,
      tin, isSelected, currency, globalID, isLocal, addedDate, updateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.name == this.name &&
          other.alias == this.alias &&
          other.address == this.address &&
          other.zip == this.zip &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.tin == this.tin &&
          other.isSelected == this.isSelected &&
          other.currency == this.currency &&
          other.globalID == this.globalID &&
          other.isLocal == this.isLocal &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> alias;
  final Value<String?> address;
  final Value<String?> zip;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> tin;
  final Value<bool> isSelected;
  final Value<Currency> currency;
  final Value<String?> globalID;
  final Value<bool> isLocal;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.alias = const Value.absent(),
    this.address = const Value.absent(),
    this.zip = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.tin = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.currency = const Value.absent(),
    this.globalID = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.alias = const Value.absent(),
    this.address = const Value.absent(),
    this.zip = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.tin = const Value.absent(),
    this.isSelected = const Value.absent(),
    required Currency currency,
    this.globalID = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  })  : name = Value(name),
        currency = Value(currency);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? alias,
    Expression<String>? address,
    Expression<String>? zip,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? tin,
    Expression<bool>? isSelected,
    Expression<int>? currency,
    Expression<String>? globalID,
    Expression<bool>? isLocal,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (alias != null) 'alias': alias,
      if (address != null) 'address': address,
      if (zip != null) 'zip': zip,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (tin != null) 'tin': tin,
      if (isSelected != null) 'is_selected': isSelected,
      if (currency != null) 'currency': currency,
      if (globalID != null) 'global_i_d': globalID,
      if (isLocal != null) 'is_local': isLocal,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
    });
  }

  ProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? alias,
      Value<String?>? address,
      Value<String?>? zip,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? tin,
      Value<bool>? isSelected,
      Value<Currency>? currency,
      Value<String?>? globalID,
      Value<bool>? isLocal,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      address: address ?? this.address,
      zip: zip ?? this.zip,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      tin: tin ?? this.tin,
      isSelected: isSelected ?? this.isSelected,
      currency: currency ?? this.currency,
      globalID: globalID ?? this.globalID,
      isLocal: isLocal ?? this.isLocal,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (zip.present) {
      map['zip'] = Variable<String>(zip.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (tin.present) {
      map['tin'] = Variable<String>(tin.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(
          $ProfilesTable.$convertercurrency.toSql(currency.value));
    }
    if (globalID.present) {
      map['global_i_d'] = Variable<String>(globalID.value);
    }
    if (isLocal.present) {
      map['is_local'] = Variable<bool>(isLocal.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('alias: $alias, ')
          ..write('address: $address, ')
          ..write('zip: $zip, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('tin: $tin, ')
          ..write('isSelected: $isSelected, ')
          ..write('currency: $currency, ')
          ..write('globalID: $globalID, ')
          ..write('isLocal: $isLocal, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _openBalMeta =
      const VerificationMeta('openBal');
  @override
  late final GeneratedColumn<int> openBal = GeneratedColumn<int>(
      'open_bal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _openDateMeta =
      const VerificationMeta('openDate');
  @override
  late final GeneratedColumn<DateTime> openDate = GeneratedColumn<DateTime>(
      'open_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _accTypeMeta =
      const VerificationMeta('accType');
  @override
  late final GeneratedColumn<int> accType = GeneratedColumn<int>(
      'acc_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES acc_types (id) ON DELETE CASCADE'));
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _isEditableMeta =
      const VerificationMeta('isEditable');
  @override
  late final GeneratedColumn<bool> isEditable = GeneratedColumn<bool>(
      'is_editable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_editable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _profileMeta =
      const VerificationMeta('profile');
  @override
  late final GeneratedColumn<int> profile = GeneratedColumn<int>(
      'profile', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES profiles (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        openBal,
        openDate,
        accType,
        addedDate,
        updateDate,
        isEditable,
        profile
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('open_bal')) {
      context.handle(_openBalMeta,
          openBal.isAcceptableOrUnknown(data['open_bal']!, _openBalMeta));
    }
    if (data.containsKey('open_date')) {
      context.handle(_openDateMeta,
          openDate.isAcceptableOrUnknown(data['open_date']!, _openDateMeta));
    }
    if (data.containsKey('acc_type')) {
      context.handle(_accTypeMeta,
          accType.isAcceptableOrUnknown(data['acc_type']!, _accTypeMeta));
    } else if (isInserting) {
      context.missing(_accTypeMeta);
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    if (data.containsKey('is_editable')) {
      context.handle(
          _isEditableMeta,
          isEditable.isAcceptableOrUnknown(
              data['is_editable']!, _isEditableMeta));
    }
    if (data.containsKey('profile')) {
      context.handle(_profileMeta,
          profile.isAcceptableOrUnknown(data['profile']!, _profileMeta));
    } else if (isInserting) {
      context.missing(_profileMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      openBal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}open_bal'])!,
      openDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}open_date'])!,
      accType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acc_type'])!,
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
      isEditable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_editable'])!,
      profile: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String name;
  final int openBal;
  final DateTime openDate;
  final int accType;
  final DateTime addedDate;
  final DateTime updateDate;
  final bool isEditable;
  final int profile;
  const Account(
      {required this.id,
      required this.name,
      required this.openBal,
      required this.openDate,
      required this.accType,
      required this.addedDate,
      required this.updateDate,
      required this.isEditable,
      required this.profile});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['open_bal'] = Variable<int>(openBal);
    map['open_date'] = Variable<DateTime>(openDate);
    map['acc_type'] = Variable<int>(accType);
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    map['is_editable'] = Variable<bool>(isEditable);
    map['profile'] = Variable<int>(profile);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      openBal: Value(openBal),
      openDate: Value(openDate),
      accType: Value(accType),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
      isEditable: Value(isEditable),
      profile: Value(profile),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      openBal: serializer.fromJson<int>(json['openBal']),
      openDate: serializer.fromJson<DateTime>(json['openDate']),
      accType: serializer.fromJson<int>(json['accType']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
      isEditable: serializer.fromJson<bool>(json['isEditable']),
      profile: serializer.fromJson<int>(json['profile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'openBal': serializer.toJson<int>(openBal),
      'openDate': serializer.toJson<DateTime>(openDate),
      'accType': serializer.toJson<int>(accType),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
      'isEditable': serializer.toJson<bool>(isEditable),
      'profile': serializer.toJson<int>(profile),
    };
  }

  Account copyWith(
          {int? id,
          String? name,
          int? openBal,
          DateTime? openDate,
          int? accType,
          DateTime? addedDate,
          DateTime? updateDate,
          bool? isEditable,
          int? profile}) =>
      Account(
        id: id ?? this.id,
        name: name ?? this.name,
        openBal: openBal ?? this.openBal,
        openDate: openDate ?? this.openDate,
        accType: accType ?? this.accType,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
        isEditable: isEditable ?? this.isEditable,
        profile: profile ?? this.profile,
      );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      openBal: data.openBal.present ? data.openBal.value : this.openBal,
      openDate: data.openDate.present ? data.openDate.value : this.openDate,
      accType: data.accType.present ? data.accType.value : this.accType,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
      isEditable:
          data.isEditable.present ? data.isEditable.value : this.isEditable,
      profile: data.profile.present ? data.profile.value : this.profile,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('openBal: $openBal, ')
          ..write('openDate: $openDate, ')
          ..write('accType: $accType, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate, ')
          ..write('isEditable: $isEditable, ')
          ..write('profile: $profile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, openBal, openDate, accType,
      addedDate, updateDate, isEditable, profile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.name == this.name &&
          other.openBal == this.openBal &&
          other.openDate == this.openDate &&
          other.accType == this.accType &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate &&
          other.isEditable == this.isEditable &&
          other.profile == this.profile);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> openBal;
  final Value<DateTime> openDate;
  final Value<int> accType;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  final Value<bool> isEditable;
  final Value<int> profile;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.openBal = const Value.absent(),
    this.openDate = const Value.absent(),
    this.accType = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
    this.isEditable = const Value.absent(),
    this.profile = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.openBal = const Value.absent(),
    this.openDate = const Value.absent(),
    required int accType,
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
    this.isEditable = const Value.absent(),
    required int profile,
  })  : name = Value(name),
        accType = Value(accType),
        profile = Value(profile);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? openBal,
    Expression<DateTime>? openDate,
    Expression<int>? accType,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
    Expression<bool>? isEditable,
    Expression<int>? profile,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (openBal != null) 'open_bal': openBal,
      if (openDate != null) 'open_date': openDate,
      if (accType != null) 'acc_type': accType,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
      if (isEditable != null) 'is_editable': isEditable,
      if (profile != null) 'profile': profile,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? openBal,
      Value<DateTime>? openDate,
      Value<int>? accType,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate,
      Value<bool>? isEditable,
      Value<int>? profile}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      openBal: openBal ?? this.openBal,
      openDate: openDate ?? this.openDate,
      accType: accType ?? this.accType,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
      isEditable: isEditable ?? this.isEditable,
      profile: profile ?? this.profile,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (openBal.present) {
      map['open_bal'] = Variable<int>(openBal.value);
    }
    if (openDate.present) {
      map['open_date'] = Variable<DateTime>(openDate.value);
    }
    if (accType.present) {
      map['acc_type'] = Variable<int>(accType.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    if (isEditable.present) {
      map['is_editable'] = Variable<bool>(isEditable.value);
    }
    if (profile.present) {
      map['profile'] = Variable<int>(profile.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('openBal: $openBal, ')
          ..write('openDate: $openDate, ')
          ..write('accType: $accType, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate, ')
          ..write('isEditable: $isEditable, ')
          ..write('profile: $profile')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vchDateMeta =
      const VerificationMeta('vchDate');
  @override
  late final GeneratedColumn<DateTime> vchDate = GeneratedColumn<DateTime>(
      'vch_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _narrMeta = const VerificationMeta('narr');
  @override
  late final GeneratedColumn<String> narr = GeneratedColumn<String>(
      'narr', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _refNoMeta = const VerificationMeta('refNo');
  @override
  late final GeneratedColumn<String> refNo = GeneratedColumn<String>(
      'ref_no', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<VoucherType, int> vchType =
      GeneratedColumn<int>('vch_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<VoucherType>($TransactionsTable.$convertervchType);
  static const VerificationMeta _drMeta = const VerificationMeta('dr');
  @override
  late final GeneratedColumn<int> dr = GeneratedColumn<int>(
      'dr', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _crMeta = const VerificationMeta('cr');
  @override
  late final GeneratedColumn<int> cr = GeneratedColumn<int>(
      'cr', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _profileMeta =
      const VerificationMeta('profile');
  @override
  late final GeneratedColumn<int> profile = GeneratedColumn<int>(
      'profile', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES profiles (id) ON DELETE CASCADE'));
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vchDate,
        narr,
        refNo,
        vchType,
        dr,
        cr,
        amount,
        profile,
        addedDate,
        updateDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vch_date')) {
      context.handle(_vchDateMeta,
          vchDate.isAcceptableOrUnknown(data['vch_date']!, _vchDateMeta));
    } else if (isInserting) {
      context.missing(_vchDateMeta);
    }
    if (data.containsKey('narr')) {
      context.handle(
          _narrMeta, narr.isAcceptableOrUnknown(data['narr']!, _narrMeta));
    } else if (isInserting) {
      context.missing(_narrMeta);
    }
    if (data.containsKey('ref_no')) {
      context.handle(
          _refNoMeta, refNo.isAcceptableOrUnknown(data['ref_no']!, _refNoMeta));
    } else if (isInserting) {
      context.missing(_refNoMeta);
    }
    if (data.containsKey('dr')) {
      context.handle(_drMeta, dr.isAcceptableOrUnknown(data['dr']!, _drMeta));
    } else if (isInserting) {
      context.missing(_drMeta);
    }
    if (data.containsKey('cr')) {
      context.handle(_crMeta, cr.isAcceptableOrUnknown(data['cr']!, _crMeta));
    } else if (isInserting) {
      context.missing(_crMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('profile')) {
      context.handle(_profileMeta,
          profile.isAcceptableOrUnknown(data['profile']!, _profileMeta));
    } else if (isInserting) {
      context.missing(_profileMeta);
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vchDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}vch_date'])!,
      narr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}narr'])!,
      refNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ref_no'])!,
      vchType: $TransactionsTable.$convertervchType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vch_type'])!),
      dr: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dr'])!,
      cr: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cr'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      profile: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile'])!,
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VoucherType, int, int> $convertervchType =
      const EnumIndexConverter<VoucherType>(VoucherType.values);
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final DateTime vchDate;
  final String narr;
  final String refNo;
  final VoucherType vchType;
  final int dr;
  final int cr;
  final int amount;
  final int profile;
  final DateTime addedDate;
  final DateTime updateDate;
  const Transaction(
      {required this.id,
      required this.vchDate,
      required this.narr,
      required this.refNo,
      required this.vchType,
      required this.dr,
      required this.cr,
      required this.amount,
      required this.profile,
      required this.addedDate,
      required this.updateDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vch_date'] = Variable<DateTime>(vchDate);
    map['narr'] = Variable<String>(narr);
    map['ref_no'] = Variable<String>(refNo);
    {
      map['vch_type'] =
          Variable<int>($TransactionsTable.$convertervchType.toSql(vchType));
    }
    map['dr'] = Variable<int>(dr);
    map['cr'] = Variable<int>(cr);
    map['amount'] = Variable<int>(amount);
    map['profile'] = Variable<int>(profile);
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      vchDate: Value(vchDate),
      narr: Value(narr),
      refNo: Value(refNo),
      vchType: Value(vchType),
      dr: Value(dr),
      cr: Value(cr),
      amount: Value(amount),
      profile: Value(profile),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      vchDate: serializer.fromJson<DateTime>(json['vchDate']),
      narr: serializer.fromJson<String>(json['narr']),
      refNo: serializer.fromJson<String>(json['refNo']),
      vchType: $TransactionsTable.$convertervchType
          .fromJson(serializer.fromJson<int>(json['vchType'])),
      dr: serializer.fromJson<int>(json['dr']),
      cr: serializer.fromJson<int>(json['cr']),
      amount: serializer.fromJson<int>(json['amount']),
      profile: serializer.fromJson<int>(json['profile']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vchDate': serializer.toJson<DateTime>(vchDate),
      'narr': serializer.toJson<String>(narr),
      'refNo': serializer.toJson<String>(refNo),
      'vchType': serializer
          .toJson<int>($TransactionsTable.$convertervchType.toJson(vchType)),
      'dr': serializer.toJson<int>(dr),
      'cr': serializer.toJson<int>(cr),
      'amount': serializer.toJson<int>(amount),
      'profile': serializer.toJson<int>(profile),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
    };
  }

  Transaction copyWith(
          {int? id,
          DateTime? vchDate,
          String? narr,
          String? refNo,
          VoucherType? vchType,
          int? dr,
          int? cr,
          int? amount,
          int? profile,
          DateTime? addedDate,
          DateTime? updateDate}) =>
      Transaction(
        id: id ?? this.id,
        vchDate: vchDate ?? this.vchDate,
        narr: narr ?? this.narr,
        refNo: refNo ?? this.refNo,
        vchType: vchType ?? this.vchType,
        dr: dr ?? this.dr,
        cr: cr ?? this.cr,
        amount: amount ?? this.amount,
        profile: profile ?? this.profile,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      vchDate: data.vchDate.present ? data.vchDate.value : this.vchDate,
      narr: data.narr.present ? data.narr.value : this.narr,
      refNo: data.refNo.present ? data.refNo.value : this.refNo,
      vchType: data.vchType.present ? data.vchType.value : this.vchType,
      dr: data.dr.present ? data.dr.value : this.dr,
      cr: data.cr.present ? data.cr.value : this.cr,
      amount: data.amount.present ? data.amount.value : this.amount,
      profile: data.profile.present ? data.profile.value : this.profile,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('vchDate: $vchDate, ')
          ..write('narr: $narr, ')
          ..write('refNo: $refNo, ')
          ..write('vchType: $vchType, ')
          ..write('dr: $dr, ')
          ..write('cr: $cr, ')
          ..write('amount: $amount, ')
          ..write('profile: $profile, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, vchDate, narr, refNo, vchType, dr, cr,
      amount, profile, addedDate, updateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.vchDate == this.vchDate &&
          other.narr == this.narr &&
          other.refNo == this.refNo &&
          other.vchType == this.vchType &&
          other.dr == this.dr &&
          other.cr == this.cr &&
          other.amount == this.amount &&
          other.profile == this.profile &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<DateTime> vchDate;
  final Value<String> narr;
  final Value<String> refNo;
  final Value<VoucherType> vchType;
  final Value<int> dr;
  final Value<int> cr;
  final Value<int> amount;
  final Value<int> profile;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.vchDate = const Value.absent(),
    this.narr = const Value.absent(),
    this.refNo = const Value.absent(),
    this.vchType = const Value.absent(),
    this.dr = const Value.absent(),
    this.cr = const Value.absent(),
    this.amount = const Value.absent(),
    this.profile = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime vchDate,
    required String narr,
    required String refNo,
    required VoucherType vchType,
    required int dr,
    required int cr,
    this.amount = const Value.absent(),
    required int profile,
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  })  : vchDate = Value(vchDate),
        narr = Value(narr),
        refNo = Value(refNo),
        vchType = Value(vchType),
        dr = Value(dr),
        cr = Value(cr),
        profile = Value(profile);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<DateTime>? vchDate,
    Expression<String>? narr,
    Expression<String>? refNo,
    Expression<int>? vchType,
    Expression<int>? dr,
    Expression<int>? cr,
    Expression<int>? amount,
    Expression<int>? profile,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vchDate != null) 'vch_date': vchDate,
      if (narr != null) 'narr': narr,
      if (refNo != null) 'ref_no': refNo,
      if (vchType != null) 'vch_type': vchType,
      if (dr != null) 'dr': dr,
      if (cr != null) 'cr': cr,
      if (amount != null) 'amount': amount,
      if (profile != null) 'profile': profile,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? vchDate,
      Value<String>? narr,
      Value<String>? refNo,
      Value<VoucherType>? vchType,
      Value<int>? dr,
      Value<int>? cr,
      Value<int>? amount,
      Value<int>? profile,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      vchDate: vchDate ?? this.vchDate,
      narr: narr ?? this.narr,
      refNo: refNo ?? this.refNo,
      vchType: vchType ?? this.vchType,
      dr: dr ?? this.dr,
      cr: cr ?? this.cr,
      amount: amount ?? this.amount,
      profile: profile ?? this.profile,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vchDate.present) {
      map['vch_date'] = Variable<DateTime>(vchDate.value);
    }
    if (narr.present) {
      map['narr'] = Variable<String>(narr.value);
    }
    if (refNo.present) {
      map['ref_no'] = Variable<String>(refNo.value);
    }
    if (vchType.present) {
      map['vch_type'] = Variable<int>(
          $TransactionsTable.$convertervchType.toSql(vchType.value));
    }
    if (dr.present) {
      map['dr'] = Variable<int>(dr.value);
    }
    if (cr.present) {
      map['cr'] = Variable<int>(cr.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (profile.present) {
      map['profile'] = Variable<int>(profile.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('vchDate: $vchDate, ')
          ..write('narr: $narr, ')
          ..write('refNo: $refNo, ')
          ..write('vchType: $vchType, ')
          ..write('dr: $dr, ')
          ..write('cr: $cr, ')
          ..write('amount: $amount, ')
          ..write('profile: $profile, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _deviceIDMeta =
      const VerificationMeta('deviceID');
  @override
  late final GeneratedColumn<String> deviceID = GeneratedColumn<String>(
      'device_i_d', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, deviceID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('device_i_d')) {
      context.handle(_deviceIDMeta,
          deviceID.isAcceptableOrUnknown(data['device_i_d']!, _deviceIDMeta));
    } else if (isInserting) {
      context.missing(_deviceIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      deviceID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_i_d'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String deviceID;
  const User({required this.id, required this.name, required this.deviceID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['device_i_d'] = Variable<String>(deviceID);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      deviceID: Value(deviceID),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      deviceID: serializer.fromJson<String>(json['deviceID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'deviceID': serializer.toJson<String>(deviceID),
    };
  }

  User copyWith({int? id, String? name, String? deviceID}) => User(
        id: id ?? this.id,
        name: name ?? this.name,
        deviceID: deviceID ?? this.deviceID,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      deviceID: data.deviceID.present ? data.deviceID.value : this.deviceID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, deviceID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.deviceID == this.deviceID);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> deviceID;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.deviceID = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String deviceID,
  })  : name = Value(name),
        deviceID = Value(deviceID);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? deviceID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (deviceID != null) 'device_i_d': deviceID,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? deviceID}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      deviceID: deviceID ?? this.deviceID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (deviceID.present) {
      map['device_i_d'] = Variable<String>(deviceID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }
}

class $BanksTable extends Banks with TableInfo<$BanksTable, Bank> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BanksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _holderNameMeta =
      const VerificationMeta('holderName');
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
      'holder_name', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _institutionMeta =
      const VerificationMeta('institution');
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
      'institution', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _branchMeta = const VerificationMeta('branch');
  @override
  late final GeneratedColumn<String> branch = GeneratedColumn<String>(
      'branch', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _branchCodeMeta =
      const VerificationMeta('branchCode');
  @override
  late final GeneratedColumn<String> branchCode = GeneratedColumn<String>(
      'branch_code', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _accountNoMeta =
      const VerificationMeta('accountNo');
  @override
  late final GeneratedColumn<String> accountNo = GeneratedColumn<String>(
      'account_no', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, account, holderName, institution, branch, branchCode, accountNo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banks';
  @override
  VerificationContext validateIntegrity(Insertable<Bank> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('holder_name')) {
      context.handle(
          _holderNameMeta,
          holderName.isAcceptableOrUnknown(
              data['holder_name']!, _holderNameMeta));
    }
    if (data.containsKey('institution')) {
      context.handle(
          _institutionMeta,
          institution.isAcceptableOrUnknown(
              data['institution']!, _institutionMeta));
    }
    if (data.containsKey('branch')) {
      context.handle(_branchMeta,
          branch.isAcceptableOrUnknown(data['branch']!, _branchMeta));
    }
    if (data.containsKey('branch_code')) {
      context.handle(
          _branchCodeMeta,
          branchCode.isAcceptableOrUnknown(
              data['branch_code']!, _branchCodeMeta));
    }
    if (data.containsKey('account_no')) {
      context.handle(_accountNoMeta,
          accountNo.isAcceptableOrUnknown(data['account_no']!, _accountNoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bank map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bank(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      holderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}holder_name']),
      institution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}institution']),
      branch: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch']),
      branchCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_code']),
      accountNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_no']),
    );
  }

  @override
  $BanksTable createAlias(String alias) {
    return $BanksTable(attachedDatabase, alias);
  }
}

class Bank extends DataClass implements Insertable<Bank> {
  final int id;
  final int account;
  final String? holderName;
  final String? institution;
  final String? branch;
  final String? branchCode;
  final String? accountNo;
  const Bank(
      {required this.id,
      required this.account,
      this.holderName,
      this.institution,
      this.branch,
      this.branchCode,
      this.accountNo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    if (!nullToAbsent || holderName != null) {
      map['holder_name'] = Variable<String>(holderName);
    }
    if (!nullToAbsent || institution != null) {
      map['institution'] = Variable<String>(institution);
    }
    if (!nullToAbsent || branch != null) {
      map['branch'] = Variable<String>(branch);
    }
    if (!nullToAbsent || branchCode != null) {
      map['branch_code'] = Variable<String>(branchCode);
    }
    if (!nullToAbsent || accountNo != null) {
      map['account_no'] = Variable<String>(accountNo);
    }
    return map;
  }

  BanksCompanion toCompanion(bool nullToAbsent) {
    return BanksCompanion(
      id: Value(id),
      account: Value(account),
      holderName: holderName == null && nullToAbsent
          ? const Value.absent()
          : Value(holderName),
      institution: institution == null && nullToAbsent
          ? const Value.absent()
          : Value(institution),
      branch:
          branch == null && nullToAbsent ? const Value.absent() : Value(branch),
      branchCode: branchCode == null && nullToAbsent
          ? const Value.absent()
          : Value(branchCode),
      accountNo: accountNo == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNo),
    );
  }

  factory Bank.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bank(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      holderName: serializer.fromJson<String?>(json['holderName']),
      institution: serializer.fromJson<String?>(json['institution']),
      branch: serializer.fromJson<String?>(json['branch']),
      branchCode: serializer.fromJson<String?>(json['branchCode']),
      accountNo: serializer.fromJson<String?>(json['accountNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'holderName': serializer.toJson<String?>(holderName),
      'institution': serializer.toJson<String?>(institution),
      'branch': serializer.toJson<String?>(branch),
      'branchCode': serializer.toJson<String?>(branchCode),
      'accountNo': serializer.toJson<String?>(accountNo),
    };
  }

  Bank copyWith(
          {int? id,
          int? account,
          Value<String?> holderName = const Value.absent(),
          Value<String?> institution = const Value.absent(),
          Value<String?> branch = const Value.absent(),
          Value<String?> branchCode = const Value.absent(),
          Value<String?> accountNo = const Value.absent()}) =>
      Bank(
        id: id ?? this.id,
        account: account ?? this.account,
        holderName: holderName.present ? holderName.value : this.holderName,
        institution: institution.present ? institution.value : this.institution,
        branch: branch.present ? branch.value : this.branch,
        branchCode: branchCode.present ? branchCode.value : this.branchCode,
        accountNo: accountNo.present ? accountNo.value : this.accountNo,
      );
  Bank copyWithCompanion(BanksCompanion data) {
    return Bank(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      holderName:
          data.holderName.present ? data.holderName.value : this.holderName,
      institution:
          data.institution.present ? data.institution.value : this.institution,
      branch: data.branch.present ? data.branch.value : this.branch,
      branchCode:
          data.branchCode.present ? data.branchCode.value : this.branchCode,
      accountNo: data.accountNo.present ? data.accountNo.value : this.accountNo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bank(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('holderName: $holderName, ')
          ..write('institution: $institution, ')
          ..write('branch: $branch, ')
          ..write('branchCode: $branchCode, ')
          ..write('accountNo: $accountNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, account, holderName, institution, branch, branchCode, accountNo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bank &&
          other.id == this.id &&
          other.account == this.account &&
          other.holderName == this.holderName &&
          other.institution == this.institution &&
          other.branch == this.branch &&
          other.branchCode == this.branchCode &&
          other.accountNo == this.accountNo);
}

class BanksCompanion extends UpdateCompanion<Bank> {
  final Value<int> id;
  final Value<int> account;
  final Value<String?> holderName;
  final Value<String?> institution;
  final Value<String?> branch;
  final Value<String?> branchCode;
  final Value<String?> accountNo;
  const BanksCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.holderName = const Value.absent(),
    this.institution = const Value.absent(),
    this.branch = const Value.absent(),
    this.branchCode = const Value.absent(),
    this.accountNo = const Value.absent(),
  });
  BanksCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    this.holderName = const Value.absent(),
    this.institution = const Value.absent(),
    this.branch = const Value.absent(),
    this.branchCode = const Value.absent(),
    this.accountNo = const Value.absent(),
  }) : account = Value(account);
  static Insertable<Bank> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<String>? holderName,
    Expression<String>? institution,
    Expression<String>? branch,
    Expression<String>? branchCode,
    Expression<String>? accountNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (holderName != null) 'holder_name': holderName,
      if (institution != null) 'institution': institution,
      if (branch != null) 'branch': branch,
      if (branchCode != null) 'branch_code': branchCode,
      if (accountNo != null) 'account_no': accountNo,
    });
  }

  BanksCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<String?>? holderName,
      Value<String?>? institution,
      Value<String?>? branch,
      Value<String?>? branchCode,
      Value<String?>? accountNo}) {
    return BanksCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      holderName: holderName ?? this.holderName,
      institution: institution ?? this.institution,
      branch: branch ?? this.branch,
      branchCode: branchCode ?? this.branchCode,
      accountNo: accountNo ?? this.accountNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (branch.present) {
      map['branch'] = Variable<String>(branch.value);
    }
    if (branchCode.present) {
      map['branch_code'] = Variable<String>(branchCode.value);
    }
    if (accountNo.present) {
      map['account_no'] = Variable<String>(accountNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BanksCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('holderName: $holderName, ')
          ..write('institution: $institution, ')
          ..write('branch: $branch, ')
          ..write('branchCode: $branchCode, ')
          ..write('accountNo: $accountNo')
          ..write(')'))
        .toString();
  }
}

class $WalletsTable extends Wallets with TableInfo<$WalletsTable, Wallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [id, account, addedDate, updateDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallets';
  @override
  VerificationContext validateIntegrity(Insertable<Wallet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wallet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
    );
  }

  @override
  $WalletsTable createAlias(String alias) {
    return $WalletsTable(attachedDatabase, alias);
  }
}

class Wallet extends DataClass implements Insertable<Wallet> {
  final int id;
  final int account;
  final DateTime addedDate;
  final DateTime updateDate;
  const Wallet(
      {required this.id,
      required this.account,
      required this.addedDate,
      required this.updateDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    return map;
  }

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      id: Value(id),
      account: Value(account),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
    );
  }

  factory Wallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallet(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
    };
  }

  Wallet copyWith(
          {int? id, int? account, DateTime? addedDate, DateTime? updateDate}) =>
      Wallet(
        id: id ?? this.id,
        account: account ?? this.account,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
      );
  Wallet copyWithCompanion(WalletsCompanion data) {
    return Wallet(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, addedDate, updateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.id == this.id &&
          other.account == this.account &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<int> id;
  final Value<int> account;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  const WalletsCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  });
  WalletsCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  }) : account = Value(account);
  static Insertable<Wallet> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
    });
  }

  WalletsCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate}) {
    return WalletsCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }
}

class $LoansTable extends Loans with TableInfo<$LoansTable, Loan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _institutionMeta =
      const VerificationMeta('institution');
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
      'institution', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _interestRateMeta =
      const VerificationMeta('interestRate');
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
      'interest_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _agreementNoMeta =
      const VerificationMeta('agreementNo');
  @override
  late final GeneratedColumn<String> agreementNo = GeneratedColumn<String>(
      'agreement_no', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _accountNoMeta =
      const VerificationMeta('accountNo');
  @override
  late final GeneratedColumn<String> accountNo = GeneratedColumn<String>(
      'account_no', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        account,
        institution,
        interestRate,
        startDate,
        endDate,
        agreementNo,
        accountNo
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loans';
  @override
  VerificationContext validateIntegrity(Insertable<Loan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('institution')) {
      context.handle(
          _institutionMeta,
          institution.isAcceptableOrUnknown(
              data['institution']!, _institutionMeta));
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
          _interestRateMeta,
          interestRate.isAcceptableOrUnknown(
              data['interest_rate']!, _interestRateMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('agreement_no')) {
      context.handle(
          _agreementNoMeta,
          agreementNo.isAcceptableOrUnknown(
              data['agreement_no']!, _agreementNoMeta));
    }
    if (data.containsKey('account_no')) {
      context.handle(_accountNoMeta,
          accountNo.isAcceptableOrUnknown(data['account_no']!, _accountNoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Loan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Loan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      institution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}institution']),
      interestRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}interest_rate']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      agreementNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agreement_no']),
      accountNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_no']),
    );
  }

  @override
  $LoansTable createAlias(String alias) {
    return $LoansTable(attachedDatabase, alias);
  }
}

class Loan extends DataClass implements Insertable<Loan> {
  final int id;
  final int account;
  final String? institution;
  final double? interestRate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? agreementNo;
  final String? accountNo;
  const Loan(
      {required this.id,
      required this.account,
      this.institution,
      this.interestRate,
      this.startDate,
      this.endDate,
      this.agreementNo,
      this.accountNo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    if (!nullToAbsent || institution != null) {
      map['institution'] = Variable<String>(institution);
    }
    if (!nullToAbsent || interestRate != null) {
      map['interest_rate'] = Variable<double>(interestRate);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || agreementNo != null) {
      map['agreement_no'] = Variable<String>(agreementNo);
    }
    if (!nullToAbsent || accountNo != null) {
      map['account_no'] = Variable<String>(accountNo);
    }
    return map;
  }

  LoansCompanion toCompanion(bool nullToAbsent) {
    return LoansCompanion(
      id: Value(id),
      account: Value(account),
      institution: institution == null && nullToAbsent
          ? const Value.absent()
          : Value(institution),
      interestRate: interestRate == null && nullToAbsent
          ? const Value.absent()
          : Value(interestRate),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      agreementNo: agreementNo == null && nullToAbsent
          ? const Value.absent()
          : Value(agreementNo),
      accountNo: accountNo == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNo),
    );
  }

  factory Loan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Loan(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      institution: serializer.fromJson<String?>(json['institution']),
      interestRate: serializer.fromJson<double?>(json['interestRate']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      agreementNo: serializer.fromJson<String?>(json['agreementNo']),
      accountNo: serializer.fromJson<String?>(json['accountNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'institution': serializer.toJson<String?>(institution),
      'interestRate': serializer.toJson<double?>(interestRate),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'agreementNo': serializer.toJson<String?>(agreementNo),
      'accountNo': serializer.toJson<String?>(accountNo),
    };
  }

  Loan copyWith(
          {int? id,
          int? account,
          Value<String?> institution = const Value.absent(),
          Value<double?> interestRate = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<String?> agreementNo = const Value.absent(),
          Value<String?> accountNo = const Value.absent()}) =>
      Loan(
        id: id ?? this.id,
        account: account ?? this.account,
        institution: institution.present ? institution.value : this.institution,
        interestRate:
            interestRate.present ? interestRate.value : this.interestRate,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        agreementNo: agreementNo.present ? agreementNo.value : this.agreementNo,
        accountNo: accountNo.present ? accountNo.value : this.accountNo,
      );
  Loan copyWithCompanion(LoansCompanion data) {
    return Loan(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      institution:
          data.institution.present ? data.institution.value : this.institution,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      agreementNo:
          data.agreementNo.present ? data.agreementNo.value : this.agreementNo,
      accountNo: data.accountNo.present ? data.accountNo.value : this.accountNo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Loan(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('institution: $institution, ')
          ..write('interestRate: $interestRate, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('agreementNo: $agreementNo, ')
          ..write('accountNo: $accountNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, institution, interestRate,
      startDate, endDate, agreementNo, accountNo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Loan &&
          other.id == this.id &&
          other.account == this.account &&
          other.institution == this.institution &&
          other.interestRate == this.interestRate &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.agreementNo == this.agreementNo &&
          other.accountNo == this.accountNo);
}

class LoansCompanion extends UpdateCompanion<Loan> {
  final Value<int> id;
  final Value<int> account;
  final Value<String?> institution;
  final Value<double?> interestRate;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> agreementNo;
  final Value<String?> accountNo;
  const LoansCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.institution = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.agreementNo = const Value.absent(),
    this.accountNo = const Value.absent(),
  });
  LoansCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    this.institution = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.agreementNo = const Value.absent(),
    this.accountNo = const Value.absent(),
  }) : account = Value(account);
  static Insertable<Loan> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<String>? institution,
    Expression<double>? interestRate,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? agreementNo,
    Expression<String>? accountNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (institution != null) 'institution': institution,
      if (interestRate != null) 'interest_rate': interestRate,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (agreementNo != null) 'agreement_no': agreementNo,
      if (accountNo != null) 'account_no': accountNo,
    });
  }

  LoansCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<String?>? institution,
      Value<double?>? interestRate,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? agreementNo,
      Value<String?>? accountNo}) {
    return LoansCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      institution: institution ?? this.institution,
      interestRate: interestRate ?? this.interestRate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      agreementNo: agreementNo ?? this.agreementNo,
      accountNo: accountNo ?? this.accountNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (agreementNo.present) {
      map['agreement_no'] = Variable<String>(agreementNo.value);
    }
    if (accountNo.present) {
      map['account_no'] = Variable<String>(accountNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoansCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('institution: $institution, ')
          ..write('interestRate: $interestRate, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('agreementNo: $agreementNo, ')
          ..write('accountNo: $accountNo')
          ..write(')'))
        .toString();
  }
}

class $CCardsTable extends CCards with TableInfo<$CCardsTable, CCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _institutionMeta =
      const VerificationMeta('institution');
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
      'institution', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _statementDateMeta =
      const VerificationMeta('statementDate');
  @override
  late final GeneratedColumn<int> statementDate = GeneratedColumn<int>(
      'statement_date', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _cardNoMeta = const VerificationMeta('cardNo');
  @override
  late final GeneratedColumn<String> cardNo = GeneratedColumn<String>(
      'card_no', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _cardNetworkMeta =
      const VerificationMeta('cardNetwork');
  @override
  late final GeneratedColumn<String> cardNetwork = GeneratedColumn<String>(
      'card_network', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, account, institution, statementDate, cardNo, cardNetwork];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'c_cards';
  @override
  VerificationContext validateIntegrity(Insertable<CCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('institution')) {
      context.handle(
          _institutionMeta,
          institution.isAcceptableOrUnknown(
              data['institution']!, _institutionMeta));
    }
    if (data.containsKey('statement_date')) {
      context.handle(
          _statementDateMeta,
          statementDate.isAcceptableOrUnknown(
              data['statement_date']!, _statementDateMeta));
    }
    if (data.containsKey('card_no')) {
      context.handle(_cardNoMeta,
          cardNo.isAcceptableOrUnknown(data['card_no']!, _cardNoMeta));
    }
    if (data.containsKey('card_network')) {
      context.handle(
          _cardNetworkMeta,
          cardNetwork.isAcceptableOrUnknown(
              data['card_network']!, _cardNetworkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      institution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}institution']),
      statementDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}statement_date']),
      cardNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_no']),
      cardNetwork: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_network']),
    );
  }

  @override
  $CCardsTable createAlias(String alias) {
    return $CCardsTable(attachedDatabase, alias);
  }
}

class CCard extends DataClass implements Insertable<CCard> {
  final int id;
  final int account;
  final String? institution;
  final int? statementDate;
  final String? cardNo;
  final String? cardNetwork;
  const CCard(
      {required this.id,
      required this.account,
      this.institution,
      this.statementDate,
      this.cardNo,
      this.cardNetwork});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    if (!nullToAbsent || institution != null) {
      map['institution'] = Variable<String>(institution);
    }
    if (!nullToAbsent || statementDate != null) {
      map['statement_date'] = Variable<int>(statementDate);
    }
    if (!nullToAbsent || cardNo != null) {
      map['card_no'] = Variable<String>(cardNo);
    }
    if (!nullToAbsent || cardNetwork != null) {
      map['card_network'] = Variable<String>(cardNetwork);
    }
    return map;
  }

  CCardsCompanion toCompanion(bool nullToAbsent) {
    return CCardsCompanion(
      id: Value(id),
      account: Value(account),
      institution: institution == null && nullToAbsent
          ? const Value.absent()
          : Value(institution),
      statementDate: statementDate == null && nullToAbsent
          ? const Value.absent()
          : Value(statementDate),
      cardNo:
          cardNo == null && nullToAbsent ? const Value.absent() : Value(cardNo),
      cardNetwork: cardNetwork == null && nullToAbsent
          ? const Value.absent()
          : Value(cardNetwork),
    );
  }

  factory CCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CCard(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      institution: serializer.fromJson<String?>(json['institution']),
      statementDate: serializer.fromJson<int?>(json['statementDate']),
      cardNo: serializer.fromJson<String?>(json['cardNo']),
      cardNetwork: serializer.fromJson<String?>(json['cardNetwork']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'institution': serializer.toJson<String?>(institution),
      'statementDate': serializer.toJson<int?>(statementDate),
      'cardNo': serializer.toJson<String?>(cardNo),
      'cardNetwork': serializer.toJson<String?>(cardNetwork),
    };
  }

  CCard copyWith(
          {int? id,
          int? account,
          Value<String?> institution = const Value.absent(),
          Value<int?> statementDate = const Value.absent(),
          Value<String?> cardNo = const Value.absent(),
          Value<String?> cardNetwork = const Value.absent()}) =>
      CCard(
        id: id ?? this.id,
        account: account ?? this.account,
        institution: institution.present ? institution.value : this.institution,
        statementDate:
            statementDate.present ? statementDate.value : this.statementDate,
        cardNo: cardNo.present ? cardNo.value : this.cardNo,
        cardNetwork: cardNetwork.present ? cardNetwork.value : this.cardNetwork,
      );
  CCard copyWithCompanion(CCardsCompanion data) {
    return CCard(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      institution:
          data.institution.present ? data.institution.value : this.institution,
      statementDate: data.statementDate.present
          ? data.statementDate.value
          : this.statementDate,
      cardNo: data.cardNo.present ? data.cardNo.value : this.cardNo,
      cardNetwork:
          data.cardNetwork.present ? data.cardNetwork.value : this.cardNetwork,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CCard(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('institution: $institution, ')
          ..write('statementDate: $statementDate, ')
          ..write('cardNo: $cardNo, ')
          ..write('cardNetwork: $cardNetwork')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, account, institution, statementDate, cardNo, cardNetwork);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CCard &&
          other.id == this.id &&
          other.account == this.account &&
          other.institution == this.institution &&
          other.statementDate == this.statementDate &&
          other.cardNo == this.cardNo &&
          other.cardNetwork == this.cardNetwork);
}

class CCardsCompanion extends UpdateCompanion<CCard> {
  final Value<int> id;
  final Value<int> account;
  final Value<String?> institution;
  final Value<int?> statementDate;
  final Value<String?> cardNo;
  final Value<String?> cardNetwork;
  const CCardsCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.institution = const Value.absent(),
    this.statementDate = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.cardNetwork = const Value.absent(),
  });
  CCardsCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    this.institution = const Value.absent(),
    this.statementDate = const Value.absent(),
    this.cardNo = const Value.absent(),
    this.cardNetwork = const Value.absent(),
  }) : account = Value(account);
  static Insertable<CCard> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<String>? institution,
    Expression<int>? statementDate,
    Expression<String>? cardNo,
    Expression<String>? cardNetwork,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (institution != null) 'institution': institution,
      if (statementDate != null) 'statement_date': statementDate,
      if (cardNo != null) 'card_no': cardNo,
      if (cardNetwork != null) 'card_network': cardNetwork,
    });
  }

  CCardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<String?>? institution,
      Value<int?>? statementDate,
      Value<String?>? cardNo,
      Value<String?>? cardNetwork}) {
    return CCardsCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      institution: institution ?? this.institution,
      statementDate: statementDate ?? this.statementDate,
      cardNo: cardNo ?? this.cardNo,
      cardNetwork: cardNetwork ?? this.cardNetwork,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (statementDate.present) {
      map['statement_date'] = Variable<int>(statementDate.value);
    }
    if (cardNo.present) {
      map['card_no'] = Variable<String>(cardNo.value);
    }
    if (cardNetwork.present) {
      map['card_network'] = Variable<String>(cardNetwork.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CCardsCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('institution: $institution, ')
          ..write('statementDate: $statementDate, ')
          ..write('cardNo: $cardNo, ')
          ..write('cardNetwork: $cardNetwork')
          ..write(')'))
        .toString();
  }
}

class $BalancesTable extends Balances with TableInfo<$BalancesTable, Balance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, account, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'balances';
  @override
  VerificationContext validateIntegrity(Insertable<Balance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Balance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Balance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $BalancesTable createAlias(String alias) {
    return $BalancesTable(attachedDatabase, alias);
  }
}

class Balance extends DataClass implements Insertable<Balance> {
  final int id;
  final int account;
  final int amount;
  const Balance(
      {required this.id, required this.account, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  BalancesCompanion toCompanion(bool nullToAbsent) {
    return BalancesCompanion(
      id: Value(id),
      account: Value(account),
      amount: Value(amount),
    );
  }

  factory Balance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Balance(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'amount': serializer.toJson<int>(amount),
    };
  }

  Balance copyWith({int? id, int? account, int? amount}) => Balance(
        id: id ?? this.id,
        account: account ?? this.account,
        amount: amount ?? this.amount,
      );
  Balance copyWithCompanion(BalancesCompanion data) {
    return Balance(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Balance(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Balance &&
          other.id == this.id &&
          other.account == this.account &&
          other.amount == this.amount);
}

class BalancesCompanion extends UpdateCompanion<Balance> {
  final Value<int> id;
  final Value<int> account;
  final Value<int> amount;
  const BalancesCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BalancesCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    this.amount = const Value.absent(),
  }) : account = Value(account);
  static Insertable<Balance> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (amount != null) 'amount': amount,
    });
  }

  BalancesCompanion copyWith(
      {Value<int>? id, Value<int>? account, Value<int>? amount}) {
    return BalancesCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalancesCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $FilePathsTable extends FilePaths
    with TableInfo<$FilePathsTable, FilePath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilePathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _transactionMeta =
      const VerificationMeta('transaction');
  @override
  late final GeneratedColumn<int> transaction = GeneratedColumn<int>(
      'transaction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transactions (id) ON DELETE CASCADE'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 512),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, transaction, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_paths';
  @override
  VerificationContext validateIntegrity(Insertable<FilePath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction')) {
      context.handle(
          _transactionMeta,
          transaction.isAcceptableOrUnknown(
              data['transaction']!, _transactionMeta));
    } else if (isInserting) {
      context.missing(_transactionMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilePath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilePath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      transaction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transaction'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
    );
  }

  @override
  $FilePathsTable createAlias(String alias) {
    return $FilePathsTable(attachedDatabase, alias);
  }
}

class FilePath extends DataClass implements Insertable<FilePath> {
  final int id;
  final int transaction;
  final String? path;
  const FilePath({required this.id, required this.transaction, this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction'] = Variable<int>(transaction);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    return map;
  }

  FilePathsCompanion toCompanion(bool nullToAbsent) {
    return FilePathsCompanion(
      id: Value(id),
      transaction: Value(transaction),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
    );
  }

  factory FilePath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilePath(
      id: serializer.fromJson<int>(json['id']),
      transaction: serializer.fromJson<int>(json['transaction']),
      path: serializer.fromJson<String?>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transaction': serializer.toJson<int>(transaction),
      'path': serializer.toJson<String?>(path),
    };
  }

  FilePath copyWith(
          {int? id,
          int? transaction,
          Value<String?> path = const Value.absent()}) =>
      FilePath(
        id: id ?? this.id,
        transaction: transaction ?? this.transaction,
        path: path.present ? path.value : this.path,
      );
  FilePath copyWithCompanion(FilePathsCompanion data) {
    return FilePath(
      id: data.id.present ? data.id.value : this.id,
      transaction:
          data.transaction.present ? data.transaction.value : this.transaction,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilePath(')
          ..write('id: $id, ')
          ..write('transaction: $transaction, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transaction, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilePath &&
          other.id == this.id &&
          other.transaction == this.transaction &&
          other.path == this.path);
}

class FilePathsCompanion extends UpdateCompanion<FilePath> {
  final Value<int> id;
  final Value<int> transaction;
  final Value<String?> path;
  const FilePathsCompanion({
    this.id = const Value.absent(),
    this.transaction = const Value.absent(),
    this.path = const Value.absent(),
  });
  FilePathsCompanion.insert({
    this.id = const Value.absent(),
    required int transaction,
    this.path = const Value.absent(),
  }) : transaction = Value(transaction);
  static Insertable<FilePath> custom({
    Expression<int>? id,
    Expression<int>? transaction,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transaction != null) 'transaction': transaction,
      if (path != null) 'path': path,
    });
  }

  FilePathsCompanion copyWith(
      {Value<int>? id, Value<int>? transaction, Value<String?>? path}) {
    return FilePathsCompanion(
      id: id ?? this.id,
      transaction: transaction ?? this.transaction,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transaction.present) {
      map['transaction'] = Variable<int>(transaction.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilePathsCompanion(')
          ..write('id: $id, ')
          ..write('transaction: $transaction, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, Budget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<BudgetInterval, int> interval =
      GeneratedColumn<int>('interval', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<BudgetInterval>($BudgetsTable.$converterinterval);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _startDayMeta =
      const VerificationMeta('startDay');
  @override
  late final GeneratedColumn<int> startDay = GeneratedColumn<int>(
      'start_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _profileMeta =
      const VerificationMeta('profile');
  @override
  late final GeneratedColumn<int> profile = GeneratedColumn<int>(
      'profile', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES profiles (id) ON DELETE CASCADE'));
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
      'added_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updateDateMeta =
      const VerificationMeta('updateDate');
  @override
  late final GeneratedColumn<DateTime> updateDate = GeneratedColumn<DateTime>(
      'update_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        interval,
        details,
        startDay,
        startDate,
        profile,
        addedDate,
        updateDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<Budget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('start_day')) {
      context.handle(_startDayMeta,
          startDay.isAcceptableOrUnknown(data['start_day']!, _startDayMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('profile')) {
      context.handle(_profileMeta,
          profile.isAcceptableOrUnknown(data['profile']!, _profileMeta));
    } else if (isInserting) {
      context.missing(_profileMeta);
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Budget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Budget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      interval: $BudgetsTable.$converterinterval.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval'])!),
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      startDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_day'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      profile: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile'])!,
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_date'])!,
      updateDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_date'])!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BudgetInterval, int, int> $converterinterval =
      const EnumIndexConverter<BudgetInterval>(BudgetInterval.values);
}

class Budget extends DataClass implements Insertable<Budget> {
  final int id;
  final String name;
  final BudgetInterval interval;
  final String details;
  final int startDay;
  final DateTime startDate;
  final int profile;
  final DateTime addedDate;
  final DateTime updateDate;
  const Budget(
      {required this.id,
      required this.name,
      required this.interval,
      required this.details,
      required this.startDay,
      required this.startDate,
      required this.profile,
      required this.addedDate,
      required this.updateDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['interval'] =
          Variable<int>($BudgetsTable.$converterinterval.toSql(interval));
    }
    map['details'] = Variable<String>(details);
    map['start_day'] = Variable<int>(startDay);
    map['start_date'] = Variable<DateTime>(startDate);
    map['profile'] = Variable<int>(profile);
    map['added_date'] = Variable<DateTime>(addedDate);
    map['update_date'] = Variable<DateTime>(updateDate);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      name: Value(name),
      interval: Value(interval),
      details: Value(details),
      startDay: Value(startDay),
      startDate: Value(startDate),
      profile: Value(profile),
      addedDate: Value(addedDate),
      updateDate: Value(updateDate),
    );
  }

  factory Budget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Budget(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      interval: $BudgetsTable.$converterinterval
          .fromJson(serializer.fromJson<int>(json['interval'])),
      details: serializer.fromJson<String>(json['details']),
      startDay: serializer.fromJson<int>(json['startDay']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      profile: serializer.fromJson<int>(json['profile']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      updateDate: serializer.fromJson<DateTime>(json['updateDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'interval': serializer
          .toJson<int>($BudgetsTable.$converterinterval.toJson(interval)),
      'details': serializer.toJson<String>(details),
      'startDay': serializer.toJson<int>(startDay),
      'startDate': serializer.toJson<DateTime>(startDate),
      'profile': serializer.toJson<int>(profile),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'updateDate': serializer.toJson<DateTime>(updateDate),
    };
  }

  Budget copyWith(
          {int? id,
          String? name,
          BudgetInterval? interval,
          String? details,
          int? startDay,
          DateTime? startDate,
          int? profile,
          DateTime? addedDate,
          DateTime? updateDate}) =>
      Budget(
        id: id ?? this.id,
        name: name ?? this.name,
        interval: interval ?? this.interval,
        details: details ?? this.details,
        startDay: startDay ?? this.startDay,
        startDate: startDate ?? this.startDate,
        profile: profile ?? this.profile,
        addedDate: addedDate ?? this.addedDate,
        updateDate: updateDate ?? this.updateDate,
      );
  Budget copyWithCompanion(BudgetsCompanion data) {
    return Budget(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      interval: data.interval.present ? data.interval.value : this.interval,
      details: data.details.present ? data.details.value : this.details,
      startDay: data.startDay.present ? data.startDay.value : this.startDay,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      profile: data.profile.present ? data.profile.value : this.profile,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      updateDate:
          data.updateDate.present ? data.updateDate.value : this.updateDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Budget(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('interval: $interval, ')
          ..write('details: $details, ')
          ..write('startDay: $startDay, ')
          ..write('startDate: $startDate, ')
          ..write('profile: $profile, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, interval, details, startDay,
      startDate, profile, addedDate, updateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Budget &&
          other.id == this.id &&
          other.name == this.name &&
          other.interval == this.interval &&
          other.details == this.details &&
          other.startDay == this.startDay &&
          other.startDate == this.startDate &&
          other.profile == this.profile &&
          other.addedDate == this.addedDate &&
          other.updateDate == this.updateDate);
}

class BudgetsCompanion extends UpdateCompanion<Budget> {
  final Value<int> id;
  final Value<String> name;
  final Value<BudgetInterval> interval;
  final Value<String> details;
  final Value<int> startDay;
  final Value<DateTime> startDate;
  final Value<int> profile;
  final Value<DateTime> addedDate;
  final Value<DateTime> updateDate;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.interval = const Value.absent(),
    this.details = const Value.absent(),
    this.startDay = const Value.absent(),
    this.startDate = const Value.absent(),
    this.profile = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  });
  BudgetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required BudgetInterval interval,
    required String details,
    this.startDay = const Value.absent(),
    this.startDate = const Value.absent(),
    required int profile,
    this.addedDate = const Value.absent(),
    this.updateDate = const Value.absent(),
  })  : name = Value(name),
        interval = Value(interval),
        details = Value(details),
        profile = Value(profile);
  static Insertable<Budget> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? interval,
    Expression<String>? details,
    Expression<int>? startDay,
    Expression<DateTime>? startDate,
    Expression<int>? profile,
    Expression<DateTime>? addedDate,
    Expression<DateTime>? updateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (interval != null) 'interval': interval,
      if (details != null) 'details': details,
      if (startDay != null) 'start_day': startDay,
      if (startDate != null) 'start_date': startDate,
      if (profile != null) 'profile': profile,
      if (addedDate != null) 'added_date': addedDate,
      if (updateDate != null) 'update_date': updateDate,
    });
  }

  BudgetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<BudgetInterval>? interval,
      Value<String>? details,
      Value<int>? startDay,
      Value<DateTime>? startDate,
      Value<int>? profile,
      Value<DateTime>? addedDate,
      Value<DateTime>? updateDate}) {
    return BudgetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      interval: interval ?? this.interval,
      details: details ?? this.details,
      startDay: startDay ?? this.startDay,
      startDate: startDate ?? this.startDate,
      profile: profile ?? this.profile,
      addedDate: addedDate ?? this.addedDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (interval.present) {
      map['interval'] =
          Variable<int>($BudgetsTable.$converterinterval.toSql(interval.value));
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (startDay.present) {
      map['start_day'] = Variable<int>(startDay.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (profile.present) {
      map['profile'] = Variable<int>(profile.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (updateDate.present) {
      map['update_date'] = Variable<DateTime>(updateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('interval: $interval, ')
          ..write('details: $details, ')
          ..write('startDay: $startDay, ')
          ..write('startDate: $startDate, ')
          ..write('profile: $profile, ')
          ..write('addedDate: $addedDate, ')
          ..write('updateDate: $updateDate')
          ..write(')'))
        .toString();
  }
}

class $BudgetAccountsTable extends BudgetAccounts
    with TableInfo<$BudgetAccountsTable, BudgetAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<int> budget = GeneratedColumn<int>(
      'budget', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES budgets (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, account, budget, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_accounts';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetAccount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetAccount(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $BudgetAccountsTable createAlias(String alias) {
    return $BudgetAccountsTable(attachedDatabase, alias);
  }
}

class BudgetAccount extends DataClass implements Insertable<BudgetAccount> {
  final int id;
  final int account;
  final int budget;
  final int amount;
  const BudgetAccount(
      {required this.id,
      required this.account,
      required this.budget,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['budget'] = Variable<int>(budget);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  BudgetAccountsCompanion toCompanion(bool nullToAbsent) {
    return BudgetAccountsCompanion(
      id: Value(id),
      account: Value(account),
      budget: Value(budget),
      amount: Value(amount),
    );
  }

  factory BudgetAccount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetAccount(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      budget: serializer.fromJson<int>(json['budget']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'budget': serializer.toJson<int>(budget),
      'amount': serializer.toJson<int>(amount),
    };
  }

  BudgetAccount copyWith({int? id, int? account, int? budget, int? amount}) =>
      BudgetAccount(
        id: id ?? this.id,
        account: account ?? this.account,
        budget: budget ?? this.budget,
        amount: amount ?? this.amount,
      );
  BudgetAccount copyWithCompanion(BudgetAccountsCompanion data) {
    return BudgetAccount(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      budget: data.budget.present ? data.budget.value : this.budget,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetAccount(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('budget: $budget, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, budget, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetAccount &&
          other.id == this.id &&
          other.account == this.account &&
          other.budget == this.budget &&
          other.amount == this.amount);
}

class BudgetAccountsCompanion extends UpdateCompanion<BudgetAccount> {
  final Value<int> id;
  final Value<int> account;
  final Value<int> budget;
  final Value<int> amount;
  const BudgetAccountsCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.budget = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BudgetAccountsCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    required int budget,
    this.amount = const Value.absent(),
  })  : account = Value(account),
        budget = Value(budget);
  static Insertable<BudgetAccount> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<int>? budget,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (budget != null) 'budget': budget,
      if (amount != null) 'amount': amount,
    });
  }

  BudgetAccountsCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<int>? budget,
      Value<int>? amount}) {
    return BudgetAccountsCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      budget: budget ?? this.budget,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (budget.present) {
      map['budget'] = Variable<int>(budget.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetAccountsCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('budget: $budget, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $BudgetFundsTable extends BudgetFunds
    with TableInfo<$BudgetFundsTable, BudgetFund> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetFundsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE'));
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<int> budget = GeneratedColumn<int>(
      'budget', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES budgets (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, account, budget];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_funds';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetFund> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetFund map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetFund(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget'])!,
    );
  }

  @override
  $BudgetFundsTable createAlias(String alias) {
    return $BudgetFundsTable(attachedDatabase, alias);
  }
}

class BudgetFund extends DataClass implements Insertable<BudgetFund> {
  final int id;
  final int account;
  final int budget;
  const BudgetFund(
      {required this.id, required this.account, required this.budget});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['budget'] = Variable<int>(budget);
    return map;
  }

  BudgetFundsCompanion toCompanion(bool nullToAbsent) {
    return BudgetFundsCompanion(
      id: Value(id),
      account: Value(account),
      budget: Value(budget),
    );
  }

  factory BudgetFund.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetFund(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      budget: serializer.fromJson<int>(json['budget']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'budget': serializer.toJson<int>(budget),
    };
  }

  BudgetFund copyWith({int? id, int? account, int? budget}) => BudgetFund(
        id: id ?? this.id,
        account: account ?? this.account,
        budget: budget ?? this.budget,
      );
  BudgetFund copyWithCompanion(BudgetFundsCompanion data) {
    return BudgetFund(
      id: data.id.present ? data.id.value : this.id,
      account: data.account.present ? data.account.value : this.account,
      budget: data.budget.present ? data.budget.value : this.budget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetFund(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('budget: $budget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, budget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetFund &&
          other.id == this.id &&
          other.account == this.account &&
          other.budget == this.budget);
}

class BudgetFundsCompanion extends UpdateCompanion<BudgetFund> {
  final Value<int> id;
  final Value<int> account;
  final Value<int> budget;
  const BudgetFundsCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.budget = const Value.absent(),
  });
  BudgetFundsCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    required int budget,
  })  : account = Value(account),
        budget = Value(budget);
  static Insertable<BudgetFund> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<int>? budget,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (budget != null) 'budget': budget,
    });
  }

  BudgetFundsCompanion copyWith(
      {Value<int>? id, Value<int>? account, Value<int>? budget}) {
    return BudgetFundsCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      budget: budget ?? this.budget,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (budget.present) {
      map['budget'] = Variable<int>(budget.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetFundsCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('budget: $budget')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  $MyDatabaseManager get managers => $MyDatabaseManager(this);
  late final $AccTypesTable accTypes = $AccTypesTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $BanksTable banks = $BanksTable(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  late final $LoansTable loans = $LoansTable(this);
  late final $CCardsTable cCards = $CCardsTable(this);
  late final $BalancesTable balances = $BalancesTable(this);
  late final $FilePathsTable filePaths = $FilePathsTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $BudgetAccountsTable budgetAccounts = $BudgetAccountsTable(this);
  late final $BudgetFundsTable budgetFunds = $BudgetFundsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accTypes,
        profiles,
        accounts,
        transactions,
        users,
        banks,
        wallets,
        loans,
        cCards,
        balances,
        filePaths,
        budgets,
        budgetAccounts,
        budgetFunds
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('acc_types',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('accounts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('accounts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('banks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('wallets', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('loans', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('c_cards', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('balances', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('transactions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('file_paths', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('profiles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budgets', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budget_accounts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budget_accounts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budget_funds', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budget_funds', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$AccTypesTableCreateCompanionBuilder = AccTypesCompanion Function({
  Value<int> id,
  required String name,
  required PrimaryType primary,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
  Value<bool> isEditable,
});
typedef $$AccTypesTableUpdateCompanionBuilder = AccTypesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<PrimaryType> primary,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
  Value<bool> isEditable,
});

final class $$AccTypesTableReferences
    extends BaseReferences<_$MyDatabase, $AccTypesTable, AccType> {
  $$AccTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.accounts,
          aliasName: $_aliasNameGenerator(db.accTypes.id, db.accounts.accType));

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.accType.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccTypesTableFilterComposer
    extends Composer<_$MyDatabase, $AccTypesTable> {
  $$AccTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PrimaryType, PrimaryType, int> get primary =>
      $composableBuilder(
          column: $table.primary,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnFilters(column));

  Expression<bool> accountsRefs(
      Expression<bool> Function($$AccountsTableFilterComposer f) f) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.accType,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccTypesTableOrderingComposer
    extends Composer<_$MyDatabase, $AccTypesTable> {
  $$AccTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get primary => $composableBuilder(
      column: $table.primary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnOrderings(column));
}

class $$AccTypesTableAnnotationComposer
    extends Composer<_$MyDatabase, $AccTypesTable> {
  $$AccTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PrimaryType, int> get primary =>
      $composableBuilder(column: $table.primary, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  GeneratedColumn<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => column);

  Expression<T> accountsRefs<T extends Object>(
      Expression<T> Function($$AccountsTableAnnotationComposer a) f) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.accType,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccTypesTableTableManager extends RootTableManager<
    _$MyDatabase,
    $AccTypesTable,
    AccType,
    $$AccTypesTableFilterComposer,
    $$AccTypesTableOrderingComposer,
    $$AccTypesTableAnnotationComposer,
    $$AccTypesTableCreateCompanionBuilder,
    $$AccTypesTableUpdateCompanionBuilder,
    (AccType, $$AccTypesTableReferences),
    AccType,
    PrefetchHooks Function({bool accountsRefs})> {
  $$AccTypesTableTableManager(_$MyDatabase db, $AccTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<PrimaryType> primary = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
          }) =>
              AccTypesCompanion(
            id: id,
            name: name,
            primary: primary,
            addedDate: addedDate,
            updateDate: updateDate,
            isEditable: isEditable,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required PrimaryType primary,
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
          }) =>
              AccTypesCompanion.insert(
            id: id,
            name: name,
            primary: primary,
            addedDate: addedDate,
            updateDate: updateDate,
            isEditable: isEditable,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AccTypesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({accountsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (accountsRefs) db.accounts],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (accountsRefs)
                    await $_getPrefetchedData<AccType, $AccTypesTable, Account>(
                        currentTable: table,
                        referencedTable:
                            $$AccTypesTableReferences._accountsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccTypesTableReferences(db, table, p0)
                                .accountsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.accType == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AccTypesTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $AccTypesTable,
    AccType,
    $$AccTypesTableFilterComposer,
    $$AccTypesTableOrderingComposer,
    $$AccTypesTableAnnotationComposer,
    $$AccTypesTableCreateCompanionBuilder,
    $$AccTypesTableUpdateCompanionBuilder,
    (AccType, $$AccTypesTableReferences),
    AccType,
    PrefetchHooks Function({bool accountsRefs})>;
typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> alias,
  Value<String?> address,
  Value<String?> zip,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> tin,
  Value<bool> isSelected,
  required Currency currency,
  Value<String?> globalID,
  Value<bool> isLocal,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> alias,
  Value<String?> address,
  Value<String?> zip,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> tin,
  Value<bool> isSelected,
  Value<Currency> currency,
  Value<String?> globalID,
  Value<bool> isLocal,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});

final class $$ProfilesTableReferences
    extends BaseReferences<_$MyDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.accounts,
          aliasName: $_aliasNameGenerator(db.profiles.id, db.accounts.profile));

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.profile.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _transactionsRefsTable(_$MyDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName:
              $_aliasNameGenerator(db.profiles.id, db.transactions.profile));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.profile.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BudgetsTable, List<Budget>> _budgetsRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.budgets,
          aliasName: $_aliasNameGenerator(db.profiles.id, db.budgets.profile));

  $$BudgetsTableProcessedTableManager get budgetsRefs {
    final manager = $$BudgetsTableTableManager($_db, $_db.budgets)
        .filter((f) => f.profile.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$MyDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alias => $composableBuilder(
      column: $table.alias, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zip => $composableBuilder(
      column: $table.zip, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tin => $composableBuilder(
      column: $table.tin, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Currency, Currency, int> get currency =>
      $composableBuilder(
          column: $table.currency,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get globalID => $composableBuilder(
      column: $table.globalID, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  Expression<bool> accountsRefs(
      Expression<bool> Function($$AccountsTableFilterComposer f) f) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> budgetsRefs(
      Expression<bool> Function($$BudgetsTableFilterComposer f) f) {
    final $$BudgetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableFilterComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$MyDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alias => $composableBuilder(
      column: $table.alias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zip => $composableBuilder(
      column: $table.zip, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tin => $composableBuilder(
      column: $table.tin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get globalID => $composableBuilder(
      column: $table.globalID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$MyDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get zip =>
      $composableBuilder(column: $table.zip, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get tin =>
      $composableBuilder(column: $table.tin, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
      column: $table.isSelected, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get globalID =>
      $composableBuilder(column: $table.globalID, builder: (column) => column);

  GeneratedColumn<bool> get isLocal =>
      $composableBuilder(column: $table.isLocal, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  Expression<T> accountsRefs<T extends Object>(
      Expression<T> Function($$AccountsTableAnnotationComposer a) f) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> budgetsRefs<T extends Object>(
      Expression<T> Function($$BudgetsTableAnnotationComposer a) f) {
    final $$BudgetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.profile,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProfilesTableTableManager extends RootTableManager<
    _$MyDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, $$ProfilesTableReferences),
    Profile,
    PrefetchHooks Function(
        {bool accountsRefs, bool transactionsRefs, bool budgetsRefs})> {
  $$ProfilesTableTableManager(_$MyDatabase db, $ProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> alias = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> zip = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> tin = const Value.absent(),
            Value<bool> isSelected = const Value.absent(),
            Value<Currency> currency = const Value.absent(),
            Value<String?> globalID = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              ProfilesCompanion(
            id: id,
            name: name,
            alias: alias,
            address: address,
            zip: zip,
            email: email,
            phone: phone,
            tin: tin,
            isSelected: isSelected,
            currency: currency,
            globalID: globalID,
            isLocal: isLocal,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> alias = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> zip = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> tin = const Value.absent(),
            Value<bool> isSelected = const Value.absent(),
            required Currency currency,
            Value<String?> globalID = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              ProfilesCompanion.insert(
            id: id,
            name: name,
            alias: alias,
            address: address,
            zip: zip,
            email: email,
            phone: phone,
            tin: tin,
            isSelected: isSelected,
            currency: currency,
            globalID: globalID,
            isLocal: isLocal,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProfilesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {accountsRefs = false,
              transactionsRefs = false,
              budgetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (accountsRefs) db.accounts,
                if (transactionsRefs) db.transactions,
                if (budgetsRefs) db.budgets
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (accountsRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable, Account>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._accountsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .accountsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.profile == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable,
                            Transaction>(
                        currentTable: table,
                        referencedTable: $$ProfilesTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.profile == item.id),
                        typedResults: items),
                  if (budgetsRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable, Budget>(
                        currentTable: table,
                        referencedTable:
                            $$ProfilesTableReferences._budgetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProfilesTableReferences(db, table, p0)
                                .budgetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.profile == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProfilesTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, $$ProfilesTableReferences),
    Profile,
    PrefetchHooks Function(
        {bool accountsRefs, bool transactionsRefs, bool budgetsRefs})>;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required String name,
  Value<int> openBal,
  Value<DateTime> openDate,
  required int accType,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
  Value<bool> isEditable,
  required int profile,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> openBal,
  Value<DateTime> openDate,
  Value<int> accType,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
  Value<bool> isEditable,
  Value<int> profile,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$MyDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccTypesTable _accTypeTable(_$MyDatabase db) => db.accTypes
      .createAlias($_aliasNameGenerator(db.accounts.accType, db.accTypes.id));

  $$AccTypesTableProcessedTableManager get accType {
    final $_column = $_itemColumn<int>('acc_type')!;

    final manager = $$AccTypesTableTableManager($_db, $_db.accTypes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accTypeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProfilesTable _profileTable(_$MyDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.accounts.profile, db.profiles.id));

  $$ProfilesTableProcessedTableManager get profile {
    final $_column = $_itemColumn<int>('profile')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _drAccountTable(_$MyDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.transactions.dr));

  $$TransactionsTableProcessedTableManager get drAccount {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.dr.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_drAccountTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
      _crAccountTable(_$MyDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.transactions.cr));

  $$TransactionsTableProcessedTableManager get crAccount {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.cr.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_crAccountTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BanksTable, List<Bank>> _banksRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.banks,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.banks.account));

  $$BanksTableProcessedTableManager get banksRefs {
    final manager = $$BanksTableTableManager($_db, $_db.banks)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_banksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WalletsTable, List<Wallet>> _walletsRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.wallets,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.wallets.account));

  $$WalletsTableProcessedTableManager get walletsRefs {
    final manager = $$WalletsTableTableManager($_db, $_db.wallets)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_walletsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LoansTable, List<Loan>> _loansRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.loans,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.loans.account));

  $$LoansTableProcessedTableManager get loansRefs {
    final manager = $$LoansTableTableManager($_db, $_db.loans)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loansRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CCardsTable, List<CCard>> _cCardsRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.cCards,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.cCards.account));

  $$CCardsTableProcessedTableManager get cCardsRefs {
    final manager = $$CCardsTableTableManager($_db, $_db.cCards)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cCardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BalancesTable, List<Balance>> _balancesRefsTable(
          _$MyDatabase db) =>
      MultiTypedResultKey.fromTable(db.balances,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.balances.account));

  $$BalancesTableProcessedTableManager get balancesRefs {
    final manager = $$BalancesTableTableManager($_db, $_db.balances)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_balancesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BudgetAccountsTable, List<BudgetAccount>>
      _budgetAccountsRefsTable(_$MyDatabase db) =>
          MultiTypedResultKey.fromTable(db.budgetAccounts,
              aliasName: $_aliasNameGenerator(
                  db.accounts.id, db.budgetAccounts.account));

  $$BudgetAccountsTableProcessedTableManager get budgetAccountsRefs {
    final manager = $$BudgetAccountsTableTableManager($_db, $_db.budgetAccounts)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetAccountsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BudgetFundsTable, List<BudgetFund>>
      _budgetFundsRefsTable(_$MyDatabase db) =>
          MultiTypedResultKey.fromTable(db.budgetFunds,
              aliasName:
                  $_aliasNameGenerator(db.accounts.id, db.budgetFunds.account));

  $$BudgetFundsTableProcessedTableManager get budgetFundsRefs {
    final manager = $$BudgetFundsTableTableManager($_db, $_db.budgetFunds)
        .filter((f) => f.account.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetFundsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$MyDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openBal => $composableBuilder(
      column: $table.openBal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openDate => $composableBuilder(
      column: $table.openDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnFilters(column));

  $$AccTypesTableFilterComposer get accType {
    final $$AccTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accType,
        referencedTable: $db.accTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccTypesTableFilterComposer(
              $db: $db,
              $table: $db.accTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableFilterComposer get profile {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> drAccount(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.dr,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> crAccount(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.cr,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> banksRefs(
      Expression<bool> Function($$BanksTableFilterComposer f) f) {
    final $$BanksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.banks,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BanksTableFilterComposer(
              $db: $db,
              $table: $db.banks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> walletsRefs(
      Expression<bool> Function($$WalletsTableFilterComposer f) f) {
    final $$WalletsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallets,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletsTableFilterComposer(
              $db: $db,
              $table: $db.wallets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> loansRefs(
      Expression<bool> Function($$LoansTableFilterComposer f) f) {
    final $$LoansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loans,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoansTableFilterComposer(
              $db: $db,
              $table: $db.loans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> cCardsRefs(
      Expression<bool> Function($$CCardsTableFilterComposer f) f) {
    final $$CCardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cCards,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CCardsTableFilterComposer(
              $db: $db,
              $table: $db.cCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> balancesRefs(
      Expression<bool> Function($$BalancesTableFilterComposer f) f) {
    final $$BalancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balances,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalancesTableFilterComposer(
              $db: $db,
              $table: $db.balances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> budgetAccountsRefs(
      Expression<bool> Function($$BudgetAccountsTableFilterComposer f) f) {
    final $$BudgetAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetAccounts,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetAccountsTableFilterComposer(
              $db: $db,
              $table: $db.budgetAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> budgetFundsRefs(
      Expression<bool> Function($$BudgetFundsTableFilterComposer f) f) {
    final $$BudgetFundsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetFunds,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetFundsTableFilterComposer(
              $db: $db,
              $table: $db.budgetFunds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$MyDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openBal => $composableBuilder(
      column: $table.openBal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openDate => $composableBuilder(
      column: $table.openDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnOrderings(column));

  $$AccTypesTableOrderingComposer get accType {
    final $$AccTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accType,
        referencedTable: $db.accTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccTypesTableOrderingComposer(
              $db: $db,
              $table: $db.accTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableOrderingComposer get profile {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$MyDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get openBal =>
      $composableBuilder(column: $table.openBal, builder: (column) => column);

  GeneratedColumn<DateTime> get openDate =>
      $composableBuilder(column: $table.openDate, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  GeneratedColumn<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => column);

  $$AccTypesTableAnnotationComposer get accType {
    final $$AccTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accType,
        referencedTable: $db.accTypes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.accTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableAnnotationComposer get profile {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> drAccount<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.dr,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> crAccount<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.cr,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> banksRefs<T extends Object>(
      Expression<T> Function($$BanksTableAnnotationComposer a) f) {
    final $$BanksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.banks,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BanksTableAnnotationComposer(
              $db: $db,
              $table: $db.banks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> walletsRefs<T extends Object>(
      Expression<T> Function($$WalletsTableAnnotationComposer a) f) {
    final $$WalletsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wallets,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletsTableAnnotationComposer(
              $db: $db,
              $table: $db.wallets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> loansRefs<T extends Object>(
      Expression<T> Function($$LoansTableAnnotationComposer a) f) {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.loans,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LoansTableAnnotationComposer(
              $db: $db,
              $table: $db.loans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> cCardsRefs<T extends Object>(
      Expression<T> Function($$CCardsTableAnnotationComposer a) f) {
    final $$CCardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cCards,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CCardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cCards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> balancesRefs<T extends Object>(
      Expression<T> Function($$BalancesTableAnnotationComposer a) f) {
    final $$BalancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.balances,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BalancesTableAnnotationComposer(
              $db: $db,
              $table: $db.balances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> budgetAccountsRefs<T extends Object>(
      Expression<T> Function($$BudgetAccountsTableAnnotationComposer a) f) {
    final $$BudgetAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetAccounts,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgetAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> budgetFundsRefs<T extends Object>(
      Expression<T> Function($$BudgetFundsTableAnnotationComposer a) f) {
    final $$BudgetFundsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetFunds,
        getReferencedColumn: (t) => t.account,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetFundsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgetFunds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, $$AccountsTableReferences),
    Account,
    PrefetchHooks Function(
        {bool accType,
        bool profile,
        bool drAccount,
        bool crAccount,
        bool banksRefs,
        bool walletsRefs,
        bool loansRefs,
        bool cCardsRefs,
        bool balancesRefs,
        bool budgetAccountsRefs,
        bool budgetFundsRefs})> {
  $$AccountsTableTableManager(_$MyDatabase db, $AccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> openBal = const Value.absent(),
            Value<DateTime> openDate = const Value.absent(),
            Value<int> accType = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
            Value<int> profile = const Value.absent(),
          }) =>
              AccountsCompanion(
            id: id,
            name: name,
            openBal: openBal,
            openDate: openDate,
            accType: accType,
            addedDate: addedDate,
            updateDate: updateDate,
            isEditable: isEditable,
            profile: profile,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> openBal = const Value.absent(),
            Value<DateTime> openDate = const Value.absent(),
            required int accType,
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
            required int profile,
          }) =>
              AccountsCompanion.insert(
            id: id,
            name: name,
            openBal: openBal,
            openDate: openDate,
            accType: accType,
            addedDate: addedDate,
            updateDate: updateDate,
            isEditable: isEditable,
            profile: profile,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AccountsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {accType = false,
              profile = false,
              drAccount = false,
              crAccount = false,
              banksRefs = false,
              walletsRefs = false,
              loansRefs = false,
              cCardsRefs = false,
              balancesRefs = false,
              budgetAccountsRefs = false,
              budgetFundsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drAccount) db.transactions,
                if (crAccount) db.transactions,
                if (banksRefs) db.banks,
                if (walletsRefs) db.wallets,
                if (loansRefs) db.loans,
                if (cCardsRefs) db.cCards,
                if (balancesRefs) db.balances,
                if (budgetAccountsRefs) db.budgetAccounts,
                if (budgetFundsRefs) db.budgetFunds
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (accType) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.accType,
                    referencedTable:
                        $$AccountsTableReferences._accTypeTable(db),
                    referencedColumn:
                        $$AccountsTableReferences._accTypeTable(db).id,
                  ) as T;
                }
                if (profile) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.profile,
                    referencedTable:
                        $$AccountsTableReferences._profileTable(db),
                    referencedColumn:
                        $$AccountsTableReferences._profileTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drAccount)
                    await $_getPrefetchedData<Account, $AccountsTable,
                            Transaction>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._drAccountTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).drAccount,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.dr == item.id),
                        typedResults: items),
                  if (crAccount)
                    await $_getPrefetchedData<Account, $AccountsTable,
                            Transaction>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._crAccountTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).crAccount,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.cr == item.id),
                        typedResults: items),
                  if (banksRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, Bank>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._banksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).banksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (walletsRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, Wallet>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._walletsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0)
                                .walletsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (loansRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, Loan>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._loansRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).loansRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (cCardsRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, CCard>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._cCardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).cCardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (balancesRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, Balance>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._balancesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0)
                                .balancesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (budgetAccountsRefs)
                    await $_getPrefetchedData<Account, $AccountsTable,
                            BudgetAccount>(
                        currentTable: table,
                        referencedTable: $$AccountsTableReferences
                            ._budgetAccountsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0)
                                .budgetAccountsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items),
                  if (budgetFundsRefs)
                    await $_getPrefetchedData<Account, $AccountsTable,
                            BudgetFund>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._budgetFundsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0)
                                .budgetFundsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.account == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AccountsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, $$AccountsTableReferences),
    Account,
    PrefetchHooks Function(
        {bool accType,
        bool profile,
        bool drAccount,
        bool crAccount,
        bool banksRefs,
        bool walletsRefs,
        bool loansRefs,
        bool cCardsRefs,
        bool balancesRefs,
        bool budgetAccountsRefs,
        bool budgetFundsRefs})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  required DateTime vchDate,
  required String narr,
  required String refNo,
  required VoucherType vchType,
  required int dr,
  required int cr,
  Value<int> amount,
  required int profile,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> vchDate,
  Value<String> narr,
  Value<String> refNo,
  Value<VoucherType> vchType,
  Value<int> dr,
  Value<int> cr,
  Value<int> amount,
  Value<int> profile,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});

final class $$TransactionsTableReferences
    extends BaseReferences<_$MyDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _drTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.transactions.dr, db.accounts.id));

  $$AccountsTableProcessedTableManager get dr {
    final $_column = $_itemColumn<int>('dr')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountsTable _crTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.transactions.cr, db.accounts.id));

  $$AccountsTableProcessedTableManager get cr {
    final $_column = $_itemColumn<int>('cr')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_crTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProfilesTable _profileTable(_$MyDatabase db) =>
      db.profiles.createAlias(
          $_aliasNameGenerator(db.transactions.profile, db.profiles.id));

  $$ProfilesTableProcessedTableManager get profile {
    final $_column = $_itemColumn<int>('profile')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FilePathsTable, List<FilePath>>
      _filePathsRefsTable(_$MyDatabase db) =>
          MultiTypedResultKey.fromTable(db.filePaths,
              aliasName: $_aliasNameGenerator(
                  db.transactions.id, db.filePaths.transaction));

  $$FilePathsTableProcessedTableManager get filePathsRefs {
    final manager = $$FilePathsTableTableManager($_db, $_db.filePaths)
        .filter((f) => f.transaction.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_filePathsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$MyDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get vchDate => $composableBuilder(
      column: $table.vchDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get narr => $composableBuilder(
      column: $table.narr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refNo => $composableBuilder(
      column: $table.refNo, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<VoucherType, VoucherType, int> get vchType =>
      $composableBuilder(
          column: $table.vchType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get dr {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableFilterComposer get cr {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableFilterComposer get profile {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> filePathsRefs(
      Expression<bool> Function($$FilePathsTableFilterComposer f) f) {
    final $$FilePathsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.filePaths,
        getReferencedColumn: (t) => t.transaction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilePathsTableFilterComposer(
              $db: $db,
              $table: $db.filePaths,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$MyDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get vchDate => $composableBuilder(
      column: $table.vchDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get narr => $composableBuilder(
      column: $table.narr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refNo => $composableBuilder(
      column: $table.refNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vchType => $composableBuilder(
      column: $table.vchType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get dr {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableOrderingComposer get cr {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableOrderingComposer get profile {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$MyDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get vchDate =>
      $composableBuilder(column: $table.vchDate, builder: (column) => column);

  GeneratedColumn<String> get narr =>
      $composableBuilder(column: $table.narr, builder: (column) => column);

  GeneratedColumn<String> get refNo =>
      $composableBuilder(column: $table.refNo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VoucherType, int> get vchType =>
      $composableBuilder(column: $table.vchType, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  $$AccountsTableAnnotationComposer get dr {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableAnnotationComposer get cr {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cr,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProfilesTableAnnotationComposer get profile {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> filePathsRefs<T extends Object>(
      Expression<T> Function($$FilePathsTableAnnotationComposer a) f) {
    final $$FilePathsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.filePaths,
        getReferencedColumn: (t) => t.transaction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilePathsTableAnnotationComposer(
              $db: $db,
              $table: $db.filePaths,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function(
        {bool dr, bool cr, bool profile, bool filePathsRefs})> {
  $$TransactionsTableTableManager(_$MyDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> vchDate = const Value.absent(),
            Value<String> narr = const Value.absent(),
            Value<String> refNo = const Value.absent(),
            Value<VoucherType> vchType = const Value.absent(),
            Value<int> dr = const Value.absent(),
            Value<int> cr = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<int> profile = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            vchDate: vchDate,
            narr: narr,
            refNo: refNo,
            vchType: vchType,
            dr: dr,
            cr: cr,
            amount: amount,
            profile: profile,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime vchDate,
            required String narr,
            required String refNo,
            required VoucherType vchType,
            required int dr,
            required int cr,
            Value<int> amount = const Value.absent(),
            required int profile,
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            vchDate: vchDate,
            narr: narr,
            refNo: refNo,
            vchType: vchType,
            dr: dr,
            cr: cr,
            amount: amount,
            profile: profile,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dr = false,
              cr = false,
              profile = false,
              filePathsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (filePathsRefs) db.filePaths],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dr) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dr,
                    referencedTable: $$TransactionsTableReferences._drTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._drTable(db).id,
                  ) as T;
                }
                if (cr) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cr,
                    referencedTable: $$TransactionsTableReferences._crTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._crTable(db).id,
                  ) as T;
                }
                if (profile) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.profile,
                    referencedTable:
                        $$TransactionsTableReferences._profileTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._profileTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (filePathsRefs)
                    await $_getPrefetchedData<Transaction, $TransactionsTable,
                            FilePath>(
                        currentTable: table,
                        referencedTable: $$TransactionsTableReferences
                            ._filePathsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TransactionsTableReferences(db, table, p0)
                                .filePathsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.transaction == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (Transaction, $$TransactionsTableReferences),
    Transaction,
    PrefetchHooks Function(
        {bool dr, bool cr, bool profile, bool filePathsRefs})>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String deviceID,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> deviceID,
});

class $$UsersTableFilterComposer extends Composer<_$MyDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceID => $composableBuilder(
      column: $table.deviceID, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer extends Composer<_$MyDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceID => $composableBuilder(
      column: $table.deviceID, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$MyDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get deviceID =>
      $composableBuilder(column: $table.deviceID, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$MyDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$MyDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$MyDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> deviceID = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            deviceID: deviceID,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String deviceID,
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            deviceID: deviceID,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$MyDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$BanksTableCreateCompanionBuilder = BanksCompanion Function({
  Value<int> id,
  required int account,
  Value<String?> holderName,
  Value<String?> institution,
  Value<String?> branch,
  Value<String?> branchCode,
  Value<String?> accountNo,
});
typedef $$BanksTableUpdateCompanionBuilder = BanksCompanion Function({
  Value<int> id,
  Value<int> account,
  Value<String?> holderName,
  Value<String?> institution,
  Value<String?> branch,
  Value<String?> branchCode,
  Value<String?> accountNo,
});

final class $$BanksTableReferences
    extends BaseReferences<_$MyDatabase, $BanksTable, Bank> {
  $$BanksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.banks.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BanksTableFilterComposer extends Composer<_$MyDatabase, $BanksTable> {
  $$BanksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get holderName => $composableBuilder(
      column: $table.holderName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branch => $composableBuilder(
      column: $table.branch, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchCode => $composableBuilder(
      column: $table.branchCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountNo => $composableBuilder(
      column: $table.accountNo, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BanksTableOrderingComposer extends Composer<_$MyDatabase, $BanksTable> {
  $$BanksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get holderName => $composableBuilder(
      column: $table.holderName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branch => $composableBuilder(
      column: $table.branch, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchCode => $composableBuilder(
      column: $table.branchCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountNo => $composableBuilder(
      column: $table.accountNo, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BanksTableAnnotationComposer
    extends Composer<_$MyDatabase, $BanksTable> {
  $$BanksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get holderName => $composableBuilder(
      column: $table.holderName, builder: (column) => column);

  GeneratedColumn<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => column);

  GeneratedColumn<String> get branch =>
      $composableBuilder(column: $table.branch, builder: (column) => column);

  GeneratedColumn<String> get branchCode => $composableBuilder(
      column: $table.branchCode, builder: (column) => column);

  GeneratedColumn<String> get accountNo =>
      $composableBuilder(column: $table.accountNo, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BanksTableTableManager extends RootTableManager<
    _$MyDatabase,
    $BanksTable,
    Bank,
    $$BanksTableFilterComposer,
    $$BanksTableOrderingComposer,
    $$BanksTableAnnotationComposer,
    $$BanksTableCreateCompanionBuilder,
    $$BanksTableUpdateCompanionBuilder,
    (Bank, $$BanksTableReferences),
    Bank,
    PrefetchHooks Function({bool account})> {
  $$BanksTableTableManager(_$MyDatabase db, $BanksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BanksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BanksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BanksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<String?> holderName = const Value.absent(),
            Value<String?> institution = const Value.absent(),
            Value<String?> branch = const Value.absent(),
            Value<String?> branchCode = const Value.absent(),
            Value<String?> accountNo = const Value.absent(),
          }) =>
              BanksCompanion(
            id: id,
            account: account,
            holderName: holderName,
            institution: institution,
            branch: branch,
            branchCode: branchCode,
            accountNo: accountNo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            Value<String?> holderName = const Value.absent(),
            Value<String?> institution = const Value.absent(),
            Value<String?> branch = const Value.absent(),
            Value<String?> branchCode = const Value.absent(),
            Value<String?> accountNo = const Value.absent(),
          }) =>
              BanksCompanion.insert(
            id: id,
            account: account,
            holderName: holderName,
            institution: institution,
            branch: branch,
            branchCode: branchCode,
            accountNo: accountNo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BanksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({account = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable: $$BanksTableReferences._accountTable(db),
                    referencedColumn:
                        $$BanksTableReferences._accountTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BanksTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $BanksTable,
    Bank,
    $$BanksTableFilterComposer,
    $$BanksTableOrderingComposer,
    $$BanksTableAnnotationComposer,
    $$BanksTableCreateCompanionBuilder,
    $$BanksTableUpdateCompanionBuilder,
    (Bank, $$BanksTableReferences),
    Bank,
    PrefetchHooks Function({bool account})>;
typedef $$WalletsTableCreateCompanionBuilder = WalletsCompanion Function({
  Value<int> id,
  required int account,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});
typedef $$WalletsTableUpdateCompanionBuilder = WalletsCompanion Function({
  Value<int> id,
  Value<int> account,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});

final class $$WalletsTableReferences
    extends BaseReferences<_$MyDatabase, $WalletsTable, Wallet> {
  $$WalletsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.wallets.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WalletsTableFilterComposer
    extends Composer<_$MyDatabase, $WalletsTable> {
  $$WalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableOrderingComposer
    extends Composer<_$MyDatabase, $WalletsTable> {
  $$WalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableAnnotationComposer
    extends Composer<_$MyDatabase, $WalletsTable> {
  $$WalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableAnnotationComposer,
    $$WalletsTableCreateCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder,
    (Wallet, $$WalletsTableReferences),
    Wallet,
    PrefetchHooks Function({bool account})> {
  $$WalletsTableTableManager(_$MyDatabase db, $WalletsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              WalletsCompanion(
            id: id,
            account: account,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              WalletsCompanion.insert(
            id: id,
            account: account,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WalletsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({account = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable: $$WalletsTableReferences._accountTable(db),
                    referencedColumn:
                        $$WalletsTableReferences._accountTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WalletsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableAnnotationComposer,
    $$WalletsTableCreateCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder,
    (Wallet, $$WalletsTableReferences),
    Wallet,
    PrefetchHooks Function({bool account})>;
typedef $$LoansTableCreateCompanionBuilder = LoansCompanion Function({
  Value<int> id,
  required int account,
  Value<String?> institution,
  Value<double?> interestRate,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> agreementNo,
  Value<String?> accountNo,
});
typedef $$LoansTableUpdateCompanionBuilder = LoansCompanion Function({
  Value<int> id,
  Value<int> account,
  Value<String?> institution,
  Value<double?> interestRate,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> agreementNo,
  Value<String?> accountNo,
});

final class $$LoansTableReferences
    extends BaseReferences<_$MyDatabase, $LoansTable, Loan> {
  $$LoansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.loans.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LoansTableFilterComposer extends Composer<_$MyDatabase, $LoansTable> {
  $$LoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agreementNo => $composableBuilder(
      column: $table.agreementNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountNo => $composableBuilder(
      column: $table.accountNo, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoansTableOrderingComposer extends Composer<_$MyDatabase, $LoansTable> {
  $$LoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get interestRate => $composableBuilder(
      column: $table.interestRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agreementNo => $composableBuilder(
      column: $table.agreementNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountNo => $composableBuilder(
      column: $table.accountNo, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoansTableAnnotationComposer
    extends Composer<_$MyDatabase, $LoansTable> {
  $$LoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => column);

  GeneratedColumn<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get agreementNo => $composableBuilder(
      column: $table.agreementNo, builder: (column) => column);

  GeneratedColumn<String> get accountNo =>
      $composableBuilder(column: $table.accountNo, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LoansTableTableManager extends RootTableManager<
    _$MyDatabase,
    $LoansTable,
    Loan,
    $$LoansTableFilterComposer,
    $$LoansTableOrderingComposer,
    $$LoansTableAnnotationComposer,
    $$LoansTableCreateCompanionBuilder,
    $$LoansTableUpdateCompanionBuilder,
    (Loan, $$LoansTableReferences),
    Loan,
    PrefetchHooks Function({bool account})> {
  $$LoansTableTableManager(_$MyDatabase db, $LoansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<String?> institution = const Value.absent(),
            Value<double?> interestRate = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> agreementNo = const Value.absent(),
            Value<String?> accountNo = const Value.absent(),
          }) =>
              LoansCompanion(
            id: id,
            account: account,
            institution: institution,
            interestRate: interestRate,
            startDate: startDate,
            endDate: endDate,
            agreementNo: agreementNo,
            accountNo: accountNo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            Value<String?> institution = const Value.absent(),
            Value<double?> interestRate = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> agreementNo = const Value.absent(),
            Value<String?> accountNo = const Value.absent(),
          }) =>
              LoansCompanion.insert(
            id: id,
            account: account,
            institution: institution,
            interestRate: interestRate,
            startDate: startDate,
            endDate: endDate,
            agreementNo: agreementNo,
            accountNo: accountNo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LoansTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({account = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable: $$LoansTableReferences._accountTable(db),
                    referencedColumn:
                        $$LoansTableReferences._accountTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LoansTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $LoansTable,
    Loan,
    $$LoansTableFilterComposer,
    $$LoansTableOrderingComposer,
    $$LoansTableAnnotationComposer,
    $$LoansTableCreateCompanionBuilder,
    $$LoansTableUpdateCompanionBuilder,
    (Loan, $$LoansTableReferences),
    Loan,
    PrefetchHooks Function({bool account})>;
typedef $$CCardsTableCreateCompanionBuilder = CCardsCompanion Function({
  Value<int> id,
  required int account,
  Value<String?> institution,
  Value<int?> statementDate,
  Value<String?> cardNo,
  Value<String?> cardNetwork,
});
typedef $$CCardsTableUpdateCompanionBuilder = CCardsCompanion Function({
  Value<int> id,
  Value<int> account,
  Value<String?> institution,
  Value<int?> statementDate,
  Value<String?> cardNo,
  Value<String?> cardNetwork,
});

final class $$CCardsTableReferences
    extends BaseReferences<_$MyDatabase, $CCardsTable, CCard> {
  $$CCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.cCards.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CCardsTableFilterComposer extends Composer<_$MyDatabase, $CCardsTable> {
  $$CCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get statementDate => $composableBuilder(
      column: $table.statementDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardNo => $composableBuilder(
      column: $table.cardNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardNetwork => $composableBuilder(
      column: $table.cardNetwork, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CCardsTableOrderingComposer
    extends Composer<_$MyDatabase, $CCardsTable> {
  $$CCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get statementDate => $composableBuilder(
      column: $table.statementDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardNo => $composableBuilder(
      column: $table.cardNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardNetwork => $composableBuilder(
      column: $table.cardNetwork, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CCardsTableAnnotationComposer
    extends Composer<_$MyDatabase, $CCardsTable> {
  $$CCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get institution => $composableBuilder(
      column: $table.institution, builder: (column) => column);

  GeneratedColumn<int> get statementDate => $composableBuilder(
      column: $table.statementDate, builder: (column) => column);

  GeneratedColumn<String> get cardNo =>
      $composableBuilder(column: $table.cardNo, builder: (column) => column);

  GeneratedColumn<String> get cardNetwork => $composableBuilder(
      column: $table.cardNetwork, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CCardsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $CCardsTable,
    CCard,
    $$CCardsTableFilterComposer,
    $$CCardsTableOrderingComposer,
    $$CCardsTableAnnotationComposer,
    $$CCardsTableCreateCompanionBuilder,
    $$CCardsTableUpdateCompanionBuilder,
    (CCard, $$CCardsTableReferences),
    CCard,
    PrefetchHooks Function({bool account})> {
  $$CCardsTableTableManager(_$MyDatabase db, $CCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<String?> institution = const Value.absent(),
            Value<int?> statementDate = const Value.absent(),
            Value<String?> cardNo = const Value.absent(),
            Value<String?> cardNetwork = const Value.absent(),
          }) =>
              CCardsCompanion(
            id: id,
            account: account,
            institution: institution,
            statementDate: statementDate,
            cardNo: cardNo,
            cardNetwork: cardNetwork,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            Value<String?> institution = const Value.absent(),
            Value<int?> statementDate = const Value.absent(),
            Value<String?> cardNo = const Value.absent(),
            Value<String?> cardNetwork = const Value.absent(),
          }) =>
              CCardsCompanion.insert(
            id: id,
            account: account,
            institution: institution,
            statementDate: statementDate,
            cardNo: cardNo,
            cardNetwork: cardNetwork,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CCardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({account = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable: $$CCardsTableReferences._accountTable(db),
                    referencedColumn:
                        $$CCardsTableReferences._accountTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CCardsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $CCardsTable,
    CCard,
    $$CCardsTableFilterComposer,
    $$CCardsTableOrderingComposer,
    $$CCardsTableAnnotationComposer,
    $$CCardsTableCreateCompanionBuilder,
    $$CCardsTableUpdateCompanionBuilder,
    (CCard, $$CCardsTableReferences),
    CCard,
    PrefetchHooks Function({bool account})>;
typedef $$BalancesTableCreateCompanionBuilder = BalancesCompanion Function({
  Value<int> id,
  required int account,
  Value<int> amount,
});
typedef $$BalancesTableUpdateCompanionBuilder = BalancesCompanion Function({
  Value<int> id,
  Value<int> account,
  Value<int> amount,
});

final class $$BalancesTableReferences
    extends BaseReferences<_$MyDatabase, $BalancesTable, Balance> {
  $$BalancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.balances.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BalancesTableFilterComposer
    extends Composer<_$MyDatabase, $BalancesTable> {
  $$BalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalancesTableOrderingComposer
    extends Composer<_$MyDatabase, $BalancesTable> {
  $$BalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalancesTableAnnotationComposer
    extends Composer<_$MyDatabase, $BalancesTable> {
  $$BalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BalancesTableTableManager extends RootTableManager<
    _$MyDatabase,
    $BalancesTable,
    Balance,
    $$BalancesTableFilterComposer,
    $$BalancesTableOrderingComposer,
    $$BalancesTableAnnotationComposer,
    $$BalancesTableCreateCompanionBuilder,
    $$BalancesTableUpdateCompanionBuilder,
    (Balance, $$BalancesTableReferences),
    Balance,
    PrefetchHooks Function({bool account})> {
  $$BalancesTableTableManager(_$MyDatabase db, $BalancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BalancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<int> amount = const Value.absent(),
          }) =>
              BalancesCompanion(
            id: id,
            account: account,
            amount: amount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            Value<int> amount = const Value.absent(),
          }) =>
              BalancesCompanion.insert(
            id: id,
            account: account,
            amount: amount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BalancesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({account = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable:
                        $$BalancesTableReferences._accountTable(db),
                    referencedColumn:
                        $$BalancesTableReferences._accountTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BalancesTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $BalancesTable,
    Balance,
    $$BalancesTableFilterComposer,
    $$BalancesTableOrderingComposer,
    $$BalancesTableAnnotationComposer,
    $$BalancesTableCreateCompanionBuilder,
    $$BalancesTableUpdateCompanionBuilder,
    (Balance, $$BalancesTableReferences),
    Balance,
    PrefetchHooks Function({bool account})>;
typedef $$FilePathsTableCreateCompanionBuilder = FilePathsCompanion Function({
  Value<int> id,
  required int transaction,
  Value<String?> path,
});
typedef $$FilePathsTableUpdateCompanionBuilder = FilePathsCompanion Function({
  Value<int> id,
  Value<int> transaction,
  Value<String?> path,
});

final class $$FilePathsTableReferences
    extends BaseReferences<_$MyDatabase, $FilePathsTable, FilePath> {
  $$FilePathsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TransactionsTable _transactionTable(_$MyDatabase db) =>
      db.transactions.createAlias(
          $_aliasNameGenerator(db.filePaths.transaction, db.transactions.id));

  $$TransactionsTableProcessedTableManager get transaction {
    final $_column = $_itemColumn<int>('transaction')!;

    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FilePathsTableFilterComposer
    extends Composer<_$MyDatabase, $FilePathsTable> {
  $$FilePathsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  $$TransactionsTableFilterComposer get transaction {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transaction,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FilePathsTableOrderingComposer
    extends Composer<_$MyDatabase, $FilePathsTable> {
  $$FilePathsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  $$TransactionsTableOrderingComposer get transaction {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transaction,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableOrderingComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FilePathsTableAnnotationComposer
    extends Composer<_$MyDatabase, $FilePathsTable> {
  $$FilePathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transaction {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.transaction,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FilePathsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $FilePathsTable,
    FilePath,
    $$FilePathsTableFilterComposer,
    $$FilePathsTableOrderingComposer,
    $$FilePathsTableAnnotationComposer,
    $$FilePathsTableCreateCompanionBuilder,
    $$FilePathsTableUpdateCompanionBuilder,
    (FilePath, $$FilePathsTableReferences),
    FilePath,
    PrefetchHooks Function({bool transaction})> {
  $$FilePathsTableTableManager(_$MyDatabase db, $FilePathsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilePathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilePathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilePathsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> transaction = const Value.absent(),
            Value<String?> path = const Value.absent(),
          }) =>
              FilePathsCompanion(
            id: id,
            transaction: transaction,
            path: path,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int transaction,
            Value<String?> path = const Value.absent(),
          }) =>
              FilePathsCompanion.insert(
            id: id,
            transaction: transaction,
            path: path,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FilePathsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({transaction = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (transaction) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.transaction,
                    referencedTable:
                        $$FilePathsTableReferences._transactionTable(db),
                    referencedColumn:
                        $$FilePathsTableReferences._transactionTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FilePathsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $FilePathsTable,
    FilePath,
    $$FilePathsTableFilterComposer,
    $$FilePathsTableOrderingComposer,
    $$FilePathsTableAnnotationComposer,
    $$FilePathsTableCreateCompanionBuilder,
    $$FilePathsTableUpdateCompanionBuilder,
    (FilePath, $$FilePathsTableReferences),
    FilePath,
    PrefetchHooks Function({bool transaction})>;
typedef $$BudgetsTableCreateCompanionBuilder = BudgetsCompanion Function({
  Value<int> id,
  required String name,
  required BudgetInterval interval,
  required String details,
  Value<int> startDay,
  Value<DateTime> startDate,
  required int profile,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});
typedef $$BudgetsTableUpdateCompanionBuilder = BudgetsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<BudgetInterval> interval,
  Value<String> details,
  Value<int> startDay,
  Value<DateTime> startDate,
  Value<int> profile,
  Value<DateTime> addedDate,
  Value<DateTime> updateDate,
});

final class $$BudgetsTableReferences
    extends BaseReferences<_$MyDatabase, $BudgetsTable, Budget> {
  $$BudgetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileTable(_$MyDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.budgets.profile, db.profiles.id));

  $$ProfilesTableProcessedTableManager get profile {
    final $_column = $_itemColumn<int>('profile')!;

    final manager = $$ProfilesTableTableManager($_db, $_db.profiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BudgetAccountsTable, List<BudgetAccount>>
      _budgetAccountsRefsTable(_$MyDatabase db) =>
          MultiTypedResultKey.fromTable(db.budgetAccounts,
              aliasName: $_aliasNameGenerator(
                  db.budgets.id, db.budgetAccounts.budget));

  $$BudgetAccountsTableProcessedTableManager get budgetAccountsRefs {
    final manager = $$BudgetAccountsTableTableManager($_db, $_db.budgetAccounts)
        .filter((f) => f.budget.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetAccountsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BudgetFundsTable, List<BudgetFund>>
      _budgetFundsRefsTable(_$MyDatabase db) =>
          MultiTypedResultKey.fromTable(db.budgetFunds,
              aliasName:
                  $_aliasNameGenerator(db.budgets.id, db.budgetFunds.budget));

  $$BudgetFundsTableProcessedTableManager get budgetFundsRefs {
    final manager = $$BudgetFundsTableTableManager($_db, $_db.budgetFunds)
        .filter((f) => f.budget.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetFundsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BudgetsTableFilterComposer
    extends Composer<_$MyDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BudgetInterval, BudgetInterval, int>
      get interval => $composableBuilder(
          column: $table.interval,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startDay => $composableBuilder(
      column: $table.startDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnFilters(column));

  $$ProfilesTableFilterComposer get profile {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableFilterComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> budgetAccountsRefs(
      Expression<bool> Function($$BudgetAccountsTableFilterComposer f) f) {
    final $$BudgetAccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetAccounts,
        getReferencedColumn: (t) => t.budget,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetAccountsTableFilterComposer(
              $db: $db,
              $table: $db.budgetAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> budgetFundsRefs(
      Expression<bool> Function($$BudgetFundsTableFilterComposer f) f) {
    final $$BudgetFundsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetFunds,
        getReferencedColumn: (t) => t.budget,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetFundsTableFilterComposer(
              $db: $db,
              $table: $db.budgetFunds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$MyDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get interval => $composableBuilder(
      column: $table.interval, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startDay => $composableBuilder(
      column: $table.startDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
      column: $table.addedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => ColumnOrderings(column));

  $$ProfilesTableOrderingComposer get profile {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$MyDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BudgetInterval, int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<int> get startDay =>
      $composableBuilder(column: $table.startDay, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updateDate => $composableBuilder(
      column: $table.updateDate, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profile {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profile,
        referencedTable: $db.profiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.profiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> budgetAccountsRefs<T extends Object>(
      Expression<T> Function($$BudgetAccountsTableAnnotationComposer a) f) {
    final $$BudgetAccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetAccounts,
        getReferencedColumn: (t) => t.budget,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetAccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgetAccounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> budgetFundsRefs<T extends Object>(
      Expression<T> Function($$BudgetFundsTableAnnotationComposer a) f) {
    final $$BudgetFundsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.budgetFunds,
        getReferencedColumn: (t) => t.budget,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetFundsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgetFunds,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BudgetsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $BudgetsTable,
    Budget,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (Budget, $$BudgetsTableReferences),
    Budget,
    PrefetchHooks Function(
        {bool profile, bool budgetAccountsRefs, bool budgetFundsRefs})> {
  $$BudgetsTableTableManager(_$MyDatabase db, $BudgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<BudgetInterval> interval = const Value.absent(),
            Value<String> details = const Value.absent(),
            Value<int> startDay = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<int> profile = const Value.absent(),
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              BudgetsCompanion(
            id: id,
            name: name,
            interval: interval,
            details: details,
            startDay: startDay,
            startDate: startDate,
            profile: profile,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required BudgetInterval interval,
            required String details,
            Value<int> startDay = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            required int profile,
            Value<DateTime> addedDate = const Value.absent(),
            Value<DateTime> updateDate = const Value.absent(),
          }) =>
              BudgetsCompanion.insert(
            id: id,
            name: name,
            interval: interval,
            details: details,
            startDay: startDay,
            startDate: startDate,
            profile: profile,
            addedDate: addedDate,
            updateDate: updateDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BudgetsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {profile = false,
              budgetAccountsRefs = false,
              budgetFundsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (budgetAccountsRefs) db.budgetAccounts,
                if (budgetFundsRefs) db.budgetFunds
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (profile) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.profile,
                    referencedTable: $$BudgetsTableReferences._profileTable(db),
                    referencedColumn:
                        $$BudgetsTableReferences._profileTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetAccountsRefs)
                    await $_getPrefetchedData<Budget, $BudgetsTable,
                            BudgetAccount>(
                        currentTable: table,
                        referencedTable: $$BudgetsTableReferences
                            ._budgetAccountsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BudgetsTableReferences(db, table, p0)
                                .budgetAccountsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.budget == item.id),
                        typedResults: items),
                  if (budgetFundsRefs)
                    await $_getPrefetchedData<Budget, $BudgetsTable,
                            BudgetFund>(
                        currentTable: table,
                        referencedTable:
                            $$BudgetsTableReferences._budgetFundsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BudgetsTableReferences(db, table, p0)
                                .budgetFundsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.budget == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BudgetsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $BudgetsTable,
    Budget,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (Budget, $$BudgetsTableReferences),
    Budget,
    PrefetchHooks Function(
        {bool profile, bool budgetAccountsRefs, bool budgetFundsRefs})>;
typedef $$BudgetAccountsTableCreateCompanionBuilder = BudgetAccountsCompanion
    Function({
  Value<int> id,
  required int account,
  required int budget,
  Value<int> amount,
});
typedef $$BudgetAccountsTableUpdateCompanionBuilder = BudgetAccountsCompanion
    Function({
  Value<int> id,
  Value<int> account,
  Value<int> budget,
  Value<int> amount,
});

final class $$BudgetAccountsTableReferences
    extends BaseReferences<_$MyDatabase, $BudgetAccountsTable, BudgetAccount> {
  $$BudgetAccountsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) =>
      db.accounts.createAlias(
          $_aliasNameGenerator(db.budgetAccounts.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BudgetsTable _budgetTable(_$MyDatabase db) => db.budgets.createAlias(
      $_aliasNameGenerator(db.budgetAccounts.budget, db.budgets.id));

  $$BudgetsTableProcessedTableManager get budget {
    final $_column = $_itemColumn<int>('budget')!;

    final manager = $$BudgetsTableTableManager($_db, $_db.budgets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_budgetTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BudgetAccountsTableFilterComposer
    extends Composer<_$MyDatabase, $BudgetAccountsTable> {
  $$BudgetAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableFilterComposer get budget {
    final $$BudgetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableFilterComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetAccountsTableOrderingComposer
    extends Composer<_$MyDatabase, $BudgetAccountsTable> {
  $$BudgetAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableOrderingComposer get budget {
    final $$BudgetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableOrderingComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetAccountsTableAnnotationComposer
    extends Composer<_$MyDatabase, $BudgetAccountsTable> {
  $$BudgetAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableAnnotationComposer get budget {
    final $$BudgetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetAccountsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $BudgetAccountsTable,
    BudgetAccount,
    $$BudgetAccountsTableFilterComposer,
    $$BudgetAccountsTableOrderingComposer,
    $$BudgetAccountsTableAnnotationComposer,
    $$BudgetAccountsTableCreateCompanionBuilder,
    $$BudgetAccountsTableUpdateCompanionBuilder,
    (BudgetAccount, $$BudgetAccountsTableReferences),
    BudgetAccount,
    PrefetchHooks Function({bool account, bool budget})> {
  $$BudgetAccountsTableTableManager(_$MyDatabase db, $BudgetAccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<int> budget = const Value.absent(),
            Value<int> amount = const Value.absent(),
          }) =>
              BudgetAccountsCompanion(
            id: id,
            account: account,
            budget: budget,
            amount: amount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            required int budget,
            Value<int> amount = const Value.absent(),
          }) =>
              BudgetAccountsCompanion.insert(
            id: id,
            account: account,
            budget: budget,
            amount: amount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BudgetAccountsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({account = false, budget = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable:
                        $$BudgetAccountsTableReferences._accountTable(db),
                    referencedColumn:
                        $$BudgetAccountsTableReferences._accountTable(db).id,
                  ) as T;
                }
                if (budget) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.budget,
                    referencedTable:
                        $$BudgetAccountsTableReferences._budgetTable(db),
                    referencedColumn:
                        $$BudgetAccountsTableReferences._budgetTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BudgetAccountsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $BudgetAccountsTable,
    BudgetAccount,
    $$BudgetAccountsTableFilterComposer,
    $$BudgetAccountsTableOrderingComposer,
    $$BudgetAccountsTableAnnotationComposer,
    $$BudgetAccountsTableCreateCompanionBuilder,
    $$BudgetAccountsTableUpdateCompanionBuilder,
    (BudgetAccount, $$BudgetAccountsTableReferences),
    BudgetAccount,
    PrefetchHooks Function({bool account, bool budget})>;
typedef $$BudgetFundsTableCreateCompanionBuilder = BudgetFundsCompanion
    Function({
  Value<int> id,
  required int account,
  required int budget,
});
typedef $$BudgetFundsTableUpdateCompanionBuilder = BudgetFundsCompanion
    Function({
  Value<int> id,
  Value<int> account,
  Value<int> budget,
});

final class $$BudgetFundsTableReferences
    extends BaseReferences<_$MyDatabase, $BudgetFundsTable, BudgetFund> {
  $$BudgetFundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountTable(_$MyDatabase db) =>
      db.accounts.createAlias(
          $_aliasNameGenerator(db.budgetFunds.account, db.accounts.id));

  $$AccountsTableProcessedTableManager get account {
    final $_column = $_itemColumn<int>('account')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BudgetsTable _budgetTable(_$MyDatabase db) => db.budgets
      .createAlias($_aliasNameGenerator(db.budgetFunds.budget, db.budgets.id));

  $$BudgetsTableProcessedTableManager get budget {
    final $_column = $_itemColumn<int>('budget')!;

    final manager = $$BudgetsTableTableManager($_db, $_db.budgets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_budgetTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BudgetFundsTableFilterComposer
    extends Composer<_$MyDatabase, $BudgetFundsTable> {
  $$BudgetFundsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get account {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableFilterComposer get budget {
    final $$BudgetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableFilterComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetFundsTableOrderingComposer
    extends Composer<_$MyDatabase, $BudgetFundsTable> {
  $$BudgetFundsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get account {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableOrderingComposer get budget {
    final $$BudgetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableOrderingComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetFundsTableAnnotationComposer
    extends Composer<_$MyDatabase, $BudgetFundsTable> {
  $$BudgetFundsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$AccountsTableAnnotationComposer get account {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.account,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BudgetsTableAnnotationComposer get budget {
    final $$BudgetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.budget,
        referencedTable: $db.budgets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BudgetsTableAnnotationComposer(
              $db: $db,
              $table: $db.budgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BudgetFundsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $BudgetFundsTable,
    BudgetFund,
    $$BudgetFundsTableFilterComposer,
    $$BudgetFundsTableOrderingComposer,
    $$BudgetFundsTableAnnotationComposer,
    $$BudgetFundsTableCreateCompanionBuilder,
    $$BudgetFundsTableUpdateCompanionBuilder,
    (BudgetFund, $$BudgetFundsTableReferences),
    BudgetFund,
    PrefetchHooks Function({bool account, bool budget})> {
  $$BudgetFundsTableTableManager(_$MyDatabase db, $BudgetFundsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetFundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetFundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetFundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> account = const Value.absent(),
            Value<int> budget = const Value.absent(),
          }) =>
              BudgetFundsCompanion(
            id: id,
            account: account,
            budget: budget,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int account,
            required int budget,
          }) =>
              BudgetFundsCompanion.insert(
            id: id,
            account: account,
            budget: budget,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BudgetFundsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({account = false, budget = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (account) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.account,
                    referencedTable:
                        $$BudgetFundsTableReferences._accountTable(db),
                    referencedColumn:
                        $$BudgetFundsTableReferences._accountTable(db).id,
                  ) as T;
                }
                if (budget) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.budget,
                    referencedTable:
                        $$BudgetFundsTableReferences._budgetTable(db),
                    referencedColumn:
                        $$BudgetFundsTableReferences._budgetTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BudgetFundsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $BudgetFundsTable,
    BudgetFund,
    $$BudgetFundsTableFilterComposer,
    $$BudgetFundsTableOrderingComposer,
    $$BudgetFundsTableAnnotationComposer,
    $$BudgetFundsTableCreateCompanionBuilder,
    $$BudgetFundsTableUpdateCompanionBuilder,
    (BudgetFund, $$BudgetFundsTableReferences),
    BudgetFund,
    PrefetchHooks Function({bool account, bool budget})>;

class $MyDatabaseManager {
  final _$MyDatabase _db;
  $MyDatabaseManager(this._db);
  $$AccTypesTableTableManager get accTypes =>
      $$AccTypesTableTableManager(_db, _db.accTypes);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db, _db.banks);
  $$WalletsTableTableManager get wallets =>
      $$WalletsTableTableManager(_db, _db.wallets);
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db, _db.loans);
  $$CCardsTableTableManager get cCards =>
      $$CCardsTableTableManager(_db, _db.cCards);
  $$BalancesTableTableManager get balances =>
      $$BalancesTableTableManager(_db, _db.balances);
  $$FilePathsTableTableManager get filePaths =>
      $$FilePathsTableTableManager(_db, _db.filePaths);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$BudgetAccountsTableTableManager get budgetAccounts =>
      $$BudgetAccountsTableTableManager(_db, _db.budgetAccounts);
  $$BudgetFundsTableTableManager get budgetFunds =>
      $$BudgetFundsTableTableManager(_db, _db.budgetFunds);
}
