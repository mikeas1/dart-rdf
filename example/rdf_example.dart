import 'package:rdf/rdf.dart';

void main() {
  var myQuad = Quad(
      NamedNode("http://hello.com/profile#me"),
      NamedNode("http://hello.com/vocab#stuff"),
      NamedNode("http://goodbye.com/profile#them"));
  print(myQuad);
}
