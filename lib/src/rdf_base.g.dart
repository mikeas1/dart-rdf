// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rdf_base.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LiteralTerm extends LiteralTerm {
  @override
  final String value;
  @override
  final String? language;
  @override
  final NamedNode dataType;

  factory _$LiteralTerm([void Function(LiteralTermBuilder)? updates]) =>
      (new LiteralTermBuilder()..update(updates)).build();

  _$LiteralTerm._({required this.value, this.language, required this.dataType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(value, 'LiteralTerm', 'value');
    BuiltValueNullFieldError.checkNotNull(dataType, 'LiteralTerm', 'dataType');
  }

  @override
  LiteralTerm rebuild(void Function(LiteralTermBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LiteralTermBuilder toBuilder() => new LiteralTermBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LiteralTerm &&
        value == other.value &&
        language == other.language &&
        dataType == other.dataType;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, value.hashCode), language.hashCode), dataType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LiteralTerm')
          ..add('value', value)
          ..add('language', language)
          ..add('dataType', dataType))
        .toString();
  }
}

class LiteralTermBuilder implements Builder<LiteralTerm, LiteralTermBuilder> {
  _$LiteralTerm? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  NamedNodeBuilder? _dataType;
  NamedNodeBuilder get dataType => _$this._dataType ??= new NamedNodeBuilder();
  set dataType(NamedNodeBuilder? dataType) => _$this._dataType = dataType;

  LiteralTermBuilder();

  LiteralTermBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _language = $v.language;
      _dataType = $v.dataType.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LiteralTerm other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LiteralTerm;
  }

  @override
  void update(void Function(LiteralTermBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LiteralTerm build() {
    _$LiteralTerm _$result;
    try {
      _$result = _$v ??
          new _$LiteralTerm._(
              value: BuiltValueNullFieldError.checkNotNull(
                  value, 'LiteralTerm', 'value'),
              language: language,
              dataType: dataType.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dataType';
        dataType.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LiteralTerm', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NamedNode extends NamedNode {
  @override
  final String iri;

  factory _$NamedNode([void Function(NamedNodeBuilder)? updates]) =>
      (new NamedNodeBuilder()..update(updates)).build();

  _$NamedNode._({required this.iri}) : super._() {
    BuiltValueNullFieldError.checkNotNull(iri, 'NamedNode', 'iri');
  }

  @override
  NamedNode rebuild(void Function(NamedNodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NamedNodeBuilder toBuilder() => new NamedNodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NamedNode && iri == other.iri;
  }

  @override
  int get hashCode {
    return $jf($jc(0, iri.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NamedNode')..add('iri', iri))
        .toString();
  }
}

class NamedNodeBuilder implements Builder<NamedNode, NamedNodeBuilder> {
  _$NamedNode? _$v;

  String? _iri;
  String? get iri => _$this._iri;
  set iri(String? iri) => _$this._iri = iri;

  NamedNodeBuilder();

  NamedNodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _iri = $v.iri;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NamedNode other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NamedNode;
  }

  @override
  void update(void Function(NamedNodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NamedNode build() {
    final _$result = _$v ??
        new _$NamedNode._(
            iri:
                BuiltValueNullFieldError.checkNotNull(iri, 'NamedNode', 'iri'));
    replace(_$result);
    return _$result;
  }
}

class _$BlankNodeLabel extends BlankNodeLabel {
  @override
  final String value;

  factory _$BlankNodeLabel([void Function(BlankNodeLabelBuilder)? updates]) =>
      (new BlankNodeLabelBuilder()..update(updates)).build();

  _$BlankNodeLabel._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, 'BlankNodeLabel', 'value');
  }

  @override
  BlankNodeLabel rebuild(void Function(BlankNodeLabelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlankNodeLabelBuilder toBuilder() =>
      new BlankNodeLabelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlankNodeLabel && value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(0, value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlankNodeLabel')..add('value', value))
        .toString();
  }
}

class BlankNodeLabelBuilder
    implements Builder<BlankNodeLabel, BlankNodeLabelBuilder> {
  _$BlankNodeLabel? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  BlankNodeLabelBuilder();

  BlankNodeLabelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlankNodeLabel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BlankNodeLabel;
  }

  @override
  void update(void Function(BlankNodeLabelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlankNodeLabel build() {
    final _$result = _$v ??
        new _$BlankNodeLabel._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, 'BlankNodeLabel', 'value'));
    replace(_$result);
    return _$result;
  }
}

class _$BlankNodeGraph extends BlankNodeGraph {
  @override
  final BuiltList<PredicateObject> entries;

  factory _$BlankNodeGraph([void Function(BlankNodeGraphBuilder)? updates]) =>
      (new BlankNodeGraphBuilder()..update(updates)).build();

  _$BlankNodeGraph._({required this.entries}) : super._() {
    BuiltValueNullFieldError.checkNotNull(entries, 'BlankNodeGraph', 'entries');
  }

  @override
  BlankNodeGraph rebuild(void Function(BlankNodeGraphBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlankNodeGraphBuilder toBuilder() =>
      new BlankNodeGraphBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlankNodeGraph && entries == other.entries;
  }

  @override
  int get hashCode {
    return $jf($jc(0, entries.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlankNodeGraph')
          ..add('entries', entries))
        .toString();
  }
}

class BlankNodeGraphBuilder
    implements Builder<BlankNodeGraph, BlankNodeGraphBuilder> {
  _$BlankNodeGraph? _$v;

  ListBuilder<PredicateObject>? _entries;
  ListBuilder<PredicateObject> get entries =>
      _$this._entries ??= new ListBuilder<PredicateObject>();
  set entries(ListBuilder<PredicateObject>? entries) =>
      _$this._entries = entries;

  BlankNodeGraphBuilder();

  BlankNodeGraphBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entries = $v.entries.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlankNodeGraph other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BlankNodeGraph;
  }

  @override
  void update(void Function(BlankNodeGraphBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlankNodeGraph build() {
    _$BlankNodeGraph _$result;
    try {
      _$result = _$v ?? new _$BlankNodeGraph._(entries: entries.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entries';
        entries.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BlankNodeGraph', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PredicateObject extends PredicateObject {
  @override
  final Term predicate;
  @override
  final Term object;

  factory _$PredicateObject([void Function(PredicateObjectBuilder)? updates]) =>
      (new PredicateObjectBuilder()..update(updates)).build();

  _$PredicateObject._({required this.predicate, required this.object})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        predicate, 'PredicateObject', 'predicate');
    BuiltValueNullFieldError.checkNotNull(object, 'PredicateObject', 'object');
  }

  @override
  PredicateObject rebuild(void Function(PredicateObjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PredicateObjectBuilder toBuilder() =>
      new PredicateObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PredicateObject &&
        predicate == other.predicate &&
        object == other.object;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, predicate.hashCode), object.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PredicateObject')
          ..add('predicate', predicate)
          ..add('object', object))
        .toString();
  }
}

class PredicateObjectBuilder
    implements Builder<PredicateObject, PredicateObjectBuilder> {
  _$PredicateObject? _$v;

  Term? _predicate;
  Term? get predicate => _$this._predicate;
  set predicate(Term? predicate) => _$this._predicate = predicate;

  Term? _object;
  Term? get object => _$this._object;
  set object(Term? object) => _$this._object = object;

  PredicateObjectBuilder();

  PredicateObjectBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _predicate = $v.predicate;
      _object = $v.object;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PredicateObject other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PredicateObject;
  }

  @override
  void update(void Function(PredicateObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PredicateObject build() {
    final _$result = _$v ??
        new _$PredicateObject._(
            predicate: BuiltValueNullFieldError.checkNotNull(
                predicate, 'PredicateObject', 'predicate'),
            object: BuiltValueNullFieldError.checkNotNull(
                object, 'PredicateObject', 'object'));
    replace(_$result);
    return _$result;
  }
}

class _$Variable extends Variable {
  @override
  final String value;

  factory _$Variable([void Function(VariableBuilder)? updates]) =>
      (new VariableBuilder()..update(updates)).build();

  _$Variable._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, 'Variable', 'value');
  }

  @override
  Variable rebuild(void Function(VariableBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VariableBuilder toBuilder() => new VariableBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Variable && value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc(0, value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Variable')..add('value', value))
        .toString();
  }
}

class VariableBuilder implements Builder<Variable, VariableBuilder> {
  _$Variable? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  VariableBuilder();

  VariableBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Variable other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Variable;
  }

  @override
  void update(void Function(VariableBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Variable build() {
    final _$result = _$v ??
        new _$Variable._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, 'Variable', 'value'));
    replace(_$result);
    return _$result;
  }
}

class _$Quad extends Quad {
  @override
  final Term subject;
  @override
  final Term predicate;
  @override
  final Term object;
  @override
  final Term graph;

  factory _$Quad([void Function(QuadBuilder)? updates]) =>
      (new QuadBuilder()..update(updates)).build();

  _$Quad._(
      {required this.subject,
      required this.predicate,
      required this.object,
      required this.graph})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(subject, 'Quad', 'subject');
    BuiltValueNullFieldError.checkNotNull(predicate, 'Quad', 'predicate');
    BuiltValueNullFieldError.checkNotNull(object, 'Quad', 'object');
    BuiltValueNullFieldError.checkNotNull(graph, 'Quad', 'graph');
  }

  @override
  Quad rebuild(void Function(QuadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuadBuilder toBuilder() => new QuadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Quad &&
        subject == other.subject &&
        predicate == other.predicate &&
        object == other.object &&
        graph == other.graph;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, subject.hashCode), predicate.hashCode), object.hashCode),
        graph.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Quad')
          ..add('subject', subject)
          ..add('predicate', predicate)
          ..add('object', object)
          ..add('graph', graph))
        .toString();
  }
}

class QuadBuilder implements Builder<Quad, QuadBuilder> {
  _$Quad? _$v;

  Term? _subject;
  Term? get subject => _$this._subject;
  set subject(Term? subject) => _$this._subject = subject;

  Term? _predicate;
  Term? get predicate => _$this._predicate;
  set predicate(Term? predicate) => _$this._predicate = predicate;

  Term? _object;
  Term? get object => _$this._object;
  set object(Term? object) => _$this._object = object;

  Term? _graph;
  Term? get graph => _$this._graph;
  set graph(Term? graph) => _$this._graph = graph;

  QuadBuilder();

  QuadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _predicate = $v.predicate;
      _object = $v.object;
      _graph = $v.graph;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Quad other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Quad;
  }

  @override
  void update(void Function(QuadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Quad build() {
    final _$result = _$v ??
        new _$Quad._(
            subject: BuiltValueNullFieldError.checkNotNull(
                subject, 'Quad', 'subject'),
            predicate: BuiltValueNullFieldError.checkNotNull(
                predicate, 'Quad', 'predicate'),
            object:
                BuiltValueNullFieldError.checkNotNull(object, 'Quad', 'object'),
            graph:
                BuiltValueNullFieldError.checkNotNull(graph, 'Quad', 'graph'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
