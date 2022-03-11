import 'grammar.dart';
import 'package:petitparser/petitparser.dart';
import 'package:built_collection/built_collection.dart';
import '../rdf_base.dart';
import '../common_vocab.dart';

class ParserState {
  String? _basePath;
  String? _baseRoot;
  String? _baseScheme;

  Map<String, String> namespaces = {};

  void _setBase(String baseIRI) {
    // TODO(mikeas1): This may not work with all forms of IRIs. Could fall back
    // to regex-based loose parsing since not all semantics of the URI class are
    // needed.
    var parsed = Uri.parse(baseIRI).removeFragment();
    _basePath = Uri(
      host: parsed.host,
      path: parsed.path,
      scheme: parsed.scheme,
    ).toString();
    _baseScheme = parsed.scheme;
    _baseRoot = "${parsed.origin}/${parsed.path}";
  }
}

class TurtleParser extends TurtleDefinition {
  final ParserState _state;

  TurtleParser(this._state);

  @override
  Parser<Iterable<Term>> start() => super.start().map((componentLists) {
        var total = <Term>[];
        for (BuiltList<Term> l in componentLists) {
          total.addAll(l);
        }
        return total.build();
      });

  @override
  Parser<BuiltList<Term>> directive() =>
      super.directive().map((_) => <Term>[].build());

  @override
  Parser uchar() => super
      .uchar()
      .map((each) => String.fromCharCode(int.parse(each[2], radix: 16)));

  @override
  Parser pnLocalEsc() => super.pnLocalEsc().map((each) => each[1]);

  @override
  Parser percent() => super
      .percent()
      .map((each) => String.fromCharCode(int.parse(each[1], radix: 16)));

  @override
  Parser echar() => super.echar().map((each) {
        return _escapeMap[each[1]];
      });

  @override
  Parser prefixID() => super.prefixID().map((each) {
        _state.namespaces[each[1]] = each[2];
      }, hasSideEffects: true);

  @override
  Parser sparqlPrefix() => super.sparqlPrefix().map((each) {
        _state.namespaces[each[1]] = each[2];
      }, hasSideEffects: true);

  @override
  Parser base() => super.base().map((each) {
        _state._setBase(each[1]);
      }, hasSideEffects: true);

  @override
  Parser sparqlBase() => super.sparqlBase().map((each) {
        _state._setBase(each[1]);
      }, hasSideEffects: true);

  @override
  Parser iriRef() => super.iriRef().map((each) {
        String iriVal = each[1];
        var relative = !iriVal
            .startsWith(RegExp(r'[a-z][a-z0-9+.-]*:', caseSensitive: false));
        if (relative) {
          iriVal = _resolveRelativeIRI(iriVal) ?? "";
        }
        return iriVal;
      });

  @override
  Parser iri() => super.iri().map((each) => NamedNode(each));

  @override
  Parser stringLiteral() => super.stringLiteral().map((each) => each[1]);

  @override
  Parser rdfLiteral() => super.rdfLiteral().map((each) {
        String val = each[0];
        if (each[1] != null) {
          // Some kind of suffix.
          String sep = each[1][0];
          if (sep == "@") {
            return LiteralTerm.languageString(val, each[1][1]);
          }
          // Must be a data type specifier.
          return LiteralTerm.fromDataType(val, each[1][1]);
        }
        // No suffix. Treat as a string literal.
        return LiteralTerm.fromString(val);
      });

  @override
  Parser integer() => super
      .integer()
      .map((each) => LiteralTerm.fromDataType(each, NamedNode(Xsd.integer)));

  @override
  Parser double() => super
      .double()
      .map((each) => LiteralTerm.fromDataType(each, NamedNode(Xsd.double)));

  @override
  Parser decimal() => super
      .decimal()
      .map((each) => LiteralTerm.fromDataType(each, NamedNode(Xsd.decimal)));

  @override
  Parser booleanLiteral() => super
      .booleanLiteral()
      .map((each) => LiteralTerm.fromDataType(each, NamedNode(Xsd.boolean)));

  @override
  Parser verb() => super.verb().map((each) {
        // Special case: "a" means type.
        if (each == "a") {
          return NamedNode(Rdf.type);
        }
        // Just a regular old IRI.
        return each;
      });

  @override
  Parser pNameLn() => super.pNameLn().map((each) {
        var prefix = _state.namespaces[each[0]];
        if (prefix == null) {
          throw Exception("unknown prefix " + each[0]);
        }
        return prefix + each[1];
      });

  @override
  Parser collection() => super.collection().map((each) {
        // Create a blank node.
        Term lastNode = NamedNode(Rdf.nil);
        var entries = each[1];
        for (int i = entries.length - 1; i >= 0; i--) {
          var bNodeEntries = [
            PredicateObject(NamedNode(Rdf.first), entries[i]),
            PredicateObject(NamedNode(Rdf.rest), lastNode),
          ];
          lastNode = BlankNodeGraph(bNodeEntries.build());
        }
        return lastNode;
      });

  @override
  Parser blankNodeLabel() =>
      super.blankNodeLabel().map((each) => BlankNodeLabel(each[1]));
  @override
  Parser anon() =>
      super.anon().map((_) => BlankNodeGraph(<PredicateObject>[].build()));

  @override
  Parser predicateObjectList() => super.predicateObjectList().map((each) {
        // Emit a List<PredicateObject>
        var output = <PredicateObject>[];
        for (var predObjList in each) {
          Term pred = predObjList[0];
          for (Term obj in predObjList[1]) {
            output.add(PredicateObject(pred, obj));
          }
        }
        return output.build();
      });

  @override
  Parser blankNodePropertyList() => super.blankNodePropertyList().map((each) {
        // Create a new blank node.
        return BlankNodeGraph(each[1]);
      });

  @override
  Parser<BuiltList<Term>> triples() => super.triples().map((each) {
        var tripleNodes = <Quad>[];
        Term sub = each[0];
        BuiltList<PredicateObject> predObs = each[1] ?? [];
        for (var predOb in predObs) {
          tripleNodes.add(Quad(sub, predOb.predicate, predOb.object));
        }
        return tripleNodes.build();
      });

  String? _resolveRelativeIRI(String iri) {
    var base = _state._basePath;
    if (base == null) {
      throw Exception(
          "unable to resolve relative iri $iri -- no base provided");
    }
    if (iri.isEmpty) {
      return base;
    }
    switch (iri[0]) {
      case '#':
        return base + iri;
      case '?':
        return base.replaceAll(RegExp(r"(?:\?.*)?$"), iri);
      case '/':
        return (iri[1] == '/' ? _state._baseScheme : _state._baseRoot) ??
            "" + _removeDotSegments(iri);
      default:
        return RegExp('^[^/:]*:').hasMatch(iri)
            ? null
            : _removeDotSegments(base + iri);
    }
  }

  String _removeDotSegments(String iri) {
    Uri parsed = Uri.parse(iri);
    return parsed.normalizePath().toString();
  }
}

// TODO: Streaming parsing -- return Stream<Term>.

Result<Iterable<Term>> parseTurtle(String turtle, {String baseUrl = ""}) {
  var state = ParserState();
  if (baseUrl.isNotEmpty) {
    state._setBase(baseUrl);
  }
  var parser = TurtleParser(state);
  Parser<Iterable<Term>> built = parser.build();
  return built.parse(turtle);
}

const _escapeMap = {
  't': '\t',
  'b': '\b',
  'n': '\n',
  'r': '\r',
  'f': '\f',
  '"': '"',
  "'": "'",
  '\\': '\\',
};
