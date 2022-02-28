import 'package:rdf/rdf.dart';
import 'package:turtle/turtle.dart';
import 'package:test/test.dart';

void main() {
  group('Parsing', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('One Triple', () {
      var quads = parseTurtle("""
<http://example.com/#me> <https://example.com/vocab/#knows> <https://example.com/#you> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          unorderedEquals([
            Quad(
                NamedNode("http://example.com/#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you"))
          ]));
    });

    test('Two Triples', () {
      var quads = parseTurtle("""

<http://example.com/#me> <https://example.com/vocab/#knows> <https://example.com/#you> .

<https://numbers.com/#64> <https://example.com/vocab/#status> <https://example.com/status#funny> .


""");
      expect(quads.isSuccess, isTrue);

      expect(
          quads.value,
          orderedEquals([
            Quad(
                NamedNode("http://example.com/#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you")),
            Quad(
                NamedNode("https://numbers.com/#64"),
                NamedNode("https://example.com/vocab/#status"),
                NamedNode("https://example.com/status#funny")),
          ]));
    });

    test('Prefixed Triple', () {
      var quads = parseTurtle("""

@prefix p: <http://a.b.c/stuff#> .

p:me <https://example.com/vocab/#knows> <https://example.com/#you> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          orderedEquals([
            Quad(
                NamedNode("http://a.b.c/stuff#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you"))
          ]));
    });

    test('SPARQL Prefixed Triple', () {
      var quads = parseTurtle("""

PrEfIx p: <http://a.b.c/stuff#>

p:me <https://example.com/vocab/#knows> <https://example.com/#you> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          unorderedEquals([
            Quad(
                NamedNode("http://a.b.c/stuff#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you"))
          ]));
    });

    test('Mildly Complicated', () {
      var quads = parseTurtle("""
@prefix dc: <http://purl.org/dc/terms/> .
@prefix frbr: <http://purl.org/vocab/frbr/core#> .

<http://books.example.com/works/45U8QJGZSQKDH8N> a frbr:Work ;
     dc:creator "Wil Wheaton"@en ;
     dc:title "Just a Geek"@en ;
     frbr:realization <http://books.example.com/products/9780596007683.BOOK>,
         <http://books.example.com/products/9780596802189.EBOOK> .

<http://books.example.com/products/9780596007683.BOOK> a frbr:Expression ;
     dc:type <http://books.example.com/product-types/BOOK> .

<http://books.example.com/products/9780596802189.EBOOK> a frbr:Expression ;
     dc:type <http://books.example.com/product-types/EBOOK> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          orderedEquals([
            Quad(
              NamedNode("http://books.example.com/works/45U8QJGZSQKDH8N"),
              typeDataType,
              NamedNode("http://purl.org/vocab/frbr/core#Work"),
            ),
            Quad(
              NamedNode("http://books.example.com/works/45U8QJGZSQKDH8N"),
              NamedNode("http://purl.org/dc/terms/creator"),
              LiteralTerm.languageString("Wil Wheaton", "en"),
            ),
            Quad(
              NamedNode("http://books.example.com/works/45U8QJGZSQKDH8N"),
              NamedNode("http://purl.org/dc/terms/title"),
              LiteralTerm.languageString("Just a Geek", "en"),
            ),
            Quad(
              NamedNode("http://books.example.com/works/45U8QJGZSQKDH8N"),
              NamedNode("http://purl.org/vocab/frbr/core#realization"),
              NamedNode("http://books.example.com/products/9780596007683.BOOK"),
            ),
            Quad(
              NamedNode("http://books.example.com/works/45U8QJGZSQKDH8N"),
              NamedNode("http://purl.org/vocab/frbr/core#realization"),
              NamedNode(
                  "http://books.example.com/products/9780596802189.EBOOK"),
            ),
            Quad(
              NamedNode("http://books.example.com/products/9780596007683.BOOK"),
              typeDataType,
              NamedNode("http://purl.org/vocab/frbr/core#Expression"),
            ),
            Quad(
              NamedNode("http://books.example.com/products/9780596007683.BOOK"),
              NamedNode("http://purl.org/dc/terms/type"),
              NamedNode("http://books.example.com/product-types/BOOK"),
            ),
            Quad(
              NamedNode(
                  "http://books.example.com/products/9780596802189.EBOOK"),
              typeDataType,
              NamedNode("http://purl.org/vocab/frbr/core#Expression"),
            ),
            Quad(
              NamedNode(
                  "http://books.example.com/products/9780596802189.EBOOK"),
              NamedNode("http://purl.org/dc/terms/type"),
              NamedNode("http://books.example.com/product-types/EBOOK"),
            ),
          ]));
    });

    test('From Spec', () {
      var quads = parseTurtle("""
@prefix ericFoaf: <http://www.w3.org/People/Eric/ericP-foaf.rdf#> .
@prefix : <http://xmlns.com/foaf/0.1/> .
ericFoaf:ericP :givenName "Eric" ;
              :knows <http://norman.walsh.name/knows/who/dan-brickley> ,
                      [ :mbox <mailto:timbl@w3.org> ] ,
                      <http://getopenid.com/amyvdh> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          orderedEquals([
            Quad(
              BlankNode("rdf-0"),
              NamedNode("http://xmlns.com/foaf/0.1/mbox"),
              NamedNode("mailto:timbl@w3.org"),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/givenName"),
              LiteralTerm.fromString("Eric"),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              NamedNode("http://norman.walsh.name/knows/who/dan-brickley"),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              BlankNode("rdf-0"),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              NamedNode("http://getopenid.com/amyvdh"),
            ),
          ]));
    });

    test('Named Blank Node', () {
      var quads = parseTurtle("""
@prefix : <http://xmlns.com/foaf/0.1/> .
<http://bomb.com/person> :knows _:blah .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          orderedEquals([
            Quad(
              NamedNode("http://bomb.com/person"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              BlankNode("blah"),
            ),
          ]));
    });
    test('Anonymous Subject', () {});
    test('Blank Pred List as Subject', () {});
    test('Relative URIs', () {});
    test('Base overriden', () {});
    test('Forced data types', () {});
    test('Primitive non-strings', () {});
    test('String literals', () {});

    test('IRI Prefix', () {});
  });
}
