import 'package:rdf/rdf.dart';

void main() {
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
  print(quads.value);
}
