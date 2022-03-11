import 'package:rdf/rdf.dart';
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
          orderedEquals([
            Quad(
                NamedNode("http://example.com/#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you")),
          ]));
    });

    test('Two Triples', () {
      var quads = parseTurtle("""

<http://example.com/#me>
    <https://example.com/vocab/#knows>
      <https://example.com/#you> .

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
        ]),
      );
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
                NamedNode("https://example.com/#you")),
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
          orderedEquals([
            Quad(
                NamedNode("http://a.b.c/stuff#me"),
                NamedNode("https://example.com/vocab/#knows"),
                NamedNode("https://example.com/#you")),
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
              NamedNode(Rdf.type),
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
              NamedNode(Rdf.type),
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
              NamedNode(Rdf.type),
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
ericFoaf:ericP :givenName "Eric"^^:stuff ;
              :knows <http://norman.walsh.name/knows/who/dan-brickley> ,
                      [ :mbox <mailto:timbl@w3.org> ] ,
                      <http://getopenid.com/amyvdh> .
""");
      expect(quads.isSuccess, isTrue);
      expect(
          quads.value,
          orderedEquals([
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/givenName"),
              LiteralTerm.fromDataType(
                  "Eric", NamedNode("http://xmlns.com/foaf/0.1/stuff")),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              NamedNode("http://norman.walsh.name/knows/who/dan-brickley"),
            ),
            Quad(
              NamedNode("http://www.w3.org/People/Eric/ericP-foaf.rdf#ericP"),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              BlankNodeGraph([
                PredicateObject(NamedNode("http://xmlns.com/foaf/0.1/mbox"),
                    NamedNode("mailto:timbl@w3.org"))
              ]),
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
              BlankNodeLabel("blah"),
            ),
          ]));
    });
    test('Anonymous Subject', () {
      var result = parseTurtle("""
@prefix foaf: <http://xmlns.com/foaf/0.1/> .

[] foaf:knows <#me> .
""", baseUrl: "https://example.com/");
      expect(
          result.value,
          orderedEquals([
            Quad(
              BlankNodeGraph(<PredicateObject>[]),
              NamedNode("http://xmlns.com/foaf/0.1/knows"),
              NamedNode("https://example.com/#me"),
            ),
          ]));
    });
    test('Blank Pred List as Subject', () {
      var result = parseTurtle("""
@prefix : <http://xmlns.com/foaf/0.1/> .
[ :mbox <mailto:someone@example.com> ] :knows [ :givenName "John" ] .
""");
      expect(
          result.value,
          equals([
            Quad(
                BlankNodeGraph([
                  PredicateObject(NamedNode("http://xmlns.com/foaf/0.1/mbox"),
                      NamedNode("mailto:someone@example.com")),
                ]),
                NamedNode("http://xmlns.com/foaf/0.1/knows"),
                BlankNodeGraph([
                  PredicateObject(
                      NamedNode("http://xmlns.com/foaf/0.1/givenName"),
                      LiteralTerm.fromString("John")),
                ])),
          ]));
    });
    test('Relative URIs', () {
      var result = parseTurtle("""
  <#me> <#heart> <#you> .
""", baseUrl: "https://example.com/people");
      expect(
          result.value,
          orderedEquals([
            Quad(
              NamedNode("https://example.com/people#me"),
              NamedNode("https://example.com/people#heart"),
              NamedNode("https://example.com/people#you"),
            ),
          ]));
    });
    test('Base overriden', () {
      var result = parseTurtle("""

@base <https://example.com/people/?dont=know#me> .

  <local/path#me> <remote/path#heart> <#you> .
""", baseUrl: "https://example.com/other");
      expect(
          result.value,
          equals([
            Quad(
              NamedNode("https://example.com/people/local/path#me"),
              NamedNode("https://example.com/people/remote/path#heart"),
              NamedNode("https://example.com/people/#you"),
            ),
          ]));
    });
    test('Stated data types', () {});
    test('Primitive non-strings', () {
      var result = parseTurtle("""
@prefix : <https://example.com/> .

:me :age 37 .
:you :height -32.5 .
:me :2d false .
:you :3d true .
:a :mole +37.45e-3 .
""");
      expect(
          result.value,
          orderedEquals([
            Quad(NamedNode(""), NamedNode(""), NamedNode("")),
          ]));
    });
    test('String literals', () {
      var resp = parseTurtle("""

<me> <has> "name \\"with quotes\\"" .
<you> <have> 'single "quoted \\'strings\\'"' .
<they> <eat> '''multiline
strings ''with quotes "and stuff
''' .

<even> <double> ""\"quoted multiline strings
are
allowed ""\" .
""", baseUrl: "https://example.com/");
      expect(
          resp.value,
          equals([
            Quad(
                NamedNode("https://example.com/me"),
                NamedNode("https://example.com/has"),
                LiteralTerm.fromString('name "with quotes"')),
            Quad(
              NamedNode("https://example.com/you"),
              NamedNode("https://example.com/have"),
              LiteralTerm.fromString('''single "quoted 'strings'"'''),
            ),
            Quad(
              NamedNode("https://example.com/they"),
              NamedNode("https://example.com/eat"),
              LiteralTerm.fromString('''multiline
strings ''with quotes "and stuff
'''),
            ),
            Quad(
              NamedNode("https://example.com/even"),
              NamedNode("https://example.com/double"),
              LiteralTerm.fromString("""quoted multiline strings
are
allowed """),
            ),
          ]));
    });

    test('IRI Prefix', () {});

    test('Collection', () {
      var result = parseTurtle("""

@prefix : <https://example.com/> .

:me :ownsBooks ( :halo :discworld ) .
""");
      expect(
          result.value,
          equals([
            Quad(
                NamedNode("https://example.com/me"),
                NamedNode("https://example.com/ownsBooks"),
                BlankNodeGraph([
                  PredicateObject(
                    NamedNode(Rdf.first),
                    NamedNode("https://example.com/halo"),
                  ),
                  PredicateObject(
                    NamedNode(Rdf.rest),
                    BlankNodeGraph([
                      PredicateObject(
                        NamedNode(Rdf.first),
                        NamedNode("https://example.com/discworld"),
                      ),
                      PredicateObject(NamedNode(Rdf.rest), NamedNode(Rdf.nil)),
                    ]),
                  ),
                ])),
          ]));
    });

    test('Complex collection', () {});

    // test('Fetch from url', () async {
    //   var resp = await http.get(Uri.parse('https://www.w3.org/2006/time#'));
    //   var parsed = parseTurtle(resp.body);
    //   print(parsed);
    //   if (parsed.isFailure) {
    //     print(parsed.buffer
    //         .substring(max(parsed.position - 30, 0), parsed.position));
    //     print("V");
    //     print(parsed.buffer.substring(
    //         parsed.position, min(parsed.position + 30, parsed.buffer.length)));
    //   }
    // });

    test('Time ontology portion', () {
      var parsed = parseTurtle('''
# baseURI: http://www.w3.org/2006/time

@prefix : <http://www.w3.org/2006/time#> .
@prefix dct: <http://purl.org/dc/terms/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<http://www.w3.org/2006/time>
  rdf:type owl:Ontology ;
  dct:contributor <mailto:chris.little@metoffice.gov.uk> ;
  dct:created "2006-09-27"^^xsd:date ;
  dct:creator <http://orcid.org/0000-0002-3884-3420> ;
  dct:creator <https://en.wikipedia.org/wiki/Jerry_Hobbs> ;
  dct:creator <mailto:panfeng66@gmail.com> ;
  dct:isVersionOf <http://www.w3.org/TR/owl-time> ;
  dct:license <https://creativecommons.org/licenses/by/4.0/> ;
  dct:modified "2017-04-06"^^xsd:date ;
  dct:rights "Copyright © 2006-2017 W3C, OGC. W3C and OGC liability, trademark and document use rules apply."@en ;
  rdfs:label "OWL-Time"@en ;
  rdfs:seeAlso <http://dx.doi.org/10.3233/SW-150187> ;
  rdfs:seeAlso <http://www.semantic-web-journal.net/content/time-ontology-extended-non-gregorian-calendar-applications> ;
  rdfs:seeAlso <http://www.w3.org/TR/owl-time> ;
  owl:priorVersion <http://www.w3.org/2006/time#2006> ;
  owl:versionIRI <http://www.w3.org/2006/time#2016> ;
  skos:changeNote "2016-06-15 - initial update of OWL-Time - modified to support arbitrary temporal reference systems. " ;
  skos:changeNote "2016-12-20 - adjust range of time:timeZone to time:TimeZone, moved up from the tzont ontology.  " ;
  skos:changeNote "2016-12-20 - restore time:Year and time:January which were present in the 2006 version of the ontology, but now marked \\"deprecated\\". " ;
  skos:changeNote "2017-02 - intervalIn, intervalDisjoint, monthOfYear added; TemporalUnit subclass of TemporalDuration" ;
  skos:changeNote "2017-04-06 - hasTime, hasXSDDuration added; Number removed; all duration elements changed to xsd:decimal" ;
  skos:historyNote """Update of OWL-Time ontology, extended to support general temporal reference systems. 

Ontology engineering by Simon J D Cox"""@en ;
.
''');
      expect(
          parsed.value,
          orderedEquals([
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/1999/02/22-rdf-syntax-ns#type"),
              NamedNode("http://www.w3.org/2002/07/owl#Ontology"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/contributor"),
              NamedNode("mailto:chris.little@metoffice.gov.uk"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/created"),
              LiteralTerm.fromDataType(
                "2006-09-27",
                NamedNode(Xsd.date),
              ),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/creator"),
              NamedNode("http://orcid.org/0000-0002-3884-3420"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/creator"),
              NamedNode("https://en.wikipedia.org/wiki/Jerry_Hobbs"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/creator"),
              NamedNode("mailto:panfeng66@gmail.com"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/isVersionOf"),
              NamedNode("http://www.w3.org/TR/owl-time"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/license"),
              NamedNode("https://creativecommons.org/licenses/by/4.0/"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/modified"),
              LiteralTerm.fromDataType("2017-04-06", NamedNode(Xsd.date)),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://purl.org/dc/terms/rights"),
              LiteralTerm.languageString(
                  "Copyright © 2006-2017 W3C, OGC. W3C and OGC liability, trademark and document use rules apply.",
                  "en"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode(Rdfs.label),
              LiteralTerm.languageString("OWL-Time", "en"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode(Rdfs.seeAlso),
              NamedNode("http://dx.doi.org/10.3233/SW-150187"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode(Rdfs.seeAlso),
              NamedNode(
                  "http://www.semantic-web-journal.net/content/time-ontology-extended-non-gregorian-calendar-applications"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode(Rdfs.seeAlso),
              NamedNode("http://www.w3.org/TR/owl-time"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2002/07/owl#priorVersion"),
              NamedNode("http://www.w3.org/2006/time#2006"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2002/07/owl#versionIRI"),
              NamedNode("http://www.w3.org/2006/time#2016"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#changeNote"),
              LiteralTerm.fromString(
                  "2016-06-15 - initial update of OWL-Time - modified to support arbitrary temporal reference systems. "),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#changeNote"),
              LiteralTerm.fromString(
                  "2016-12-20 - adjust range of time:timeZone to time:TimeZone, moved up from the tzont ontology.  "),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#changeNote"),
              LiteralTerm.fromString(
                  '2016-12-20 - restore time:Year and time:January which were present in the 2006 version of the ontology, but now marked "deprecated". '),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#changeNote"),
              LiteralTerm.fromString(
                  "2017-02 - intervalIn, intervalDisjoint, monthOfYear added; TemporalUnit subclass of TemporalDuration"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#changeNote"),
              LiteralTerm.fromString(
                  "2017-04-06 - hasTime, hasXSDDuration added; Number removed; all duration elements changed to xsd:decimal"),
            ),
            Quad(
              NamedNode("http://www.w3.org/2006/time"),
              NamedNode("http://www.w3.org/2004/02/skos/core#historyNote"),
              LiteralTerm.languageString(
                  """Update of OWL-Time ontology, extended to support general temporal reference systems. 

Ontology engineering by Simon J D Cox""", "en"),
            ),
          ]));
    });
  });
}
