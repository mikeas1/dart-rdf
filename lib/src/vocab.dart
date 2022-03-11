import 'package:quiver/collection.dart';

import 'rdf_base.dart';

class Ontology {
  Map<String, RdfClass> classes = {};
  Map<String, RdfProperty> properties = {};

  String? preferredURI;
}

class RdfClass {
  final String iri;
  final String shortName;

  Map<String, String> labels = {};
  Map<String, String> comments = {};

  Multimap<String, Term> properties = Multimap();
  RdfClass(this.iri, this.shortName);
}

class RdfProperty {
  final String iri;
  final String shortName;
  Map<String, String> labels = {};
  Map<String, String> comments = {};
  Multimap<String, Term> properties = Multimap();

  RdfProperty(this.iri, this.shortName);
}

abstract class RdfSchema {
  RdfProperty getProperty(String iri);

  RdfClass getClass(String iri);

  List<String> getPropertyRange(String iri);
  List<String> getPropertyDomain(String iri);
  // Super-classes, sub-classes
  // Implied properties
  // Property/class equivalence
  // "Give me property x" -> expand out to equivalent props.
  // "What are possible properties I could add to x"
}
