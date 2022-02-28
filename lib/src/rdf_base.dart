// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.

const stringDataType = NamedNode("http://www.w3.org/2001/XMLSchema#string");
const intDataType = NamedNode("http://www.w3.org/2001/XMLSchema#integer");
const doubleDataType = NamedNode("http://www.w3.org/2001/XMLSchema#double");
const decimalDataType = NamedNode("http://www.w3.org/2001/XMLSchema#decimal");
const booleanDataType = NamedNode("http://www.w3.org/2001/XMLSchema#boolean");
const langStringDataType =
    NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#langString");
const typeDataType =
    NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#type");

enum TermType {
  defaultGraph,
  literal,
  quad,
  namedNode,
  blankNode,
  variable,
}

abstract class Term {
  String get value;
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
}

class LiteralTerm implements Term {
  @override
  String value;

  final String? language;
  final NamedNode dataType;

  LiteralTerm.fromString(
    this.value,
  )   : dataType = stringDataType,
        language = null;

  LiteralTerm.languageString(
    this.value,
    this.language,
  ) : dataType = langStringDataType;

  LiteralTerm.fromInt(int value)
      : value = value.toString(),
        language = null,
        dataType = intDataType;

  LiteralTerm.fromDataType(this.value, this.dataType) : language = null;

  LiteralTerm.fromDouble(num value)
      : language = null,
        dataType = doubleDataType,
        value = value.toString();

  LiteralTerm.fromDecimal(num value)
      : language = null,
        dataType = decimalDataType,
        value = value.toString();

  LiteralTerm.fromBool(bool value)
      : language = null,
        dataType = booleanDataType,
        value = value.toString();

  @override
  bool operator ==(Object other) {
    if (other is! LiteralTerm) {
      return false;
    }
    return value == value && language == language && dataType == dataType;
  }

  @override
  int get hashCode => Object.hash(value, language, dataType);
}

class NamedNode implements Term {
  final String iri;

  @override
  String get value => iri;

  const NamedNode(this.iri);

  @override
  bool operator ==(Object other) {
    if (other is! NamedNode) {
      return false;
    }
    return iri == other.iri;
  }

  @override
  int get hashCode => iri.hashCode;
}

class BlankNode implements Term {
  @override
  final String value;

  BlankNode(this.value);

  @override
  bool operator ==(Object other) {
    if (other is! BlankNode) {
      return false;
    }
    return value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

class Variable implements Term {
  @override
  final String value;

  Variable(this.value);

  @override
  bool operator ==(Object other) {
    if (other is! Variable) {
      return false;
    }
    return value == other.value;
  }

  int get hashCode => value.hashCode;
}

class Quad implements Term {
  @override
  String get value => "";

  Term subject;
  Term predicate;
  Term object;
  Term graph;

  Quad(this.subject, this.predicate, this.object)
      : graph = DefaultGraph.defaultGraph;
  Quad.withGraph(this.subject, this.predicate, this.object, this.graph);

  @override
  bool operator ==(Object other) {
    if (other is! Quad) {
      return false;
    }
    return subject == other.subject &&
        predicate == other.predicate &&
        object == other.object &&
        graph == other.graph;
  }

  @override
  int get hashCode => Object.hash(subject, predicate, object, graph);

  @override
  String toString() {
    return subject.value +
        " " +
        predicate.value +
        " " +
        object.value +
        " " +
        graph.toString();
  }
}

class RdfDataset {}
