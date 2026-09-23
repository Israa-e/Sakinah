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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuranProgressEntriesTable quranProgressEntries =
      $QuranProgressEntriesTable(this);
  late final $DailyDeedEntriesTable dailyDeedEntries = $DailyDeedEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    quranProgressEntries,
    dailyDeedEntries,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuranProgressEntriesTableTableManager get quranProgressEntries =>
      $$QuranProgressEntriesTableTableManager(_db, _db.quranProgressEntries);
  $$DailyDeedEntriesTableTableManager get dailyDeedEntries =>
      $$DailyDeedEntriesTableTableManager(_db, _db.dailyDeedEntries);
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
