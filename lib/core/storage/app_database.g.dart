// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QuranProgressEntriesTable extends QuranProgressEntries
    with TableInfo<$QuranProgressEntriesTable, QuranProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNameArMeta = const VerificationMeta(
    'surahNameAr',
  );
  @override
  late final GeneratedColumn<String> surahNameAr = GeneratedColumn<String>(
    'surah_name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNameEnMeta = const VerificationMeta(
    'surahNameEn',
  );
  @override
  late final GeneratedColumn<String> surahNameEn = GeneratedColumn<String>(
    'surah_name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAyahsMeta = const VerificationMeta(
    'totalAyahs',
  );
  @override
  late final GeneratedColumn<int> totalAyahs = GeneratedColumn<int>(
    'total_ayahs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    surahNameAr,
    surahNameEn,
    ayahNumber,
    totalAyahs,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuranProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('surah_name_ar')) {
      context.handle(
        _surahNameArMeta,
        surahNameAr.isAcceptableOrUnknown(
          data['surah_name_ar']!,
          _surahNameArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNameArMeta);
    }
    if (data.containsKey('surah_name_en')) {
      context.handle(
        _surahNameEnMeta,
        surahNameEn.isAcceptableOrUnknown(
          data['surah_name_en']!,
          _surahNameEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNameEnMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('total_ayahs')) {
      context.handle(
        _totalAyahsMeta,
        totalAyahs.isAcceptableOrUnknown(data['total_ayahs']!, _totalAyahsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalAyahsMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuranProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranProgressEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      surahNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surah_name_ar'],
      )!,
      surahNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surah_name_en'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      totalAyahs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ayahs'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $QuranProgressEntriesTable createAlias(String alias) {
    return $QuranProgressEntriesTable(attachedDatabase, alias);
  }
}

class QuranProgressEntry extends DataClass
    implements Insertable<QuranProgressEntry> {
  final int id;
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final int ayahNumber;
  final int totalAyahs;
  final DateTime updatedAt;
  const QuranProgressEntry({
    required this.id,
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.ayahNumber,
    required this.totalAyahs,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['surah_name_ar'] = Variable<String>(surahNameAr);
    map['surah_name_en'] = Variable<String>(surahNameEn);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['total_ayahs'] = Variable<int>(totalAyahs);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  QuranProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return QuranProgressEntriesCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      surahNameAr: Value(surahNameAr),
      surahNameEn: Value(surahNameEn),
      ayahNumber: Value(ayahNumber),
      totalAyahs: Value(totalAyahs),
      updatedAt: Value(updatedAt),
    );
  }

  factory QuranProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranProgressEntry(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      surahNameAr: serializer.fromJson<String>(json['surahNameAr']),
      surahNameEn: serializer.fromJson<String>(json['surahNameEn']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      totalAyahs: serializer.fromJson<int>(json['totalAyahs']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'surahNameAr': serializer.toJson<String>(surahNameAr),
      'surahNameEn': serializer.toJson<String>(surahNameEn),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'totalAyahs': serializer.toJson<int>(totalAyahs),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  QuranProgressEntry copyWith({
    int? id,
    int? surahNumber,
    String? surahNameAr,
    String? surahNameEn,
    int? ayahNumber,
    int? totalAyahs,
    DateTime? updatedAt,
  }) => QuranProgressEntry(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    surahNameAr: surahNameAr ?? this.surahNameAr,
    surahNameEn: surahNameEn ?? this.surahNameEn,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    totalAyahs: totalAyahs ?? this.totalAyahs,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  QuranProgressEntry copyWithCompanion(QuranProgressEntriesCompanion data) {
    return QuranProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      surahNameAr: data.surahNameAr.present
          ? data.surahNameAr.value
          : this.surahNameAr,
      surahNameEn: data.surahNameEn.present
          ? data.surahNameEn.value
          : this.surahNameEn,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      totalAyahs: data.totalAyahs.present
          ? data.totalAyahs.value
          : this.totalAyahs,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranProgressEntry(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('surahNameAr: $surahNameAr, ')
          ..write('surahNameEn: $surahNameEn, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('totalAyahs: $totalAyahs, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahNumber,
    surahNameAr,
    surahNameEn,
    ayahNumber,
    totalAyahs,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranProgressEntry &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.surahNameAr == this.surahNameAr &&
          other.surahNameEn == this.surahNameEn &&
          other.ayahNumber == this.ayahNumber &&
          other.totalAyahs == this.totalAyahs &&
          other.updatedAt == this.updatedAt);
}

class QuranProgressEntriesCompanion
    extends UpdateCompanion<QuranProgressEntry> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<String> surahNameAr;
  final Value<String> surahNameEn;
  final Value<int> ayahNumber;
  final Value<int> totalAyahs;
  final Value<DateTime> updatedAt;
  const QuranProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.surahNameAr = const Value.absent(),
    this.surahNameEn = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.totalAyahs = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  QuranProgressEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required String surahNameAr,
    required String surahNameEn,
    required int ayahNumber,
    required int totalAyahs,
    this.updatedAt = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       surahNameAr = Value(surahNameAr),
       surahNameEn = Value(surahNameEn),
       ayahNumber = Value(ayahNumber),
       totalAyahs = Value(totalAyahs);
  static Insertable<QuranProgressEntry> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<String>? surahNameAr,
    Expression<String>? surahNameEn,
    Expression<int>? ayahNumber,
    Expression<int>? totalAyahs,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (surahNameAr != null) 'surah_name_ar': surahNameAr,
      if (surahNameEn != null) 'surah_name_en': surahNameEn,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (totalAyahs != null) 'total_ayahs': totalAyahs,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  QuranProgressEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<String>? surahNameAr,
    Value<String>? surahNameEn,
    Value<int>? ayahNumber,
    Value<int>? totalAyahs,
    Value<DateTime>? updatedAt,
  }) {
    return QuranProgressEntriesCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      surahNameAr: surahNameAr ?? this.surahNameAr,
      surahNameEn: surahNameEn ?? this.surahNameEn,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      totalAyahs: totalAyahs ?? this.totalAyahs,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (surahNameAr.present) {
      map['surah_name_ar'] = Variable<String>(surahNameAr.value);
    }
    if (surahNameEn.present) {
      map['surah_name_en'] = Variable<String>(surahNameEn.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (totalAyahs.present) {
      map['total_ayahs'] = Variable<int>(totalAyahs.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('surahNameAr: $surahNameAr, ')
          ..write('surahNameEn: $surahNameEn, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('totalAyahs: $totalAyahs, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyDeedEntriesTable extends DailyDeedEntries
    with TableInfo<$DailyDeedEntriesTable, DailyDeedEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyDeedEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deedTextEnMeta = const VerificationMeta(
    'deedTextEn',
  );
  @override
  late final GeneratedColumn<String> deedTextEn = GeneratedColumn<String>(
    'deed_text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deedTextArMeta = const VerificationMeta(
    'deedTextAr',
  );
  @override
  late final GeneratedColumn<String> deedTextAr = GeneratedColumn<String>(
    'deed_text_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    day,
    deedTextEn,
    deedTextAr,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_deed_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyDeedEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('deed_text_en')) {
      context.handle(
        _deedTextEnMeta,
        deedTextEn.isAcceptableOrUnknown(
          data['deed_text_en']!,
          _deedTextEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deedTextEnMeta);
    }
    if (data.containsKey('deed_text_ar')) {
      context.handle(
        _deedTextArMeta,
        deedTextAr.isAcceptableOrUnknown(
          data['deed_text_ar']!,
          _deedTextArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deedTextArMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day};
  @override
  DailyDeedEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyDeedEntry(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      deedTextEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deed_text_en'],
      )!,
      deedTextAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deed_text_ar'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $DailyDeedEntriesTable createAlias(String alias) {
    return $DailyDeedEntriesTable(attachedDatabase, alias);
  }
}

class DailyDeedEntry extends DataClass implements Insertable<DailyDeedEntry> {
  final DateTime day;
  final String deedTextEn;
  final String deedTextAr;
  final bool completed;
  const DailyDeedEntry({
    required this.day,
    required this.deedTextEn,
    required this.deedTextAr,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<DateTime>(day);
    map['deed_text_en'] = Variable<String>(deedTextEn);
    map['deed_text_ar'] = Variable<String>(deedTextAr);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  DailyDeedEntriesCompanion toCompanion(bool nullToAbsent) {
    return DailyDeedEntriesCompanion(
      day: Value(day),
      deedTextEn: Value(deedTextEn),
      deedTextAr: Value(deedTextAr),
      completed: Value(completed),
    );
  }

  factory DailyDeedEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyDeedEntry(
      day: serializer.fromJson<DateTime>(json['day']),
      deedTextEn: serializer.fromJson<String>(json['deedTextEn']),
      deedTextAr: serializer.fromJson<String>(json['deedTextAr']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<DateTime>(day),
      'deedTextEn': serializer.toJson<String>(deedTextEn),
      'deedTextAr': serializer.toJson<String>(deedTextAr),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  DailyDeedEntry copyWith({
    DateTime? day,
    String? deedTextEn,
    String? deedTextAr,
    bool? completed,
  }) => DailyDeedEntry(
    day: day ?? this.day,
    deedTextEn: deedTextEn ?? this.deedTextEn,
    deedTextAr: deedTextAr ?? this.deedTextAr,
    completed: completed ?? this.completed,
  );
  DailyDeedEntry copyWithCompanion(DailyDeedEntriesCompanion data) {
    return DailyDeedEntry(
      day: data.day.present ? data.day.value : this.day,
      deedTextEn: data.deedTextEn.present
          ? data.deedTextEn.value
          : this.deedTextEn,
      deedTextAr: data.deedTextAr.present
          ? data.deedTextAr.value
          : this.deedTextAr,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyDeedEntry(')
          ..write('day: $day, ')
          ..write('deedTextEn: $deedTextEn, ')
          ..write('deedTextAr: $deedTextAr, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(day, deedTextEn, deedTextAr, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyDeedEntry &&
          other.day == this.day &&
          other.deedTextEn == this.deedTextEn &&
          other.deedTextAr == this.deedTextAr &&
          other.completed == this.completed);
}

class DailyDeedEntriesCompanion extends UpdateCompanion<DailyDeedEntry> {
  final Value<DateTime> day;
  final Value<String> deedTextEn;
  final Value<String> deedTextAr;
  final Value<bool> completed;
  final Value<int> rowid;
  const DailyDeedEntriesCompanion({
    this.day = const Value.absent(),
    this.deedTextEn = const Value.absent(),
    this.deedTextAr = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyDeedEntriesCompanion.insert({
    required DateTime day,
    required String deedTextEn,
    required String deedTextAr,
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : day = Value(day),
       deedTextEn = Value(deedTextEn),
       deedTextAr = Value(deedTextAr);
  static Insertable<DailyDeedEntry> custom({
    Expression<DateTime>? day,
    Expression<String>? deedTextEn,
    Expression<String>? deedTextAr,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (deedTextEn != null) 'deed_text_en': deedTextEn,
      if (deedTextAr != null) 'deed_text_ar': deedTextAr,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyDeedEntriesCompanion copyWith({
    Value<DateTime>? day,
    Value<String>? deedTextEn,
    Value<String>? deedTextAr,
    Value<bool>? completed,
    Value<int>? rowid,
  }) {
    return DailyDeedEntriesCompanion(
      day: day ?? this.day,
      deedTextEn: deedTextEn ?? this.deedTextEn,
      deedTextAr: deedTextAr ?? this.deedTextAr,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (deedTextEn.present) {
      map['deed_text_en'] = Variable<String>(deedTextEn.value);
    }
    if (deedTextAr.present) {
      map['deed_text_ar'] = Variable<String>(deedTextAr.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyDeedEntriesCompanion(')
          ..write('day: $day, ')
          ..write('deedTextEn: $deedTextEn, ')
          ..write('deedTextAr: $deedTextAr, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedAyahsTable extends CachedAyahs
    with TableInfo<$CachedAyahsTable, CachedAyah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _globalNumberMeta = const VerificationMeta(
    'globalNumber',
  );
  @override
  late final GeneratedColumn<int> globalNumber = GeneratedColumn<int>(
    'global_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _juzMeta = const VerificationMeta('juz');
  @override
  late final GeneratedColumn<int> juz = GeneratedColumn<int>(
    'juz',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textArMeta = const VerificationMeta('textAr');
  @override
  late final GeneratedColumn<String> textAr = GeneratedColumn<String>(
    'text_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationEnMeta = const VerificationMeta(
    'translationEn',
  );
  @override
  late final GeneratedColumn<String> translationEn = GeneratedColumn<String>(
    'translation_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translatorNameMeta = const VerificationMeta(
    'translatorName',
  );
  @override
  late final GeneratedColumn<String> translatorName = GeneratedColumn<String>(
    'translator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    surahNumber,
    ayahNumber,
    globalNumber,
    juz,
    textAr,
    translationEn,
    translatorName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedAyah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('global_number')) {
      context.handle(
        _globalNumberMeta,
        globalNumber.isAcceptableOrUnknown(
          data['global_number']!,
          _globalNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_globalNumberMeta);
    }
    if (data.containsKey('juz')) {
      context.handle(
        _juzMeta,
        juz.isAcceptableOrUnknown(data['juz']!, _juzMeta),
      );
    } else if (isInserting) {
      context.missing(_juzMeta);
    }
    if (data.containsKey('text_ar')) {
      context.handle(
        _textArMeta,
        textAr.isAcceptableOrUnknown(data['text_ar']!, _textArMeta),
      );
    } else if (isInserting) {
      context.missing(_textArMeta);
    }
    if (data.containsKey('translation_en')) {
      context.handle(
        _translationEnMeta,
        translationEn.isAcceptableOrUnknown(
          data['translation_en']!,
          _translationEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationEnMeta);
    }
    if (data.containsKey('translator_name')) {
      context.handle(
        _translatorNameMeta,
        translatorName.isAcceptableOrUnknown(
          data['translator_name']!,
          _translatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translatorNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber, ayahNumber};
  @override
  CachedAyah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAyah(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      globalNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}global_number'],
      )!,
      juz: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz'],
      )!,
      textAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_ar'],
      )!,
      translationEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_en'],
      )!,
      translatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translator_name'],
      )!,
    );
  }

  @override
  $CachedAyahsTable createAlias(String alias) {
    return $CachedAyahsTable(attachedDatabase, alias);
  }
}

class CachedAyah extends DataClass implements Insertable<CachedAyah> {
  final int surahNumber;
  final int ayahNumber;

  /// Global ayah number (1–6236) — used for per-ayah recitation audio URLs.
  final int globalNumber;
  final int juz;
  final String textAr;
  final String translationEn;
  final String translatorName;
  const CachedAyah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.globalNumber,
    required this.juz,
    required this.textAr,
    required this.translationEn,
    required this.translatorName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['global_number'] = Variable<int>(globalNumber);
    map['juz'] = Variable<int>(juz);
    map['text_ar'] = Variable<String>(textAr);
    map['translation_en'] = Variable<String>(translationEn);
    map['translator_name'] = Variable<String>(translatorName);
    return map;
  }

  CachedAyahsCompanion toCompanion(bool nullToAbsent) {
    return CachedAyahsCompanion(
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      globalNumber: Value(globalNumber),
      juz: Value(juz),
      textAr: Value(textAr),
      translationEn: Value(translationEn),
      translatorName: Value(translatorName),
    );
  }

  factory CachedAyah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAyah(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      globalNumber: serializer.fromJson<int>(json['globalNumber']),
      juz: serializer.fromJson<int>(json['juz']),
      textAr: serializer.fromJson<String>(json['textAr']),
      translationEn: serializer.fromJson<String>(json['translationEn']),
      translatorName: serializer.fromJson<String>(json['translatorName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'globalNumber': serializer.toJson<int>(globalNumber),
      'juz': serializer.toJson<int>(juz),
      'textAr': serializer.toJson<String>(textAr),
      'translationEn': serializer.toJson<String>(translationEn),
      'translatorName': serializer.toJson<String>(translatorName),
    };
  }

  CachedAyah copyWith({
    int? surahNumber,
    int? ayahNumber,
    int? globalNumber,
    int? juz,
    String? textAr,
    String? translationEn,
    String? translatorName,
  }) => CachedAyah(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    globalNumber: globalNumber ?? this.globalNumber,
    juz: juz ?? this.juz,
    textAr: textAr ?? this.textAr,
    translationEn: translationEn ?? this.translationEn,
    translatorName: translatorName ?? this.translatorName,
  );
  CachedAyah copyWithCompanion(CachedAyahsCompanion data) {
    return CachedAyah(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      globalNumber: data.globalNumber.present
          ? data.globalNumber.value
          : this.globalNumber,
      juz: data.juz.present ? data.juz.value : this.juz,
      textAr: data.textAr.present ? data.textAr.value : this.textAr,
      translationEn: data.translationEn.present
          ? data.translationEn.value
          : this.translationEn,
      translatorName: data.translatorName.present
          ? data.translatorName.value
          : this.translatorName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAyah(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('globalNumber: $globalNumber, ')
          ..write('juz: $juz, ')
          ..write('textAr: $textAr, ')
          ..write('translationEn: $translationEn, ')
          ..write('translatorName: $translatorName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    surahNumber,
    ayahNumber,
    globalNumber,
    juz,
    textAr,
    translationEn,
    translatorName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAyah &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.globalNumber == this.globalNumber &&
          other.juz == this.juz &&
          other.textAr == this.textAr &&
          other.translationEn == this.translationEn &&
          other.translatorName == this.translatorName);
}

class CachedAyahsCompanion extends UpdateCompanion<CachedAyah> {
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> globalNumber;
  final Value<int> juz;
  final Value<String> textAr;
  final Value<String> translationEn;
  final Value<String> translatorName;
  final Value<int> rowid;
  const CachedAyahsCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.globalNumber = const Value.absent(),
    this.juz = const Value.absent(),
    this.textAr = const Value.absent(),
    this.translationEn = const Value.absent(),
    this.translatorName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAyahsCompanion.insert({
    required int surahNumber,
    required int ayahNumber,
    required int globalNumber,
    required int juz,
    required String textAr,
    required String translationEn,
    required String translatorName,
    this.rowid = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       globalNumber = Value(globalNumber),
       juz = Value(juz),
       textAr = Value(textAr),
       translationEn = Value(translationEn),
       translatorName = Value(translatorName);
  static Insertable<CachedAyah> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? globalNumber,
    Expression<int>? juz,
    Expression<String>? textAr,
    Expression<String>? translationEn,
    Expression<String>? translatorName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (globalNumber != null) 'global_number': globalNumber,
      if (juz != null) 'juz': juz,
      if (textAr != null) 'text_ar': textAr,
      if (translationEn != null) 'translation_en': translationEn,
      if (translatorName != null) 'translator_name': translatorName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAyahsCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<int>? globalNumber,
    Value<int>? juz,
    Value<String>? textAr,
    Value<String>? translationEn,
    Value<String>? translatorName,
    Value<int>? rowid,
  }) {
    return CachedAyahsCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      globalNumber: globalNumber ?? this.globalNumber,
      juz: juz ?? this.juz,
      textAr: textAr ?? this.textAr,
      translationEn: translationEn ?? this.translationEn,
      translatorName: translatorName ?? this.translatorName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (globalNumber.present) {
      map['global_number'] = Variable<int>(globalNumber.value);
    }
    if (juz.present) {
      map['juz'] = Variable<int>(juz.value);
    }
    if (textAr.present) {
      map['text_ar'] = Variable<String>(textAr.value);
    }
    if (translationEn.present) {
      map['translation_en'] = Variable<String>(translationEn.value);
    }
    if (translatorName.present) {
      map['translator_name'] = Variable<String>(translatorName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAyahsCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('globalNumber: $globalNumber, ')
          ..write('juz: $juz, ')
          ..write('textAr: $textAr, ')
          ..write('translationEn: $translationEn, ')
          ..write('translatorName: $translatorName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AyahBookmarksTable extends AyahBookmarks
    with TableInfo<$AyahBookmarksTable, AyahBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahBookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahBookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {surahNumber, ayahNumber},
  ];
  @override
  AyahBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahBookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AyahBookmarksTable createAlias(String alias) {
    return $AyahBookmarksTable(attachedDatabase, alias);
  }
}

class AyahBookmark extends DataClass implements Insertable<AyahBookmark> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final DateTime createdAt;
  const AyahBookmark({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AyahBookmarksCompanion toCompanion(bool nullToAbsent) {
    return AyahBookmarksCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      createdAt: Value(createdAt),
    );
  }

  factory AyahBookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahBookmark(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AyahBookmark copyWith({
    int? id,
    int? surahNumber,
    int? ayahNumber,
    DateTime? createdAt,
  }) => AyahBookmark(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  AyahBookmark copyWithCompanion(AyahBookmarksCompanion data) {
    return AyahBookmark(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahBookmark(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahNumber, ayahNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahBookmark &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.createdAt == this.createdAt);
}

class AyahBookmarksCompanion extends UpdateCompanion<AyahBookmark> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<DateTime> createdAt;
  const AyahBookmarksCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AyahBookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    this.createdAt = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber);
  static Insertable<AyahBookmark> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AyahBookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<DateTime>? createdAt,
  }) {
    return AyahBookmarksCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahBookmarksCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReflectionsTable extends Reflections
    with TableInfo<$ReflectionsTable, Reflection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReflectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    body,
    mood,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reflections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reflection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reflection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reflection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      ),
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReflectionsTable createAlias(String alias) {
    return $ReflectionsTable(attachedDatabase, alias);
  }
}

class Reflection extends DataClass implements Insertable<Reflection> {
  final int id;
  final int? surahNumber;
  final int? ayahNumber;
  final String body;
  final String? mood;
  final DateTime createdAt;
  const Reflection({
    required this.id,
    this.surahNumber,
    this.ayahNumber,
    required this.body,
    this.mood,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || surahNumber != null) {
      map['surah_number'] = Variable<int>(surahNumber);
    }
    if (!nullToAbsent || ayahNumber != null) {
      map['ayah_number'] = Variable<int>(ayahNumber);
    }
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReflectionsCompanion toCompanion(bool nullToAbsent) {
    return ReflectionsCompanion(
      id: Value(id),
      surahNumber: surahNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(surahNumber),
      ayahNumber: ayahNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(ayahNumber),
      body: Value(body),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      createdAt: Value(createdAt),
    );
  }

  factory Reflection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reflection(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int?>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int?>(json['ayahNumber']),
      body: serializer.fromJson<String>(json['body']),
      mood: serializer.fromJson<String?>(json['mood']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int?>(surahNumber),
      'ayahNumber': serializer.toJson<int?>(ayahNumber),
      'body': serializer.toJson<String>(body),
      'mood': serializer.toJson<String?>(mood),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reflection copyWith({
    int? id,
    Value<int?> surahNumber = const Value.absent(),
    Value<int?> ayahNumber = const Value.absent(),
    String? body,
    Value<String?> mood = const Value.absent(),
    DateTime? createdAt,
  }) => Reflection(
    id: id ?? this.id,
    surahNumber: surahNumber.present ? surahNumber.value : this.surahNumber,
    ayahNumber: ayahNumber.present ? ayahNumber.value : this.ayahNumber,
    body: body ?? this.body,
    mood: mood.present ? mood.value : this.mood,
    createdAt: createdAt ?? this.createdAt,
  );
  Reflection copyWithCompanion(ReflectionsCompanion data) {
    return Reflection(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      body: data.body.present ? data.body.value : this.body,
      mood: data.mood.present ? data.mood.value : this.mood,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reflection(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('body: $body, ')
          ..write('mood: $mood, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahNumber, ayahNumber, body, mood, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reflection &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.body == this.body &&
          other.mood == this.mood &&
          other.createdAt == this.createdAt);
}

class ReflectionsCompanion extends UpdateCompanion<Reflection> {
  final Value<int> id;
  final Value<int?> surahNumber;
  final Value<int?> ayahNumber;
  final Value<String> body;
  final Value<String?> mood;
  final Value<DateTime> createdAt;
  const ReflectionsCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.body = const Value.absent(),
    this.mood = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReflectionsCompanion.insert({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    required String body,
    this.mood = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : body = Value(body);
  static Insertable<Reflection> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? body,
    Expression<String>? mood,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (body != null) 'body': body,
      if (mood != null) 'mood': mood,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReflectionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? surahNumber,
    Value<int?>? ayahNumber,
    Value<String>? body,
    Value<String?>? mood,
    Value<DateTime>? createdAt,
  }) {
    return ReflectionsCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      body: body ?? this.body,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReflectionsCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('body: $body, ')
          ..write('mood: $mood, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DhikrLogsTable extends DhikrLogs
    with TableInfo<$DhikrLogsTable, DhikrLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DhikrLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dhikrKeyMeta = const VerificationMeta(
    'dhikrKey',
  );
  @override
  late final GeneratedColumn<String> dhikrKey = GeneratedColumn<String>(
    'dhikr_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [dhikrKey, day, count, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dhikr_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DhikrLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dhikr_key')) {
      context.handle(
        _dhikrKeyMeta,
        dhikrKey.isAcceptableOrUnknown(data['dhikr_key']!, _dhikrKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dhikrKeyMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dhikrKey, day};
  @override
  DhikrLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DhikrLog(
      dhikrKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dhikr_key'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DhikrLogsTable createAlias(String alias) {
    return $DhikrLogsTable(attachedDatabase, alias);
  }
}

class DhikrLog extends DataClass implements Insertable<DhikrLog> {
  final String dhikrKey;
  final DateTime day;
  final int count;
  final DateTime updatedAt;
  const DhikrLog({
    required this.dhikrKey,
    required this.day,
    required this.count,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dhikr_key'] = Variable<String>(dhikrKey);
    map['day'] = Variable<DateTime>(day);
    map['count'] = Variable<int>(count);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DhikrLogsCompanion toCompanion(bool nullToAbsent) {
    return DhikrLogsCompanion(
      dhikrKey: Value(dhikrKey),
      day: Value(day),
      count: Value(count),
      updatedAt: Value(updatedAt),
    );
  }

  factory DhikrLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DhikrLog(
      dhikrKey: serializer.fromJson<String>(json['dhikrKey']),
      day: serializer.fromJson<DateTime>(json['day']),
      count: serializer.fromJson<int>(json['count']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dhikrKey': serializer.toJson<String>(dhikrKey),
      'day': serializer.toJson<DateTime>(day),
      'count': serializer.toJson<int>(count),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DhikrLog copyWith({
    String? dhikrKey,
    DateTime? day,
    int? count,
    DateTime? updatedAt,
  }) => DhikrLog(
    dhikrKey: dhikrKey ?? this.dhikrKey,
    day: day ?? this.day,
    count: count ?? this.count,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DhikrLog copyWithCompanion(DhikrLogsCompanion data) {
    return DhikrLog(
      dhikrKey: data.dhikrKey.present ? data.dhikrKey.value : this.dhikrKey,
      day: data.day.present ? data.day.value : this.day,
      count: data.count.present ? data.count.value : this.count,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DhikrLog(')
          ..write('dhikrKey: $dhikrKey, ')
          ..write('day: $day, ')
          ..write('count: $count, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dhikrKey, day, count, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DhikrLog &&
          other.dhikrKey == this.dhikrKey &&
          other.day == this.day &&
          other.count == this.count &&
          other.updatedAt == this.updatedAt);
}

class DhikrLogsCompanion extends UpdateCompanion<DhikrLog> {
  final Value<String> dhikrKey;
  final Value<DateTime> day;
  final Value<int> count;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DhikrLogsCompanion({
    this.dhikrKey = const Value.absent(),
    this.day = const Value.absent(),
    this.count = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DhikrLogsCompanion.insert({
    required String dhikrKey,
    required DateTime day,
    this.count = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dhikrKey = Value(dhikrKey),
       day = Value(day);
  static Insertable<DhikrLog> custom({
    Expression<String>? dhikrKey,
    Expression<DateTime>? day,
    Expression<int>? count,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dhikrKey != null) 'dhikr_key': dhikrKey,
      if (day != null) 'day': day,
      if (count != null) 'count': count,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DhikrLogsCompanion copyWith({
    Value<String>? dhikrKey,
    Value<DateTime>? day,
    Value<int>? count,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DhikrLogsCompanion(
      dhikrKey: dhikrKey ?? this.dhikrKey,
      day: day ?? this.day,
      count: count ?? this.count,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dhikrKey.present) {
      map['dhikr_key'] = Variable<String>(dhikrKey.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DhikrLogsCompanion(')
          ..write('dhikrKey: $dhikrKey, ')
          ..write('day: $day, ')
          ..write('count: $count, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedDuasTable extends SavedDuas
    with TableInfo<$SavedDuasTable, SavedDua> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedDuasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _duaKeyMeta = const VerificationMeta('duaKey');
  @override
  late final GeneratedColumn<String> duaKey = GeneratedColumn<String>(
    'dua_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [duaKey, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_duas';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedDua> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dua_key')) {
      context.handle(
        _duaKeyMeta,
        duaKey.isAcceptableOrUnknown(data['dua_key']!, _duaKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_duaKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {duaKey};
  @override
  SavedDua map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedDua(
      duaKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dua_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SavedDuasTable createAlias(String alias) {
    return $SavedDuasTable(attachedDatabase, alias);
  }
}

class SavedDua extends DataClass implements Insertable<SavedDua> {
  final String duaKey;
  final DateTime createdAt;
  const SavedDua({required this.duaKey, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dua_key'] = Variable<String>(duaKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavedDuasCompanion toCompanion(bool nullToAbsent) {
    return SavedDuasCompanion(
      duaKey: Value(duaKey),
      createdAt: Value(createdAt),
    );
  }

  factory SavedDua.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedDua(
      duaKey: serializer.fromJson<String>(json['duaKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'duaKey': serializer.toJson<String>(duaKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavedDua copyWith({String? duaKey, DateTime? createdAt}) => SavedDua(
    duaKey: duaKey ?? this.duaKey,
    createdAt: createdAt ?? this.createdAt,
  );
  SavedDua copyWithCompanion(SavedDuasCompanion data) {
    return SavedDua(
      duaKey: data.duaKey.present ? data.duaKey.value : this.duaKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedDua(')
          ..write('duaKey: $duaKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(duaKey, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedDua &&
          other.duaKey == this.duaKey &&
          other.createdAt == this.createdAt);
}

class SavedDuasCompanion extends UpdateCompanion<SavedDua> {
  final Value<String> duaKey;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SavedDuasCompanion({
    this.duaKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedDuasCompanion.insert({
    required String duaKey,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : duaKey = Value(duaKey);
  static Insertable<SavedDua> custom({
    Expression<String>? duaKey,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (duaKey != null) 'dua_key': duaKey,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedDuasCompanion copyWith({
    Value<String>? duaKey,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SavedDuasCompanion(
      duaKey: duaKey ?? this.duaKey,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (duaKey.present) {
      map['dua_key'] = Variable<String>(duaKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedDuasCompanion(')
          ..write('duaKey: $duaKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrayerLogsTable extends PrayerLogs
    with TableInfo<$PrayerLogsTable, PrayerLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prayerMeta = const VerificationMeta('prayer');
  @override
  late final GeneratedColumn<String> prayer = GeneratedColumn<String>(
    'prayer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [day, prayer, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('prayer')) {
      context.handle(
        _prayerMeta,
        prayer.isAcceptableOrUnknown(data['prayer']!, _prayerMeta),
      );
    } else if (isInserting) {
      context.missing(_prayerMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day, prayer};
  @override
  PrayerLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerLog(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      prayer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $PrayerLogsTable createAlias(String alias) {
    return $PrayerLogsTable(attachedDatabase, alias);
  }
}

class PrayerLog extends DataClass implements Insertable<PrayerLog> {
  final DateTime day;

  /// `PrayerName.name` (fajr, dhuhr, asr, maghrib, isha).
  final String prayer;
  final bool completed;
  const PrayerLog({
    required this.day,
    required this.prayer,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<DateTime>(day);
    map['prayer'] = Variable<String>(prayer);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  PrayerLogsCompanion toCompanion(bool nullToAbsent) {
    return PrayerLogsCompanion(
      day: Value(day),
      prayer: Value(prayer),
      completed: Value(completed),
    );
  }

  factory PrayerLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerLog(
      day: serializer.fromJson<DateTime>(json['day']),
      prayer: serializer.fromJson<String>(json['prayer']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<DateTime>(day),
      'prayer': serializer.toJson<String>(prayer),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  PrayerLog copyWith({DateTime? day, String? prayer, bool? completed}) =>
      PrayerLog(
        day: day ?? this.day,
        prayer: prayer ?? this.prayer,
        completed: completed ?? this.completed,
      );
  PrayerLog copyWithCompanion(PrayerLogsCompanion data) {
    return PrayerLog(
      day: data.day.present ? data.day.value : this.day,
      prayer: data.prayer.present ? data.prayer.value : this.prayer,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLog(')
          ..write('day: $day, ')
          ..write('prayer: $prayer, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(day, prayer, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerLog &&
          other.day == this.day &&
          other.prayer == this.prayer &&
          other.completed == this.completed);
}

class PrayerLogsCompanion extends UpdateCompanion<PrayerLog> {
  final Value<DateTime> day;
  final Value<String> prayer;
  final Value<bool> completed;
  final Value<int> rowid;
  const PrayerLogsCompanion({
    this.day = const Value.absent(),
    this.prayer = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrayerLogsCompanion.insert({
    required DateTime day,
    required String prayer,
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : day = Value(day),
       prayer = Value(prayer);
  static Insertable<PrayerLog> custom({
    Expression<DateTime>? day,
    Expression<String>? prayer,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (prayer != null) 'prayer': prayer,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrayerLogsCompanion copyWith({
    Value<DateTime>? day,
    Value<String>? prayer,
    Value<bool>? completed,
    Value<int>? rowid,
  }) {
    return PrayerLogsCompanion(
      day: day ?? this.day,
      prayer: prayer ?? this.prayer,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (prayer.present) {
      map['prayer'] = Variable<String>(prayer.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLogsCompanion(')
          ..write('day: $day, ')
          ..write('prayer: $prayer, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingLogsTable extends ReadingLogs
    with TableInfo<$ReadingLogsTable, ReadingLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahsReadMeta = const VerificationMeta(
    'ayahsRead',
  );
  @override
  late final GeneratedColumn<int> ayahsRead = GeneratedColumn<int>(
    'ayahs_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [day, ayahsRead];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('ayahs_read')) {
      context.handle(
        _ayahsReadMeta,
        ayahsRead.isAcceptableOrUnknown(data['ayahs_read']!, _ayahsReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day};
  @override
  ReadingLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingLog(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      ayahsRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayahs_read'],
      )!,
    );
  }

  @override
  $ReadingLogsTable createAlias(String alias) {
    return $ReadingLogsTable(attachedDatabase, alias);
  }
}

class ReadingLog extends DataClass implements Insertable<ReadingLog> {
  final DateTime day;
  final int ayahsRead;
  const ReadingLog({required this.day, required this.ayahsRead});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<DateTime>(day);
    map['ayahs_read'] = Variable<int>(ayahsRead);
    return map;
  }

  ReadingLogsCompanion toCompanion(bool nullToAbsent) {
    return ReadingLogsCompanion(day: Value(day), ayahsRead: Value(ayahsRead));
  }

  factory ReadingLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingLog(
      day: serializer.fromJson<DateTime>(json['day']),
      ayahsRead: serializer.fromJson<int>(json['ayahsRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<DateTime>(day),
      'ayahsRead': serializer.toJson<int>(ayahsRead),
    };
  }

  ReadingLog copyWith({DateTime? day, int? ayahsRead}) =>
      ReadingLog(day: day ?? this.day, ayahsRead: ayahsRead ?? this.ayahsRead);
  ReadingLog copyWithCompanion(ReadingLogsCompanion data) {
    return ReadingLog(
      day: data.day.present ? data.day.value : this.day,
      ayahsRead: data.ayahsRead.present ? data.ayahsRead.value : this.ayahsRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingLog(')
          ..write('day: $day, ')
          ..write('ayahsRead: $ayahsRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(day, ayahsRead);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingLog &&
          other.day == this.day &&
          other.ayahsRead == this.ayahsRead);
}

class ReadingLogsCompanion extends UpdateCompanion<ReadingLog> {
  final Value<DateTime> day;
  final Value<int> ayahsRead;
  final Value<int> rowid;
  const ReadingLogsCompanion({
    this.day = const Value.absent(),
    this.ayahsRead = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingLogsCompanion.insert({
    required DateTime day,
    this.ayahsRead = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : day = Value(day);
  static Insertable<ReadingLog> custom({
    Expression<DateTime>? day,
    Expression<int>? ayahsRead,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (ayahsRead != null) 'ayahs_read': ayahsRead,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingLogsCompanion copyWith({
    Value<DateTime>? day,
    Value<int>? ayahsRead,
    Value<int>? rowid,
  }) {
    return ReadingLogsCompanion(
      day: day ?? this.day,
      ayahsRead: ayahsRead ?? this.ayahsRead,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (ayahsRead.present) {
      map['ayahs_read'] = Variable<int>(ayahsRead.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingLogsCompanion(')
          ..write('day: $day, ')
          ..write('ayahsRead: $ayahsRead, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuranProgressEntriesTable quranProgressEntries =
      $QuranProgressEntriesTable(this);
  late final $DailyDeedEntriesTable dailyDeedEntries = $DailyDeedEntriesTable(
    this,
  );
  late final $CachedAyahsTable cachedAyahs = $CachedAyahsTable(this);
  late final $AyahBookmarksTable ayahBookmarks = $AyahBookmarksTable(this);
  late final $ReflectionsTable reflections = $ReflectionsTable(this);
  late final $DhikrLogsTable dhikrLogs = $DhikrLogsTable(this);
  late final $SavedDuasTable savedDuas = $SavedDuasTable(this);
  late final $PrayerLogsTable prayerLogs = $PrayerLogsTable(this);
  late final $ReadingLogsTable readingLogs = $ReadingLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    quranProgressEntries,
    dailyDeedEntries,
    cachedAyahs,
    ayahBookmarks,
    reflections,
    dhikrLogs,
    savedDuas,
    prayerLogs,
    readingLogs,
  ];
}

typedef $$QuranProgressEntriesTableCreateCompanionBuilder =
    QuranProgressEntriesCompanion Function({
      Value<int> id,
      required int surahNumber,
      required String surahNameAr,
      required String surahNameEn,
      required int ayahNumber,
      required int totalAyahs,
      Value<DateTime> updatedAt,
    });
typedef $$QuranProgressEntriesTableUpdateCompanionBuilder =
    QuranProgressEntriesCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<String> surahNameAr,
      Value<String> surahNameEn,
      Value<int> ayahNumber,
      Value<int> totalAyahs,
      Value<DateTime> updatedAt,
    });

class $$QuranProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $QuranProgressEntriesTable> {
  $$QuranProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surahNameAr => $composableBuilder(
    column: $table.surahNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surahNameEn => $composableBuilder(
    column: $table.surahNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuranProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuranProgressEntriesTable> {
  $$QuranProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surahNameAr => $composableBuilder(
    column: $table.surahNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surahNameEn => $composableBuilder(
    column: $table.surahNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuranProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuranProgressEntriesTable> {
  $$QuranProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get surahNameAr => $composableBuilder(
    column: $table.surahNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get surahNameEn => $composableBuilder(
    column: $table.surahNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$QuranProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuranProgressEntriesTable,
          QuranProgressEntry,
          $$QuranProgressEntriesTableFilterComposer,
          $$QuranProgressEntriesTableOrderingComposer,
          $$QuranProgressEntriesTableAnnotationComposer,
          $$QuranProgressEntriesTableCreateCompanionBuilder,
          $$QuranProgressEntriesTableUpdateCompanionBuilder,
          (
            QuranProgressEntry,
            BaseReferences<
              _$AppDatabase,
              $QuranProgressEntriesTable,
              QuranProgressEntry
            >,
          ),
          QuranProgressEntry,
          PrefetchHooks Function()
        > {
  $$QuranProgressEntriesTableTableManager(
    _$AppDatabase db,
    $QuranProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuranProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<String> surahNameAr = const Value.absent(),
                Value<String> surahNameEn = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> totalAyahs = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => QuranProgressEntriesCompanion(
                id: id,
                surahNumber: surahNumber,
                surahNameAr: surahNameAr,
                surahNameEn: surahNameEn,
                ayahNumber: ayahNumber,
                totalAyahs: totalAyahs,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required String surahNameAr,
                required String surahNameEn,
                required int ayahNumber,
                required int totalAyahs,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => QuranProgressEntriesCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                surahNameAr: surahNameAr,
                surahNameEn: surahNameEn,
                ayahNumber: ayahNumber,
                totalAyahs: totalAyahs,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuranProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuranProgressEntriesTable,
      QuranProgressEntry,
      $$QuranProgressEntriesTableFilterComposer,
      $$QuranProgressEntriesTableOrderingComposer,
      $$QuranProgressEntriesTableAnnotationComposer,
      $$QuranProgressEntriesTableCreateCompanionBuilder,
      $$QuranProgressEntriesTableUpdateCompanionBuilder,
      (
        QuranProgressEntry,
        BaseReferences<
          _$AppDatabase,
          $QuranProgressEntriesTable,
          QuranProgressEntry
        >,
      ),
      QuranProgressEntry,
      PrefetchHooks Function()
    >;
typedef $$DailyDeedEntriesTableCreateCompanionBuilder =
    DailyDeedEntriesCompanion Function({
      required DateTime day,
      required String deedTextEn,
      required String deedTextAr,
      Value<bool> completed,
      Value<int> rowid,
    });
typedef $$DailyDeedEntriesTableUpdateCompanionBuilder =
    DailyDeedEntriesCompanion Function({
      Value<DateTime> day,
      Value<String> deedTextEn,
      Value<String> deedTextAr,
      Value<bool> completed,
      Value<int> rowid,
    });

class $$DailyDeedEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyDeedEntriesTable> {
  $$DailyDeedEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deedTextEn => $composableBuilder(
    column: $table.deedTextEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deedTextAr => $composableBuilder(
    column: $table.deedTextAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyDeedEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyDeedEntriesTable> {
  $$DailyDeedEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deedTextEn => $composableBuilder(
    column: $table.deedTextEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deedTextAr => $composableBuilder(
    column: $table.deedTextAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyDeedEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyDeedEntriesTable> {
  $$DailyDeedEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get deedTextEn => $composableBuilder(
    column: $table.deedTextEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deedTextAr => $composableBuilder(
    column: $table.deedTextAr,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$DailyDeedEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyDeedEntriesTable,
          DailyDeedEntry,
          $$DailyDeedEntriesTableFilterComposer,
          $$DailyDeedEntriesTableOrderingComposer,
          $$DailyDeedEntriesTableAnnotationComposer,
          $$DailyDeedEntriesTableCreateCompanionBuilder,
          $$DailyDeedEntriesTableUpdateCompanionBuilder,
          (
            DailyDeedEntry,
            BaseReferences<
              _$AppDatabase,
              $DailyDeedEntriesTable,
              DailyDeedEntry
            >,
          ),
          DailyDeedEntry,
          PrefetchHooks Function()
        > {
  $$DailyDeedEntriesTableTableManager(
    _$AppDatabase db,
    $DailyDeedEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyDeedEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyDeedEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyDeedEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> day = const Value.absent(),
                Value<String> deedTextEn = const Value.absent(),
                Value<String> deedTextAr = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyDeedEntriesCompanion(
                day: day,
                deedTextEn: deedTextEn,
                deedTextAr: deedTextAr,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime day,
                required String deedTextEn,
                required String deedTextAr,
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyDeedEntriesCompanion.insert(
                day: day,
                deedTextEn: deedTextEn,
                deedTextAr: deedTextAr,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyDeedEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyDeedEntriesTable,
      DailyDeedEntry,
      $$DailyDeedEntriesTableFilterComposer,
      $$DailyDeedEntriesTableOrderingComposer,
      $$DailyDeedEntriesTableAnnotationComposer,
      $$DailyDeedEntriesTableCreateCompanionBuilder,
      $$DailyDeedEntriesTableUpdateCompanionBuilder,
      (
        DailyDeedEntry,
        BaseReferences<_$AppDatabase, $DailyDeedEntriesTable, DailyDeedEntry>,
      ),
      DailyDeedEntry,
      PrefetchHooks Function()
    >;
typedef $$CachedAyahsTableCreateCompanionBuilder =
    CachedAyahsCompanion Function({
      required int surahNumber,
      required int ayahNumber,
      required int globalNumber,
      required int juz,
      required String textAr,
      required String translationEn,
      required String translatorName,
      Value<int> rowid,
    });
typedef $$CachedAyahsTableUpdateCompanionBuilder =
    CachedAyahsCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<int> globalNumber,
      Value<int> juz,
      Value<String> textAr,
      Value<String> translationEn,
      Value<String> translatorName,
      Value<int> rowid,
    });

class $$CachedAyahsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedAyahsTable> {
  $$CachedAyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get globalNumber => $composableBuilder(
    column: $table.globalNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textAr => $composableBuilder(
    column: $table.textAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedAyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedAyahsTable> {
  $$CachedAyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get globalNumber => $composableBuilder(
    column: $table.globalNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textAr => $composableBuilder(
    column: $table.textAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedAyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedAyahsTable> {
  $$CachedAyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get globalNumber => $composableBuilder(
    column: $table.globalNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get juz =>
      $composableBuilder(column: $table.juz, builder: (column) => column);

  GeneratedColumn<String> get textAr =>
      $composableBuilder(column: $table.textAr, builder: (column) => column);

  GeneratedColumn<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => column,
  );
}

class $$CachedAyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedAyahsTable,
          CachedAyah,
          $$CachedAyahsTableFilterComposer,
          $$CachedAyahsTableOrderingComposer,
          $$CachedAyahsTableAnnotationComposer,
          $$CachedAyahsTableCreateCompanionBuilder,
          $$CachedAyahsTableUpdateCompanionBuilder,
          (
            CachedAyah,
            BaseReferences<_$AppDatabase, $CachedAyahsTable, CachedAyah>,
          ),
          CachedAyah,
          PrefetchHooks Function()
        > {
  $$CachedAyahsTableTableManager(_$AppDatabase db, $CachedAyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedAyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedAyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> globalNumber = const Value.absent(),
                Value<int> juz = const Value.absent(),
                Value<String> textAr = const Value.absent(),
                Value<String> translationEn = const Value.absent(),
                Value<String> translatorName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedAyahsCompanion(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                globalNumber: globalNumber,
                juz: juz,
                textAr: textAr,
                translationEn: translationEn,
                translatorName: translatorName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int surahNumber,
                required int ayahNumber,
                required int globalNumber,
                required int juz,
                required String textAr,
                required String translationEn,
                required String translatorName,
                Value<int> rowid = const Value.absent(),
              }) => CachedAyahsCompanion.insert(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                globalNumber: globalNumber,
                juz: juz,
                textAr: textAr,
                translationEn: translationEn,
                translatorName: translatorName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedAyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedAyahsTable,
      CachedAyah,
      $$CachedAyahsTableFilterComposer,
      $$CachedAyahsTableOrderingComposer,
      $$CachedAyahsTableAnnotationComposer,
      $$CachedAyahsTableCreateCompanionBuilder,
      $$CachedAyahsTableUpdateCompanionBuilder,
      (
        CachedAyah,
        BaseReferences<_$AppDatabase, $CachedAyahsTable, CachedAyah>,
      ),
      CachedAyah,
      PrefetchHooks Function()
    >;
typedef $$AyahBookmarksTableCreateCompanionBuilder =
    AyahBookmarksCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int ayahNumber,
      Value<DateTime> createdAt,
    });
typedef $$AyahBookmarksTableUpdateCompanionBuilder =
    AyahBookmarksCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<DateTime> createdAt,
    });

class $$AyahBookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AyahBookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahBookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AyahBookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahBookmarksTable,
          AyahBookmark,
          $$AyahBookmarksTableFilterComposer,
          $$AyahBookmarksTableOrderingComposer,
          $$AyahBookmarksTableAnnotationComposer,
          $$AyahBookmarksTableCreateCompanionBuilder,
          $$AyahBookmarksTableUpdateCompanionBuilder,
          (
            AyahBookmark,
            BaseReferences<_$AppDatabase, $AyahBookmarksTable, AyahBookmark>,
          ),
          AyahBookmark,
          PrefetchHooks Function()
        > {
  $$AyahBookmarksTableTableManager(_$AppDatabase db, $AyahBookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahBookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahBookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahBookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AyahBookmarksCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                Value<DateTime> createdAt = const Value.absent(),
              }) => AyahBookmarksCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahBookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahBookmarksTable,
      AyahBookmark,
      $$AyahBookmarksTableFilterComposer,
      $$AyahBookmarksTableOrderingComposer,
      $$AyahBookmarksTableAnnotationComposer,
      $$AyahBookmarksTableCreateCompanionBuilder,
      $$AyahBookmarksTableUpdateCompanionBuilder,
      (
        AyahBookmark,
        BaseReferences<_$AppDatabase, $AyahBookmarksTable, AyahBookmark>,
      ),
      AyahBookmark,
      PrefetchHooks Function()
    >;
typedef $$ReflectionsTableCreateCompanionBuilder =
    ReflectionsCompanion Function({
      Value<int> id,
      Value<int?> surahNumber,
      Value<int?> ayahNumber,
      required String body,
      Value<String?> mood,
      Value<DateTime> createdAt,
    });
typedef $$ReflectionsTableUpdateCompanionBuilder =
    ReflectionsCompanion Function({
      Value<int> id,
      Value<int?> surahNumber,
      Value<int?> ayahNumber,
      Value<String> body,
      Value<String?> mood,
      Value<DateTime> createdAt,
    });

class $$ReflectionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReflectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReflectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReflectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReflectionsTable,
          Reflection,
          $$ReflectionsTableFilterComposer,
          $$ReflectionsTableOrderingComposer,
          $$ReflectionsTableAnnotationComposer,
          $$ReflectionsTableCreateCompanionBuilder,
          $$ReflectionsTableUpdateCompanionBuilder,
          (
            Reflection,
            BaseReferences<_$AppDatabase, $ReflectionsTable, Reflection>,
          ),
          Reflection,
          PrefetchHooks Function()
        > {
  $$ReflectionsTableTableManager(_$AppDatabase db, $ReflectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReflectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReflectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReflectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> surahNumber = const Value.absent(),
                Value<int?> ayahNumber = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReflectionsCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                body: body,
                mood: mood,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> surahNumber = const Value.absent(),
                Value<int?> ayahNumber = const Value.absent(),
                required String body,
                Value<String?> mood = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReflectionsCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                body: body,
                mood: mood,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReflectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReflectionsTable,
      Reflection,
      $$ReflectionsTableFilterComposer,
      $$ReflectionsTableOrderingComposer,
      $$ReflectionsTableAnnotationComposer,
      $$ReflectionsTableCreateCompanionBuilder,
      $$ReflectionsTableUpdateCompanionBuilder,
      (
        Reflection,
        BaseReferences<_$AppDatabase, $ReflectionsTable, Reflection>,
      ),
      Reflection,
      PrefetchHooks Function()
    >;
typedef $$DhikrLogsTableCreateCompanionBuilder =
    DhikrLogsCompanion Function({
      required String dhikrKey,
      required DateTime day,
      Value<int> count,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DhikrLogsTableUpdateCompanionBuilder =
    DhikrLogsCompanion Function({
      Value<String> dhikrKey,
      Value<DateTime> day,
      Value<int> count,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DhikrLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DhikrLogsTable> {
  $$DhikrLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dhikrKey => $composableBuilder(
    column: $table.dhikrKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DhikrLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DhikrLogsTable> {
  $$DhikrLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dhikrKey => $composableBuilder(
    column: $table.dhikrKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DhikrLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DhikrLogsTable> {
  $$DhikrLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dhikrKey =>
      $composableBuilder(column: $table.dhikrKey, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DhikrLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DhikrLogsTable,
          DhikrLog,
          $$DhikrLogsTableFilterComposer,
          $$DhikrLogsTableOrderingComposer,
          $$DhikrLogsTableAnnotationComposer,
          $$DhikrLogsTableCreateCompanionBuilder,
          $$DhikrLogsTableUpdateCompanionBuilder,
          (DhikrLog, BaseReferences<_$AppDatabase, $DhikrLogsTable, DhikrLog>),
          DhikrLog,
          PrefetchHooks Function()
        > {
  $$DhikrLogsTableTableManager(_$AppDatabase db, $DhikrLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DhikrLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DhikrLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DhikrLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dhikrKey = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrLogsCompanion(
                dhikrKey: dhikrKey,
                day: day,
                count: count,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dhikrKey,
                required DateTime day,
                Value<int> count = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrLogsCompanion.insert(
                dhikrKey: dhikrKey,
                day: day,
                count: count,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DhikrLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DhikrLogsTable,
      DhikrLog,
      $$DhikrLogsTableFilterComposer,
      $$DhikrLogsTableOrderingComposer,
      $$DhikrLogsTableAnnotationComposer,
      $$DhikrLogsTableCreateCompanionBuilder,
      $$DhikrLogsTableUpdateCompanionBuilder,
      (DhikrLog, BaseReferences<_$AppDatabase, $DhikrLogsTable, DhikrLog>),
      DhikrLog,
      PrefetchHooks Function()
    >;
typedef $$SavedDuasTableCreateCompanionBuilder =
    SavedDuasCompanion Function({
      required String duaKey,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SavedDuasTableUpdateCompanionBuilder =
    SavedDuasCompanion Function({
      Value<String> duaKey,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SavedDuasTableFilterComposer
    extends Composer<_$AppDatabase, $SavedDuasTable> {
  $$SavedDuasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get duaKey => $composableBuilder(
    column: $table.duaKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedDuasTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedDuasTable> {
  $$SavedDuasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get duaKey => $composableBuilder(
    column: $table.duaKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedDuasTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedDuasTable> {
  $$SavedDuasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get duaKey =>
      $composableBuilder(column: $table.duaKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SavedDuasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedDuasTable,
          SavedDua,
          $$SavedDuasTableFilterComposer,
          $$SavedDuasTableOrderingComposer,
          $$SavedDuasTableAnnotationComposer,
          $$SavedDuasTableCreateCompanionBuilder,
          $$SavedDuasTableUpdateCompanionBuilder,
          (SavedDua, BaseReferences<_$AppDatabase, $SavedDuasTable, SavedDua>),
          SavedDua,
          PrefetchHooks Function()
        > {
  $$SavedDuasTableTableManager(_$AppDatabase db, $SavedDuasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedDuasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedDuasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedDuasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> duaKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedDuasCompanion(
                duaKey: duaKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String duaKey,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedDuasCompanion.insert(
                duaKey: duaKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedDuasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedDuasTable,
      SavedDua,
      $$SavedDuasTableFilterComposer,
      $$SavedDuasTableOrderingComposer,
      $$SavedDuasTableAnnotationComposer,
      $$SavedDuasTableCreateCompanionBuilder,
      $$SavedDuasTableUpdateCompanionBuilder,
      (SavedDua, BaseReferences<_$AppDatabase, $SavedDuasTable, SavedDua>),
      SavedDua,
      PrefetchHooks Function()
    >;
typedef $$PrayerLogsTableCreateCompanionBuilder =
    PrayerLogsCompanion Function({
      required DateTime day,
      required String prayer,
      Value<bool> completed,
      Value<int> rowid,
    });
typedef $$PrayerLogsTableUpdateCompanionBuilder =
    PrayerLogsCompanion Function({
      Value<DateTime> day,
      Value<String> prayer,
      Value<bool> completed,
      Value<int> rowid,
    });

class $$PrayerLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get prayer =>
      $composableBuilder(column: $table.prayer, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$PrayerLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerLogsTable,
          PrayerLog,
          $$PrayerLogsTableFilterComposer,
          $$PrayerLogsTableOrderingComposer,
          $$PrayerLogsTableAnnotationComposer,
          $$PrayerLogsTableCreateCompanionBuilder,
          $$PrayerLogsTableUpdateCompanionBuilder,
          (
            PrayerLog,
            BaseReferences<_$AppDatabase, $PrayerLogsTable, PrayerLog>,
          ),
          PrayerLog,
          PrefetchHooks Function()
        > {
  $$PrayerLogsTableTableManager(_$AppDatabase db, $PrayerLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> day = const Value.absent(),
                Value<String> prayer = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrayerLogsCompanion(
                day: day,
                prayer: prayer,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime day,
                required String prayer,
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrayerLogsCompanion.insert(
                day: day,
                prayer: prayer,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerLogsTable,
      PrayerLog,
      $$PrayerLogsTableFilterComposer,
      $$PrayerLogsTableOrderingComposer,
      $$PrayerLogsTableAnnotationComposer,
      $$PrayerLogsTableCreateCompanionBuilder,
      $$PrayerLogsTableUpdateCompanionBuilder,
      (PrayerLog, BaseReferences<_$AppDatabase, $PrayerLogsTable, PrayerLog>),
      PrayerLog,
      PrefetchHooks Function()
    >;
typedef $$ReadingLogsTableCreateCompanionBuilder =
    ReadingLogsCompanion Function({
      required DateTime day,
      Value<int> ayahsRead,
      Value<int> rowid,
    });
typedef $$ReadingLogsTableUpdateCompanionBuilder =
    ReadingLogsCompanion Function({
      Value<DateTime> day,
      Value<int> ayahsRead,
      Value<int> rowid,
    });

class $$ReadingLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingLogsTable> {
  $$ReadingLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahsRead => $composableBuilder(
    column: $table.ayahsRead,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingLogsTable> {
  $$ReadingLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahsRead => $composableBuilder(
    column: $table.ayahsRead,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingLogsTable> {
  $$ReadingLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get ayahsRead =>
      $composableBuilder(column: $table.ayahsRead, builder: (column) => column);
}

class $$ReadingLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingLogsTable,
          ReadingLog,
          $$ReadingLogsTableFilterComposer,
          $$ReadingLogsTableOrderingComposer,
          $$ReadingLogsTableAnnotationComposer,
          $$ReadingLogsTableCreateCompanionBuilder,
          $$ReadingLogsTableUpdateCompanionBuilder,
          (
            ReadingLog,
            BaseReferences<_$AppDatabase, $ReadingLogsTable, ReadingLog>,
          ),
          ReadingLog,
          PrefetchHooks Function()
        > {
  $$ReadingLogsTableTableManager(_$AppDatabase db, $ReadingLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> day = const Value.absent(),
                Value<int> ayahsRead = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingLogsCompanion(
                day: day,
                ayahsRead: ayahsRead,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime day,
                Value<int> ayahsRead = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingLogsCompanion.insert(
                day: day,
                ayahsRead: ayahsRead,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingLogsTable,
      ReadingLog,
      $$ReadingLogsTableFilterComposer,
      $$ReadingLogsTableOrderingComposer,
      $$ReadingLogsTableAnnotationComposer,
      $$ReadingLogsTableCreateCompanionBuilder,
      $$ReadingLogsTableUpdateCompanionBuilder,
      (
        ReadingLog,
        BaseReferences<_$AppDatabase, $ReadingLogsTable, ReadingLog>,
      ),
      ReadingLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuranProgressEntriesTableTableManager get quranProgressEntries =>
      $$QuranProgressEntriesTableTableManager(_db, _db.quranProgressEntries);
  $$DailyDeedEntriesTableTableManager get dailyDeedEntries =>
      $$DailyDeedEntriesTableTableManager(_db, _db.dailyDeedEntries);
  $$CachedAyahsTableTableManager get cachedAyahs =>
      $$CachedAyahsTableTableManager(_db, _db.cachedAyahs);
  $$AyahBookmarksTableTableManager get ayahBookmarks =>
      $$AyahBookmarksTableTableManager(_db, _db.ayahBookmarks);
  $$ReflectionsTableTableManager get reflections =>
      $$ReflectionsTableTableManager(_db, _db.reflections);
  $$DhikrLogsTableTableManager get dhikrLogs =>
      $$DhikrLogsTableTableManager(_db, _db.dhikrLogs);
  $$SavedDuasTableTableManager get savedDuas =>
      $$SavedDuasTableTableManager(_db, _db.savedDuas);
  $$PrayerLogsTableTableManager get prayerLogs =>
      $$PrayerLogsTableTableManager(_db, _db.prayerLogs);
  $$ReadingLogsTableTableManager get readingLogs =>
      $$ReadingLogsTableTableManager(_db, _db.readingLogs);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
