import 'package:petitparser/petitparser.dart';

class TurtleDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(statement).trim(ref0(space)).star().end();
  Parser statement() => ref0(directive) | (ref0(triples) & char('.').trim());
  Parser directive() =>
      ref0(prefixID) | ref0(base) | ref0(sparqlPrefix) | ref0(sparqlBase);
  Parser prefixID() =>
      ref1(token, '@prefix') &
      ref2(token, ref0(pNameNs), "prefix namespace") &
      ref0(iriRef) &
      ref1(token, '.');
  Parser base() =>
      ref1(token, '@base') &
      ref2(token, ref0(iriRef), "base IRI") &
      ref1(token, '.');
  Parser sparqlBase() =>
      ref2(token, stringIgnoreCase("base"), "base") &
      ref2(token, ref0(iriRef), "base IRI");
  Parser sparqlPrefix() =>
      ref2(token, stringIgnoreCase("prefix"), "prefix") &
      ref2(token, ref0(pNameNs), "prefix name") &
      ref2(token, ref0(iriRef), "prefix IRI");
  Parser triples() =>
      (ref0(subject).trim() & ref0(predicateObjectList).trim()) |
      (ref0(blankNodePropertyList).trim() &
          ref0(predicateObjectList).optional().trim());
  Parser predicateObjectList() => (ref0(verb).trim() & ref0(objectList).trim())
      .separatedBy(ref1(token, ';'),
          optionalSeparatorAtEnd: true, includeSeparators: false);
  Parser objectList() => ref0(object)
      .trim()
      .separatedBy(ref1(token, ','), includeSeparators: false);
  Parser verb() => ref0(predicate) | char('a');
  Parser subject() => ref0(iri) | ref0(blankNode) | ref0(collection);
  Parser predicate() => ref0(iri);
  Parser object() =>
      ref0(iri) |
      ref0(blankNode) |
      ref0(collection) |
      ref0(blankNodePropertyList) |
      ref0(literal);
  Parser literal() =>
      ref0(numericLiteral) | ref0(rdfLiteral) | ref0(booleanLiteral);
  Parser blankNodePropertyList() =>
      ref1(token, '[') & ref0(predicateObjectList) & ref1(token, ']');
  Parser collection() =>
      ref1(token, '(') & ref0(object).star() & ref1(token, ')');
  Parser numericLiteral() => ref0(integer) | ref0(double) | ref0(decimal);
  Parser rdfLiteral() =>
      ref0(stringLiteral) &
      // Make our life slightly easier by skipping the "^^".
      (ref0(langTag) | (string('^^') & ref0(iri)).pick(1)).optional();
  Parser booleanLiteral() => string('true') | string('false');
  Parser stringLiteral() =>
      ref0(stringLiteralQuote) |
      ref0(stringLiteralSingleQuote) |
      ref0(stringLiteralLongSingleQuote) |
      ref0(stringLiteralLongQuote);
  Parser iri() => ref0(iriRef) | ref0(prefixedName);
  Parser prefixedName() => ref0(pNameLn) | ref0(pNameNs);
  Parser blankNode() => ref0(blankNodeLabel) | ref0(anon);

  Parser iriRef() =>
      char('<') &
      (pattern('^\u{00}-\u{20}<>"{}|^`\\') | ref0(uchar)).star().flatten() &
      char('>');
  Parser pNameNs() => ref0(pnPrefix).optional() & char(':');
  Parser pNameLn() => ref0(pNameNs).flatten() & ref0(pnLocal);
  Parser blankNodeLabel() =>
      string('_:') &
      ((ref0(pnCharsU) | digit()) &
              ((ref0(pnCharsU) | char('.')).starGreedy(ref0(pnChars)) &
                      ref0(pnChars))
                  .optional())
          .flatten();
  Parser langTag() =>
      char('@') &
      (pattern('a-zA-Z').plus() & (char('-') & pattern('a-zA-Z').plus()).star())
          .flatten();
  Parser integer() => (pattern('-+') & digit().plus()).flatten().trim();
  Parser decimal() =>
      (pattern('-+') & digit().star() & char('.') & digit().plus())
          .flatten()
          .trim();
  Parser double() => (pattern('-+').optional() &
          ((digit().plus() & char('.') & digit().star() & ref0(exponent)) |
              (char('.') & digit().plus() & ref0(exponent)) |
              (digit().plus() & ref0(exponent))))
      .flatten()
      .trim();
  Parser exponent() =>
      pattern('eE') & pattern('-+').optional() & digit().plus();
  Parser stringLiteralQuote() =>
      char('"') &
      (pattern('^\u{22}\u{5C}\u{0A}\u{D}') | ref0(echar) | ref0(uchar))
          .star()
          .flatten() &
      char('"');
  Parser stringLiteralSingleQuote() =>
      char("'") &
      (pattern('^\u{27}\u{5C}\u{0A}\u{D}') | ref0(echar) | ref0(uchar))
          .star()
          .flatten() &
      char("'");
  Parser stringLiteralLongSingleQuote() =>
      string("'''") &
      ((char("'") | string("''")).optional() &
              (pattern("^'\\") | ref0(echar) | ref0(uchar)))
          .star()
          .flatten() &
      string("'''");
  Parser stringLiteralLongQuote() =>
      string('"""') &
      ((char('"') | string('""')).optional() &
              (pattern('^"\\') | ref0(echar) | ref0(uchar)))
          .star()
          .flatten() &
      string('"""');
  Parser uchar() =>
      (char('\\') & char('x') & ref0(hex).repeat(3).flatten()) |
      (char('\\') & char('X') & ref0(hex).repeat(7).flatten());
  Parser echar() => (char('\\') & pattern('tbnrf"\'\\'));
  Parser ws() =>
      char('\u{20}') | char('\u{09}') | char('\u{0D}') | char('\u{0A}');
  Parser anon() => char('[') & ref0(ws).star() & char(']');
  Parser pnCharsBase() =>
      pattern('A-Za-z') |
      pattern('\u{00C0}-\u{00D6}') |
      pattern('\u{00D8}-\u{00F6}') |
      pattern('\u{00F8}-\u{02FF}') |
      pattern('\u{0370}-\u{037D}') |
      pattern('\u{037F}-\u{1FFF}') |
      pattern('\u{200C}-\u{200D}') |
      pattern('\u{2070}-\u{218F}') |
      pattern('\u{2C00}-\u{2FEF}') |
      pattern('\u{3001}-\u{D7FF}') |
      pattern('\u{F900}-\u{FDCF}') |
      pattern('\u{FDF0}-\u{FFFD}');
  // pattern('\u{10000}-\u{EFFFF}');
  Parser pnCharsU() => ref0(pnCharsBase) | char('_');
  Parser pnChars() =>
      ref0(pnCharsU) |
      char('-') |
      pattern('0-9') |
      char('\u{00B7}') |
      pattern('\u{0300}-\u{036F}') |
      pattern('\u{203F}-\u{2040}');
  Parser pnPrefix() => (ref0(pnCharsBase) &
          ((ref0(pnChars) | char('.')).starGreedy(ref0(pnChars)) &
                  ref0(pnChars))
              .optional())
      .flatten();
  Parser pnLocal() => ((ref0(pnCharsU) | char(':') | digit() | ref0(plx)) &
          // TODO: The greedy nature of the star within a sequence means this fails on a single character
          ((ref0(pnChars) | char('.') | char(':') | ref0(plx))
                      .starGreedy(ref0(pnChars) | char(':') | ref0(plx)) &
                  (ref0(pnChars) | char(':') | ref0(plx)))
              .optionalWith(["beepboop"]))
      .flatten();
  Parser plx() => ref0(percent) | ref0(pnLocalEsc);
  Parser percent() => char('%') & (ref0(hex) & ref0(hex)).flatten();
  Parser hex() => pattern('a-f0-9A-F');
  Parser pnLocalEsc() => char('\\') & pattern('-_~.!\$&\'()*+,;=/?#@%');
  Parser comment() => char('#') & Token.newlineParser().neg().star();
  Parser space() => whitespace();

  Parser token(Object source, [String? name]) {
    if (source is String) {
      return source.toParser(message: 'Expected ${name ?? source}').trim();
    } else if (source is Parser) {
      ArgumentError.checkNotNull(name, 'name');
      return source.flatten('Expected $name').trim();
    } else {
      throw ArgumentError('Unknown token type: $source.');
    }
  }
}
