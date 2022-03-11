import 'rdf_base.dart';
import 'package:quiver/collection.dart';

class IndexedGraph {
  Map<Term, Multimap<Term, Term>> spo = {};
  Map<Term, Multimap<Term, Term>> osp = {};
  Map<Term, Multimap<Term, Term>> pos = {};

  factory IndexedGraph.build(Iterable<Quad> quads) {
    var g = IndexedGraph._();
    for (var quad in quads) {
      var po = g.spo[quad.subject] ?? Multimap();
      po.add(quad.predicate, quad.object);
      g.spo[quad.subject] = po;
      var sp = g.osp[quad.object] ?? Multimap();
      sp.add(quad.subject, quad.predicate);
      g.osp[quad.object] = sp;
      var os = g.pos[quad.predicate] ?? Multimap();
      os.add(quad.object, quad.subject);
      g.pos[quad.predicate] = os;
    }
    return g;
  }

  IndexedGraph._();
}
