const _rdf = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    _xsd = 'http://www.w3.org/2001/XMLSchema#',
    _swap = 'http://www.w3.org/2000/10/swap/',
    _owl = 'http://www.w3.org/2002/07/owl#',
    _rdfs = 'http://www.w3.org/2000/01/rdf-schema#',
    _solid = 'http://www.w3.org/ns/solid/terms#';

class Xsd {
  static const decimal = "${_xsd}decimal";
  static const boolean = "${_xsd}boolean";
  static const double = "${_xsd}double";
  static const integer = "${_xsd}integer";
  static const string = "${_xsd}string";
  static const date = "${_xsd}date";
  static const dateTime = "${_xsd}dateTime";
}

class Rdf {
  static const type = "${_rdf}type";
  static const nil = "${_rdf}nil";
  static const first = "${_rdf}first";
  static const rest = "${_rdf}rest";
  static const langString = "${_rdf}langString";

  static const Property = "${_rdf}Property";
}

class Owl {
  static const sameAs = Owl$sameAs._();
  // ignore: constant_identifier_names
  static const Ontology = Owl$Ontology._();

  const Owl._();
}

class Owl$Ontology {
  static const iri = "${_owl}Ontology";

  const Owl$Ontology._();
}

class Owl$sameAs {
  final iri = "${_owl}sameAs";

  const Owl$sameAs._();
}

class R {
  static const forSome = "${_swap}reify#forSome";
  static const forAll = "${_swap}reify#forAll";
}

class Log {
  static const implies = "${_swap}log#implies";
}

class Rdfs {
  static const Class = "${_rdfs}Class";
  static const label = "${_rdfs}label";
  static const comment = "${_rdfs}comment";
  static const seeAlso = "${_rdfs}seeAlso";
}

class Solid {
  static const oidcIssuer = "${_solid}oidcIssuer";
}
