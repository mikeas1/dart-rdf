import 'grammar.dart';
import 'package:petitparser/petitparser.dart';
import '../rdf_base.dart';

const _rdfNil = NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#nil");
const _rdfFirst = NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#first");
const _rdfRest = NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#rest");

class ParserState {
  String? _baseIri;
  String? _basePath;
  String? _baseRoot;
  String? _baseScheme;

  Map<String, String> namespaces = {};

  void _setBase(String baseIRI) {
    // TODO(mikeas1): This may not work with all forms of IRIs. Could fall back
    // to regex-based loose parsing since not all semantics of the URI class are
    // needed.
    final baseURI = Uri.parse(baseIRI);
    _baseIri = baseURI.removeFragment().toString();
    _basePath = baseURI
        .replace(fragment: "", query: "", queryParameters: {}).toString();
    _baseScheme = baseURI.scheme;
    _baseRoot = "${baseURI.origin}/${baseURI.path}";
  }
}

class _PredicateObject {
  Term _predicate;
  Term _object;

  _PredicateObject(this._predicate, this._object);
}

class TurtleParser extends TurtleDefinition {
  final ParserState _state;
  int _blankNodeCount = 0;
  final List<Quad> _sideQuads = [];

  TurtleParser(this._state);

  @override
  Parser start() => super.start().map((_) => _sideQuads);

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
  Parser echar() => super.echar().map((each) => _escapeMap[each[1]]);

  @override
  Parser prefixID() => super.prefixID().map((each) {
        _state.namespaces[each[1]] = each[2];
        return each[1];
      }, hasSideEffects: true);

  @override
  Parser sparqlPrefix() => super.sparqlPrefix().map((each) {
        _state.namespaces[each[1]] = each[2];
        return each[1];
      }, hasSideEffects: true);

  @override
  Parser base() => super.base().map((each) {
        _state._setBase(each[1]);
        return each[1];
      }, hasSideEffects: true);

  @override
  Parser sparqlBase() => super.sparqlBase().map((each) {
        _state._setBase(each[1]);
        return each[1];
      }, hasSideEffects: true);

  @override
  Parser iriRef() => super.iriRef().map((each) {
        // TODO: Perform relative IRI resolution.
        return each[1];
      });

  @override
  Parser iri() => super.iri().map((each) => NamedNode(each));

  @override
  Parser stringLiteral() => super.stringLiteral().map((each) => each[1]);

  @override
  Parser langTag() => super.langTag().map((each) => each[1]);

  @override
  Parser rdfLiteral() => super.rdfLiteral().map((each) {
        String val = each[0];
        if (each[1] != null) {
          // It's a data type.
          if (each[1] is NamedNode) {
            return LiteralTerm.fromDataType(val, each[1]);
          }
          // It's a language string.
          return LiteralTerm.languageString(val, each[1]);
        }
        return LiteralTerm.fromString(val);
      });

  @override
  Parser integer() =>
      super.integer().map((each) => LiteralTerm.fromInt(int.parse(each)));

  @override
  Parser double() =>
      super.double().map((each) => LiteralTerm.fromDouble(num.parse(each)));

  @override
  Parser decimal() =>
      super.decimal().map((each) => LiteralTerm.fromDecimal(num.parse(each)));

  @override
  Parser booleanLiteral() => super
      .booleanLiteral()
      .map((each) => LiteralTerm.fromBool(each == "true"));

  @override
  Parser verb() => super.verb().map((each) {
        if (each == "a") {
          return typeDataType;
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
        Term prev = _rdfNil;
        for (int i = each.length; i >= 0; i--) {
          var sub = BlankNode("rdf-${_blankNodeCount++}");
          _sideQuads.add(Quad(sub, _rdfFirst, each[i]));
          _sideQuads.add(Quad(sub, _rdfRest, prev));
          prev = sub;
        }
        return prev;
      }, hasSideEffects: true);
  @override
  Parser blankNodeLabel() =>
      super.blankNodeLabel().map((each) => BlankNode(each[1]));
  @override
  Parser anon() => super
      .anon()
      .map((_) => BlankNode("anon-${_blankNodeCount++}"), hasSideEffects: true);

  @override
  Parser predicateObjectList() => super.predicateObjectList().map((each) {
        // Emit a List<PredicateObject>
        var output = <_PredicateObject>[];
        for (var predObjList in each) {
          Term pred = predObjList[0];
          for (Term obj in predObjList[1]) {
            output.add(_PredicateObject(pred, obj));
          }
        }
        return output;
      });

  @override
  Parser blankNodePropertyList() => super.blankNodePropertyList().map((each) {
        // Create a new blank node.
        BlankNode sub = BlankNode("rdf-${_blankNodeCount++}");
        for (_PredicateObject predObj in each[1]) {
          _sideQuads.add(Quad(sub, predObj._predicate, predObj._object));
        }
        return sub;
      }, hasSideEffects: true);

  @override
  Parser triples() => super.triples().map((each) {
        Term sub = each[0];
        List<_PredicateObject> predObs = each[1] ?? [];
        for (var predOb in predObs) {
          _sideQuads.add(Quad(sub, predOb._predicate, predOb._object));
        }
        return sub;
      }, hasSideEffects: true);
}

// TODO: Handle emitting quads.
// Using state to track... state... may not be the right idea.
// Hard to "push" into one state and "pop" out of another. Instead,
// rethink this into how to build the objects we want to be able to
// emit.

Result<List<Quad>> parseTurtle(String turtle) {
  var state = ParserState();
  var parser = TurtleParser(state);
  var built = parser.build();
  var res = built.parse(turtle);
  return res.map((_) => parser._sideQuads);
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
