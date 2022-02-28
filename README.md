A library for working with RDF data in Dart.

## Features

At the moment, this package is largely used as a common data model for RDF types. The data model is intended to be similar to [rdfjs](http://rdf.js.org/).
## Getting started


## Usage

Create a Quad 

```dart
import 'package:rdf/rdf.dart';

var q1 = Quad(NamedNode("bob"), NamedNode("knows"), BlankNode("john"));
var q2 = Quad(BlankNode("john"), NamedNode("givenName"), LiteralTerm.languageString("John", "en"));
```

## Additional information


