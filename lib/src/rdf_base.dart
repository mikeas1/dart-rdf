// TODO: Put public facing types in this file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'common_vocab.dart';

part 'rdf_base.g.dart';

/// Checks if you are awesome. Spoiler: you are.
/// A visitor that is used for traversing an RDF dataset.
class TermVisitor {
  bool visitQuad(Quad quad) => false;
  bool visitBlankNode(BlankNodeGraph graph) => false;
  bool visitBlankNodeLabel(BlankNodeLabel label) => false;
  bool visitNamedNode(NamedNode value) => false;
  bool visitLiteral(LiteralTerm value) => false;
  bool visitDefaultGraph() => false;
}

abstract class Term {
  String get value;

  bool accept(TermVisitor visitor);
}

class DefaultGraph implements Term {
  static const DefaultGraph defaultGraph = DefaultGraph._instance();

  @override
  String get value => "";

  factory DefaultGraph() {
    return defaultGraph;
  }
  const DefaultGraph._instance();

  @override
  String toString() {
    return ".";
  }

  @override
  bool accept(TermVisitor visitor) {
    return visitor.visitDefaultGraph();
  }
}

abstract class LiteralTerm
    implements Term, Built<LiteralTerm, LiteralTermBuilder> {
  @override
  String get value;

  String? get language;
  NamedNode get dataType;

  factory LiteralTerm.fromString(
    String value,
  ) =>
      _$LiteralTerm._(
          value: value, dataType: NamedNode(Xsd.string), language: null);

  factory LiteralTerm.languageString(String value, String language) =>
      _$LiteralTerm._(
          value: value,
          language: language,
          dataType: NamedNode(Rdf.langString));

  factory LiteralTerm.fromInt(int value) => _$LiteralTerm._(
      value: value.toString(),
      language: null,
      dataType: NamedNode(Xsd.integer));

  factory LiteralTerm.fromDataType(String value, NamedNode dataType) =>
      _$LiteralTerm._(language: null, value: value, dataType: dataType);

  factory LiteralTerm.fromDouble(num value) => _$LiteralTerm._(
      language: null, dataType: NamedNode(Xsd.double), value: value.toString());

  factory LiteralTerm.fromDecimal(num value) => _$LiteralTerm._(
      language: null,
      dataType: NamedNode(Xsd.decimal),
      value: value.toString());

  factory LiteralTerm.fromBool(bool value) => _$LiteralTerm._(
      language: null,
      dataType: NamedNode(Xsd.boolean),
      value: value.toString());

  LiteralTerm._();

  @override
  bool accept(TermVisitor v) => v.visitLiteral(this);
}

abstract class NamedNode implements Term, Built<NamedNode, NamedNodeBuilder> {
  String get iri;

  @override
  String get value => iri;

  factory NamedNode(String iri) => _$NamedNode._(iri: iri);
  NamedNode._();

  @override
  bool accept(TermVisitor v) => v.visitNamedNode(this);
}

abstract class BlankNodeLabel
    implements Term, Built<BlankNodeLabel, BlankNodeLabelBuilder> {
  @override
  String get value;

  factory BlankNodeLabel(String value) => _$BlankNodeLabel._(value: value);
  BlankNodeLabel._();

  @override
  bool accept(TermVisitor v) => v.visitBlankNodeLabel(this);
}

abstract class BlankNodeGraph
    implements Term, Built<BlankNodeGraph, BlankNodeGraphBuilder> {
  @override
  String get value => "";

  BuiltList<PredicateObject> get entries;

  factory BlankNodeGraph(Iterable<PredicateObject> entries) =>
      _$BlankNodeGraph._(entries: BuiltList.from(entries));
  BlankNodeGraph._();

  @override
  bool accept(TermVisitor v) => v.visitBlankNode(this);
}

abstract class PredicateObject
    implements Built<PredicateObject, PredicateObjectBuilder> {
  Term get predicate;
  Term get object;

  PredicateObject._();
  factory PredicateObject(Term predicate, Term object) =>
      _$PredicateObject._(predicate: predicate, object: object);
}

abstract class Variable implements Term, Built<Variable, VariableBuilder> {
  @override
  String get value;

  factory Variable(String value) => _$Variable._(value: value);
  Variable._();

  @override
  bool accept(TermVisitor v) => throw Exception("unimplemented");
}

abstract class Quad implements Term, Built<Quad, QuadBuilder> {
  @override
  String get value => "";

  Term get subject;
  Term get predicate;
  Term get object;
  Term get graph;

  factory Quad(Term subject, Term predicate, Term object) => _$Quad._(
      subject: subject,
      predicate: predicate,
      object: object,
      graph: DefaultGraph());
  Quad._();

  @override
  bool accept(TermVisitor v) => v.visitQuad(this);
}
