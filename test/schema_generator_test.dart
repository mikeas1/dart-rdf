const timeSchema = '''
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
  skos:changeNote "2016-12-20 - restore time:Year and time:January which were present in the 2006 version of the ontology, but now marked "deprecated". " ;
  skos:changeNote "2017-02 - intervalIn, intervalDisjoint, monthOfYear added; TemporalUnit subclass of TemporalDuration" ;
  skos:changeNote "2017-04-06 - hasTime, hasXSDDuration added; Number removed; all duration elements changed to xsd:decimal" ;
  skos:historyNote """Update of OWL-Time ontology, extended to support general temporal reference systems. 

Ontology engineering by Simon J D Cox"""@en ;
.
:DateTimeDescription
  rdf:type owl:Class ;
  rdfs:comment "Description of date and time structured with separate values for the various elements of a calendar-clock system. The temporal reference system is fixed to Gregorian Calendar, and the range of year, month, day properties restricted to corresponding XML Schema types xsd:gYear, xsd:gMonth and xsd:gDay, respectively."@en ;
  rdfs:label "Date-Time description"@en ;
  rdfs:subClassOf :GeneralDateTimeDescription ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:gDay ;
      owl:onProperty :day ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:gMonth ;
      owl:onProperty :month ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:gYear ;
      owl:onProperty :year ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:hasValue <http://www.opengis.net/def/uom/ISO-8601/0/Gregorian> ;
      owl:onProperty :hasTRS ;
    ] ;
  skos:definition "Description of date and time structured with separate values for the various elements of a calendar-clock system. The temporal reference system is fixed to Gregorian Calendar, and the range of year, month, day properties restricted to corresponding XML Schema types xsd:gYear, xsd:gMonth and xsd:gDay, respectively."@en ;
.
:DateTimeInterval
  rdf:type owl:Class ;
  rdfs:comment "DateTimeInterval is a subclass of ProperInterval, defined using the multi-element DateTimeDescription."@en ;
  rdfs:label "Date-time interval"@en ;
  rdfs:subClassOf :ProperInterval ;
  skos:definition "DateTimeInterval is a subclass of ProperInterval, defined using the multi-element DateTimeDescription."@en ;
  skos:note ":DateTimeInterval can only be used for an interval whose limits coincide with a date-time element aligned to the calendar and timezone indicated. For example, while both have a duration of one day, the 24-hour interval beginning at midnight at the beginning of 8 May in Central Europe can be expressed as a :DateTimeInterval, but the 24-hour interval starting at 1:30pm cannot."@en ;
.
:DayOfWeek
  rdf:type owl:Class ;
  rdfs:comment "The day of week"@en ;
  rdfs:label "Day of week"@en ;
  rdfs:subClassOf owl:Thing ;
  skos:changeNote """Remove enumeration from definition, in order to allow other days to be used when required in other calendars. 
NOTE: existing days are still present as members of the class, but the class membership is now open. 

In the original OWL-Time the following constraint appeared: 
  owl:oneOf (
      time:Monday
      time:Tuesday
      time:Wednesday
      time:Thursday
      time:Friday
      time:Saturday
      time:Sunday
    ) ;"""@en ;
  skos:definition "The day of week"@en ;
  skos:note "Membership of the class :DayOfWeek is open, to allow for alternative week lengths and different day names."@en ;
.
:Duration
  rdf:type owl:Class ;
  rdfs:comment "Duration of a temporal extent expressed as a number scaled by a temporal unit"@en ;
  rdfs:label "Time duration"@en ;
  rdfs:subClassOf :TemporalDuration ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :numericDuration ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :unitType ;
    ] ;
  skos:definition "Duration of a temporal extent expressed as a number scaled by a temporal unit"@en ;
  skos:note "Alternative to time:DurationDescription to support description of a temporal duration other than using a calendar/clock system."@en ;
.
:DurationDescription
  rdf:type owl:Class ;
  rdfs:comment "Description of temporal extent structured with separate values for the various elements of a calendar-clock system. The temporal reference system is fixed to Gregorian Calendar, and the range of each of the numeric properties is restricted to xsd:decimal"@en ;
  rdfs:label "Duration description"@en ;
  rdfs:subClassOf :GeneralDurationDescription ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :days ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :hours ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :minutes ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :months ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :seconds ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :weeks ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:allValuesFrom xsd:decimal ;
      owl:onProperty :years ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:hasValue <http://www.opengis.net/def/uom/ISO-8601/0/Gregorian> ;
      owl:onProperty :hasTRS ;
    ] ;
  skos:definition "Description of temporal extent structured with separate values for the various elements of a calendar-clock system. The temporal reference system is fixed to Gregorian Calendar, and the range of each of the numeric properties is restricted to xsd:decimal"@en ;
  skos:note "In the Gregorian calendar the length of the month is not fixed. Therefore, a value like "2.5 months" cannot be exactly compared with a similar duration expressed in terms of weeks or days."@en ;
.
:Friday
  rdf:type :DayOfWeek ;
  rdfs:label "Friday"@en ;
  skos:prefLabel "Freitag"@de ;
  skos:prefLabel "Friday"@en ;
  skos:prefLabel "Piątek"@pl ;
  skos:prefLabel "Sexta-feira"@pt ;
  skos:prefLabel "Vendredi"@fr ;
  skos:prefLabel "Venerdì"@it ;
  skos:prefLabel "Viernes"@es ;
  skos:prefLabel "Vrijdag"@nl ;
  skos:prefLabel "Пятница"@ru ;
  skos:prefLabel "الجمعة"@ar ;
  skos:prefLabel "星期五"@zh ;
  skos:prefLabel "金曜日"@ja ;
.
:GeneralDateTimeDescription
  rdf:type owl:Class ;
  rdfs:comment "Description of date and time structured with separate values for the various elements of a calendar-clock system"@en ;
  rdfs:label "Generalized date-time description"@en ;
  rdfs:subClassOf :TemporalPosition ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :unitType ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :day ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :dayOfWeek ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :dayOfYear ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :hour ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :minute ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :month ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :monthOfYear ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :second ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :timeZone ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :week ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :year ;
    ] ;
  skos:definition "Description of date and time structured with separate values for the various elements of a calendar-clock system"@en ;
  skos:note "Some combinations of properties are redundant - for example, within a specified :year if :dayOfYear is provided then :day and :month can be computed, and vice versa. Individual values should be consistent with each other and the calendar, indicated through the value of the :hasTRS property." ;
.
:GeneralDurationDescription
  rdf:type owl:Class ;
  rdfs:comment "Description of temporal extent structured with separate values for the various elements of a calendar-clock system."@en ;
  rdfs:label "Generalized duration description"@en ;
  rdfs:subClassOf :TemporalDuration ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :hasTRS ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :days ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :hours ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :minutes ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :months ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :seconds ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :weeks ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:maxCardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :years ;
    ] ;
  skos:definition "Description of temporal extent structured with separate values for the various elements of a calendar-clock system."@en ;
  skos:note "The extent of a time duration expressed as a GeneralDurationDescription depends on the Temporal Reference System. In some calendars the length of the week or month is not constant within the year. Therefore, a value like "2.5 months" may not necessarily be exactly compared with a similar duration expressed in terms of weeks or days. When non-earth-based calendars are considered even more care must be taken in comparing durations."@en ;
.
:Instant
  rdf:type owl:Class ;
  rdfs:comment "A temporal entity with zero extent or duration"@en ;
  rdfs:label "Time instant"@en ;
  rdfs:subClassOf :TemporalEntity ;
  skos:definition "A temporal entity with zero extent or duration"@en ;
.
:Interval
  rdf:type owl:Class ;
  rdfs:comment "A temporal entity with an extent or duration"@en ;
  rdfs:label "Time interval"@en ;
  rdfs:subClassOf :TemporalEntity ;
  skos:definition "A temporal entity with an extent or duration"@en ;
.
:January
  rdf:type owl:Class ;
  rdf:type owl:DeprecatedClass ;
  rdfs:label "January" ;
  rdfs:subClassOf :DateTimeDescription ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:hasValue :unitMonth ;
      owl:onProperty :unitType ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:hasValue "--01" ;
      owl:onProperty :month ;
    ] ;
  owl:deprecated "true"^^xsd:boolean ;
  skos:historyNote "This class was present in the 2006 version of OWL-Time. It was presented as an example of how DateTimeDescription could be specialized, but does not belong in the revised ontology. " ;
.
:Monday
  rdf:type :DayOfWeek ;
  rdfs:label "Monday"@en ;
  skos:prefLabel "Lundi"@fr ;
  skos:prefLabel "Lunedì"@it ;
  skos:prefLabel "Lunes"@es ;
  skos:prefLabel "Maandag"@nl ;
  skos:prefLabel "Monday"@en ;
  skos:prefLabel "Montag"@de ;
  skos:prefLabel "Poniedziałek"@pl ;
  skos:prefLabel "Segunda-feira"@pt ;
  skos:prefLabel "Понедельник"@ru ;
  skos:prefLabel "الاثنين"@ar ;
  skos:prefLabel "星期一"@zh ;
  skos:prefLabel "月曜日"@ja ;
.
:MonthOfYear
  rdf:type owl:Class ;
  rdfs:comment "The month of the year"@en ;
  rdfs:label "Month of year"@en ;
  rdfs:subClassOf :DateTimeDescription ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :day ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :hour ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :minute ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :second ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :week ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "0"^^xsd:nonNegativeInteger ;
      owl:onProperty :year ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :month ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:hasValue :unitMonth ;
      owl:onProperty :unitType ;
    ] ;
  skos:definition "The month of the year"@en ;
  skos:editorialNote "Feature at risk - added in 2017 revision, and not yet widely used. "@en ;
  skos:note "Membership of the class :MonthOfYear is open, to allow for alternative annual calendars and different month names."@en ;
.
:ProperInterval
  rdf:type owl:Class ;
  rdfs:comment "A temporal entity with non-zero extent or duration, i.e. for which the value of the beginning and end are different"@en ;
  rdfs:label "Proper interval"@en ;
  rdfs:subClassOf :Interval ;
  owl:disjointWith :Instant ;
  skos:definition "A temporal entity with non-zero extent or duration, i.e. for which the value of the beginning and end are different"@en ;
.
:Saturday
  rdf:type :DayOfWeek ;
  rdfs:label "Saturday"@en ;
  skos:prefLabel "Sabato"@it ;
  skos:prefLabel "Samedi"@fr ;
  skos:prefLabel "Samstag"@de ;
  skos:prefLabel "Saturday"@en ;
  skos:prefLabel "Sobota"@pl ;
  skos:prefLabel "Sábado"@es ;
  skos:prefLabel "Sábado"@pt ;
  skos:prefLabel "Zaterdag"@nl ;
  skos:prefLabel "Суббота"@ru ;
  skos:prefLabel "السبت"@ar ;
  skos:prefLabel "土曜日"@ja ;
  skos:prefLabel "星期六"@zh ;
.
:Sunday
  rdf:type :DayOfWeek ;
  rdfs:label "Sunday"@en ;
  skos:prefLabel "Dimanche"@fr ;
  skos:prefLabel "Domenica"@it ;
  skos:prefLabel "Domingo"@es ;
  skos:prefLabel "Domingo"@pt ;
  skos:prefLabel "Niedziela"@pl ;
  skos:prefLabel "Sonntag"@de ;
  skos:prefLabel "Sunday"@en ;
  skos:prefLabel "Zondag"@nl ;
  skos:prefLabel "Воскресенье"@ru ;
  skos:prefLabel "الأحد (يوم)"@ar ;
  skos:prefLabel "日曜日"@ja ;
  skos:prefLabel "星期日"@zh ;
.
:TRS
  rdf:type owl:Class ;
  rdfs:comment """A temporal reference system, such as a temporal coordinate system (with an origin, direction, and scale), a calendar-clock combination, or a (possibly hierarchical) ordinal system. 

This is a stub class, representing the set of all temporal reference systems."""@en ;
  rdfs:label "Temporal Reference System"@en ;
  skos:definition """A temporal reference system, such as a temporal coordinate system (with an origin, direction, and scale), a calendar-clock combination, or a (possibly hierarchical) ordinal system. 

This is a stub class, representing the set of all temporal reference systems."""@en ;
  skos:note "A taxonomy of temporal reference systems is provided in ISO 19108:2002 [ISO19108], including (a) calendar + clock systems; (b) temporal coordinate systems (i.e. numeric offset from an epoch); (c) temporal ordinal reference systems (i.e. ordered sequence of named intervals, not necessarily of equal duration)."@en ;
.
:TemporalDuration
  rdf:type owl:Class ;
  rdfs:comment "Time extent; duration of a time interval separate from its particular start position"@en ;
  rdfs:label "Temporal duration"@en ;
  skos:definition "Time extent; duration of a time interval separate from its particular start position"@en ;
.
:TemporalEntity
  rdf:type owl:Class ;
  rdfs:comment "A temporal interval or instant."@en ;
  rdfs:label "Temporal entity"@en ;
  rdfs:subClassOf owl:Thing ;
  owl:unionOf (
      :Instant
      :Interval
    ) ;
  skos:definition "A temporal interval or instant."@en ;
.
:TemporalPosition
  rdf:type owl:Class ;
  rdfs:comment "A position on a time-line"@en ;
  rdfs:label "Temporal position"@en ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality "1"^^xsd:nonNegativeInteger ;
      owl:onProperty :hasTRS ;
    ] ;
  skos:definition "A position on a time-line"@en ;
.
:TemporalUnit
  rdf:type owl:Class ;
  rdfs:comment "A standard duration, which provides a scale factor for a time extent, or the granularity or precision for a time position."@en ;
  rdfs:label "Temporal unit"@en ;
  rdfs:subClassOf :TemporalDuration ;
  skos:changeNote """Remove enumeration from definition, in order to allow other units to be used when required in other coordinate systems. 
NOTE: existing units are still present as members of the class, but the class membership is now open. 

In the original OWL-Time the following constraint appeared: 
  owl:oneOf (
      time:unitSecond
      time:unitMinute
      time:unitHour
      time:unitDay
      time:unitWeek
      time:unitMonth
      time:unitYear
    ) ;"""@en ;
  skos:definition "A standard duration, which provides a scale factor for a time extent, or the granularity or precision for a time position."@en ;
  skos:note "Membership of the class TemporalUnit is open, to allow for other temporal units used in some technical applications (e.g. millions of years, Baha'i month)."@en ;
.
:Thursday
  rdf:type :DayOfWeek ;
  rdfs:label "Thursday"@en ;
  skos:prefLabel "Czwartek"@pl ;
  skos:prefLabel "Donderdag"@nl ;
  skos:prefLabel "Donnerstag"@de ;
  skos:prefLabel "Giovedì"@it ;
  skos:prefLabel "Jeudi"@fr ;
  skos:prefLabel "Jueves"@es ;
  skos:prefLabel "Quinta-feira"@pt ;
  skos:prefLabel "Thursday"@en ;
  skos:prefLabel "Четверг"@ru ;
  skos:prefLabel "الخميس"@ar ;
  skos:prefLabel "星期四"@zh ;
  skos:prefLabel "木曜日"@ja ;
.
:TimePosition
  rdf:type owl:Class ;
  rdfs:comment "A temporal position described using either a (nominal) value from an ordinal reference system, or a (numeric) value in a temporal coordinate system. "@en ;
  rdfs:label "Time position"@en ;
  rdfs:subClassOf :TemporalPosition ;
  rdfs:subClassOf [
      rdf:type owl:Class ;
      owl:unionOf (
          [
            rdf:type owl:Restriction ;
            owl:cardinality "1"^^xsd:nonNegativeInteger ;
            owl:onProperty :numericPosition ;
          ]
          [
            rdf:type owl:Restriction ;
            owl:cardinality "1"^^xsd:nonNegativeInteger ;
            owl:onProperty :nominalPosition ;
          ]
        ) ;
    ] ;
  skos:definition "A temporal position described using either a (nominal) value from an ordinal reference system, or a (numeric) value in a temporal coordinate system. "@en ;
.
:TimeZone
  rdf:type owl:Class ;
  rdfs:comment """A Time Zone specifies the amount by which the local time is offset from UTC. 
	A time zone is usually denoted geographically (e.g. Australian Eastern Daylight Time), with a constant value in a given region. 
The region where it applies and the offset from UTC are specified by a locally recognised governing authority."""@en ;
  rdfs:label "Time Zone"@en ;
  skos:definition """A Time Zone specifies the amount by which the local time is offset from UTC. 
	A time zone is usually denoted geographically (e.g. Australian Eastern Daylight Time), with a constant value in a given region. 
The region where it applies and the offset from UTC are specified by a locally recognised governing authority."""@en ;
  skos:historyNote """In the original 2006 version of OWL-Time, the TimeZone class, with several properties corresponding to a specific model of time-zones, was defined in a separate namespace "http://www.w3.org/2006/timezone#". 

In the current version a class with same local name is put into the main OWL-Time namespace, removing the dependency on the external namespace. 

An alignment axiom 
	tzont:TimeZone rdfs:subClassOf time:TimeZone . 
allows data encoded according to the previous version to be consistent with the updated ontology. """ ;
  skos:note """A designated timezone is associated with a geographic region. However, for a particular region the offset from UTC often varies seasonally, and the dates of the changes may vary from year to year. The timezone designation usually changes for the different seasons (e.g. Australian Eastern Standard Time vs. Australian Eastern Daylight Time). Furthermore, the offset for a timezone may change over longer timescales, though its designation might not.  

Detailed guidance about working with time zones is given in http://www.w3.org/TR/timezone/ ."""@en ;
  skos:note "An ontology for time zone descriptions was described in [owl-time-20060927] and provided as RDF in a separate namespace tzont:. However, that ontology was incomplete in scope, and the example datasets were selective. Furthermore, since the use of a class from an external ontology as the range of an ObjectProperty in OWL-Time creates a dependency, reference to the time zone class has been replaced with the 'stub' class in the normative part of this version of OWL-Time."@en ;
  skos:scopeNote "In this implementation TimeZone has no properties defined. It should be thought of as an 'abstract' superclass of all specific timezone implementations." ;
.
:Tuesday
  rdf:type :DayOfWeek ;
  rdfs:label "Tuesday"@en ;
  skos:prefLabel "Dienstag"@de ;
  skos:prefLabel "Dinsdag"@nl ;
  skos:prefLabel "Mardi"@fr ;
  skos:prefLabel "Martedì"@it ;
  skos:prefLabel "Martes"@es ;
  skos:prefLabel "Terça-feira"@pt ;
  skos:prefLabel "Tuesday"@en ;
  skos:prefLabel "Wtorek"@pl ;
  skos:prefLabel "Вторник"@ru ;
  skos:prefLabel "الثلاثاء"@ar ;
  skos:prefLabel "星期二"@zh ;
  skos:prefLabel "火曜日"@ja ;
.
:Wednesday
  rdf:type :DayOfWeek ;
  rdfs:label "Wednesday"@en ;
  skos:prefLabel "Mercoledì"@it ;
  skos:prefLabel "Mercredi"@fr ;
  skos:prefLabel "Mittwoch"@de ;
  skos:prefLabel "Miércoles"@es ;
  skos:prefLabel "Quarta-feira"@pt ;
  skos:prefLabel "Wednesday"@en ;
  skos:prefLabel "Woensdag"@nl ;
  skos:prefLabel "Środa"@pl ;
  skos:prefLabel "Среда"@ru ;
  skos:prefLabel "الأربعاء"@ar ;
  skos:prefLabel "星期三"@zh ;
  skos:prefLabel "水曜日"@ja ;
.
:Year
  rdf:type owl:Class ;
  rdf:type owl:DeprecatedClass ;
  rdfs:comment "Year duration" ;
  rdfs:label "Year"@en ;
  rdfs:subClassOf :DurationDescription ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :days ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :hours ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :minutes ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :months ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :seconds ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 0 ;
      owl:onProperty :weeks ;
    ] ;
  rdfs:subClassOf [
      rdf:type owl:Restriction ;
      owl:cardinality 1 ;
      owl:onProperty :years ;
    ] ;
  owl:deprecated "true"^^xsd:boolean ;
  skos:definition "Year duration" ;
  skos:historyNote """Year was proposed in the 2006 version of OWL-Time as an example of how DurationDescription could be specialized to allow for a duration to be restricted to a number of years. 

It is deprecated in this edition of OWL-Time. """ ;
  skos:prefLabel "Anno"@it ;
  skos:prefLabel "Année (calendrier)"@fr ;
  skos:prefLabel "Ano"@pt ;
  skos:prefLabel "Año"@es ;
  skos:prefLabel "Jaar"@nl ;
  skos:prefLabel "Jahr"@de ;
  skos:prefLabel "Rok"@pl ;
  skos:prefLabel "Year"@en ;
  skos:prefLabel "Год"@ru ;
  skos:prefLabel "سنة"@ar ;
  skos:prefLabel "年"@ja ;
  skos:prefLabel "年"@zh ;
.
:after
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Gives directionality to time. If a temporal entity T1 is after another temporal entity T2, then the beginning of T1 is after the end of T2."@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "after"@en ;
  rdfs:range :TemporalEntity ;
  owl:inverseOf :before ;
  skos:definition "Gives directionality to time. If a temporal entity T1 is after another temporal entity T2, then the beginning of T1 is after the end of T2."@en ;
.
:before
  rdf:type owl:ObjectProperty ;
  rdf:type owl:TransitiveProperty ;
  rdfs:comment "Gives directionality to time. If a temporal entity T1 is before another temporal entity T2, then the end of T1 is before the beginning of T2. Thus, "before" can be considered to be basic to instants and derived for intervals."@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "before"@en ;
  rdfs:range :TemporalEntity ;
  owl:inverseOf :after ;
  skos:definition "Gives directionality to time. If a temporal entity T1 is before another temporal entity T2, then the end of T1 is before the beginning of T2. Thus, "before" can be considered to be basic to instants and derived for intervals."@en ;
.
:day
  rdf:type owl:DatatypeProperty ;
  rdfs:comment """Day position in a calendar-clock system.

The range of this property is not specified, so can be replaced by any specific representation of a calendar day from any calendar. """@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "day"@en ;
  skos:definition """Day position in a calendar-clock system.

The range of this property is not specified, so can be replaced by any specific representation of a calendar day from any calendar. """@en ;
.
:dayOfWeek
  rdf:type owl:ObjectProperty ;
  rdfs:comment "The day of week, whose value is a member of the class time:DayOfWeek"@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "day of week"@en ;
  rdfs:range :DayOfWeek ;
  skos:definition "The day of week, whose value is a member of the class time:DayOfWeek"@en ;
.
:dayOfYear
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "The number of the day within the year"@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "day of year"@en ;
  rdfs:range xsd:nonNegativeInteger ;
  skos:definition "The number of the day within the year"@en ;
.
:days
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in days"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "days duration"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "length of, or element of the length of, a temporal extent expressed in days"@en ;
.
:generalDay
  rdf:type rdfs:Datatype ;
  rdfs:comment """Day of month - formulated as a text string with a pattern constraint to reproduce the same lexical form as gDay, except that values up to 99 are permitted, in order to support calendars with more than 31 days in a month. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
  rdfs:label "Generalized day"@en ;
  owl:onDatatype xsd:string ;
  owl:withRestrictions (
      [
        xsd:pattern "---(0[1-9]|[1-9][0-9])(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?" ;
      ]
    ) ;
  skos:definition """Day of month - formulated as a text string with a pattern constraint to reproduce the same lexical form as gDay, except that values up to 99 are permitted, in order to support calendars with more than 31 days in a month. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
.
:generalMonth
  rdf:type rdfs:Datatype ;
  rdfs:comment """Month of year - formulated as a text string with a pattern constraint to reproduce the same lexical form as gMonth, except that values up to 20 are permitted, in order to support calendars with more than 12 months in the year. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
  rdfs:label "Generalized month"@en ;
  owl:onDatatype xsd:string ;
  owl:withRestrictions (
      [
        xsd:pattern "--(0[1-9]|1[0-9]|20)(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?" ;
      ]
    ) ;
  skos:definition """Month of year - formulated as a text string with a pattern constraint to reproduce the same lexical form as gMonth, except that values up to 20 are permitted, in order to support calendars with more than 12 months in the year. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
.
:generalYear
  rdf:type rdfs:Datatype ;
  rdfs:comment """Year number - formulated as a text string with a pattern constraint to reproduce the same lexical form as gYear, but not restricted to values from the Gregorian calendar. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
  rdfs:label "Generalized year"@en ;
  owl:onDatatype xsd:string ;
  owl:withRestrictions (
      [
        xsd:pattern "-?([1-9][0-9]{3,}|0[0-9]{3})(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?" ;
      ]
    ) ;
  skos:definition """Year number - formulated as a text string with a pattern constraint to reproduce the same lexical form as gYear, but not restricted to values from the Gregorian calendar. 
Note that the value-space is not defined, so a generic OWL2 processor cannot compute ordering relationships of values of this type."""@en ;
.
:hasBeginning
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Beginning of a temporal entity"@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "has beginning"@en ;
  rdfs:range :Instant ;
  rdfs:subPropertyOf :hasTime ;
  skos:definition "Beginning of a temporal entity."@en ;
.
:hasDateTimeDescription
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Value of DateTimeInterval expressed as a structured value. The beginning and end of the interval coincide with the limits of the shortest element in the description."@en ;
  rdfs:domain :DateTimeInterval ;
  rdfs:label "has Date-Time description"@en ;
  rdfs:range :GeneralDateTimeDescription ;
  skos:definition "Value of DateTimeInterval expressed as a structured value. The beginning and end of the interval coincide with the limits of the shortest element in the description."@en ;
.
:hasDuration
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Duration of a temporal entity, expressed as a scaled value or nominal value"@en ;
  rdfs:label "has duration"@en ;
  rdfs:range :Duration ;
  rdfs:subPropertyOf :hasTemporalDuration ;
  skos:definition "Duration of a temporal entity, event or activity, or thing, expressed as a scaled value"@en ;
.
:hasDurationDescription
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Duration of a temporal entity, expressed using a structured description"@en ;
  rdfs:label "has duration description"@en ;
  rdfs:range :GeneralDurationDescription ;
  rdfs:subPropertyOf :hasTemporalDuration ;
  skos:definition "Duration of a temporal entity, expressed using a structured description"@en ;
.
:hasEnd
  rdf:type owl:ObjectProperty ;
  rdfs:comment "End of a temporal entity."@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "has end"@en ;
  rdfs:range :Instant ;
  rdfs:subPropertyOf :hasTime ;
  skos:definition "End of a temporal entity."@en ;
.
:hasTRS
  rdf:type owl:FunctionalProperty ;
  rdf:type owl:ObjectProperty ;
  rdfs:comment "The temporal reference system used by a temporal position or extent description. "@en ;
  rdfs:domain [
      rdf:type owl:Class ;
      owl:unionOf (
          :TemporalPosition
          :GeneralDurationDescription
        ) ;
    ] ;
  rdfs:label "Temporal reference system used"@en ;
  rdfs:range :TRS ;
  skos:definition "The temporal reference system used by a temporal position or extent description. "@en ;
.
:hasTemporalDuration
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Duration of a temporal entity."@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "has temporal duration"@en ;
  rdfs:range :TemporalDuration ;
  skos:definition "Duration of a temporal entity."@en ;
.
:hasTime
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Supports the association of a temporal entity (instant or interval) to any thing"@en ;
  rdfs:label "has time"@en ;
  rdfs:range :TemporalEntity ;
  skos:definition "Supports the association of a temporal entity (instant or interval) to any thing"@en ;
  skos:editorialNote "Feature at risk - added in 2017 revision, and not yet widely used. "@en ;
.
:hasXSDDuration
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Extent of a temporal entity, expressed using xsd:duration"@en ;
  rdfs:domain :TemporalEntity ;
  rdfs:label "has XSD duration"@en ;
  rdfs:range xsd:duration ;
  skos:definition "Extent of a temporal entity, expressed using xsd:duration"@en ;
  skos:editorialNote "Feature at risk - added in 2017 revision, and not yet widely used. "@en ;
.
:hour
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Hour position in a calendar-clock system."@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "hour"@en ;
  rdfs:range xsd:nonNegativeInteger ;
  skos:definition "Hour position in a calendar-clock system."@en ;
.
:hours
  rdf:type owl:https://www.w3.org/2006/time#DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in hours"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "hours duration"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "length of, or element of the length of, a temporal extent expressed in hours"@en ;
.
:inDateTime
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Position of an instant, expressed using a structured description"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in date-time description"@en ;
  rdfs:range :GeneralDateTimeDescription ;
  rdfs:subPropertyOf :inTemporalPosition ;
  skos:definition "Position of an instant, expressed using a structured description"@en ;
.
:inTemporalPosition
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Position of a time instant"@en ;
  rdfs:domain :Instant ;
  rdfs:label "Temporal position"@en ;
  rdfs:range :TemporalPosition ;
  skos:definition "Position of a time instant"@en ;
.
:inTimePosition
  rdf:type owl:ObjectProperty ;
  rdfs:comment "Position of an instant, expressed as a temporal coordinate or nominal value"@en ;
  rdfs:domain :Instant ;
  rdfs:label "Time position"@en ;
  rdfs:range :TimePosition ;
  rdfs:subPropertyOf :inTemporalPosition ;
  skos:definition "Position of a time instant expressed as a TimePosition"@en ;
.
:inXSDDate
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Position of an instant, expressed using xsd:date"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in XSD date"@en ;
  rdfs:range xsd:date ;
  skos:definition "Position of an instant, expressed using xsd:date"@en ;
.
:inXSDDateTime
  rdf:type owl:DatatypeProperty ;
  rdf:type owl:DeprecatedProperty ;
  rdfs:comment "Position of an instant, expressed using xsd:dateTime"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in XSD Date-Time"@en ;
  rdfs:range xsd:dateTime ;
  owl:deprecated "true"^^xsd:boolean ;
  skos:definition "Position of an instant, expressed using xsd:dateTime"@en ;
  skos:note "The property :inXSDDateTime is replaced by :inXSDDateTimeStamp which makes the time-zone field mandatory."@en ;
.
:inXSDDateTimeStamp
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Position of an instant, expressed using xsd:dateTimeStamp"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in XSD Date-Time-Stamp"@en ;
  rdfs:range xsd:dateTimeStamp ;
  skos:definition "Position of an instant, expressed using xsd:dateTimeStamp"@en ;
.
:inXSDgYear
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Position of an instant, expressed using xsd:gYear"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in XSD g-Year"@en ;
  rdfs:range xsd:gYear ;
  skos:definition "Position of an instant, expressed using xsd:gYear"@en ;
.
:inXSDgYearMonth
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Position of an instant, expressed using xsd:gYearMonth"@en ;
  rdfs:domain :Instant ;
  rdfs:label "in XSD g-YearMonth"@en ;
  rdfs:range xsd:gYearMonth ;
  skos:definition "Position of an instant, expressed using xsd:gYearMonth"@en ;
.
:inside
  rdf:type owl:ObjectProperty ;
  rdfs:comment "An instant that falls inside the interval. It is not intended to include beginnings and ends of intervals."@en ;
  rdfs:domain :Interval ;
  rdfs:label "has time instant inside"@en ;
  rdfs:range :Instant ;
  skos:definition "An instant that falls inside the interval. It is not intended to include beginnings and ends of intervals."@en ;
.
:intervalAfter
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalAfter another proper interval T2, then the beginning of T1 is after the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval after"@en ;
  rdfs:range :ProperInterval ;
  rdfs:subPropertyOf :after ;
  rdfs:subPropertyOf :intervalDisjoint ;
  owl:inverseOf :intervalBefore ;
  skos:definition "If a proper interval T1 is intervalAfter another proper interval T2, then the beginning of T1 is after the end of T2."@en ;
.
:intervalBefore
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalBefore another proper interval T2, then the end of T1 is before the beginning of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval before"@en ;
  rdfs:range :ProperInterval ;
  rdfs:subPropertyOf :before ;
  rdfs:subPropertyOf :intervalDisjoint ;
  owl:inverseOf :intervalAfter ;
  skos:definition "If a proper interval T1 is intervalBefore another proper interval T2, then the end of T1 is before the beginning of T2."@en ;
.
:intervalContains
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalContains another proper interval T2, then the beginning of T1 is before the beginning of T2, and the end of T1 is after the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval contains"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalDuring ;
  skos:definition "If a proper interval T1 is intervalContains another proper interval T2, then the beginning of T1 is before the beginning of T2, and the end of T1 is after the end of T2."@en ;
.
:intervalDisjoint
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalDisjoint another proper interval T2, then the beginning of T1 is after the end of T2, or the end of T1 is before the beginning of T2, i.e. the intervals do not overlap in any way, but their ordering relationship is not known."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval disjoint"@en ;
  rdfs:range :ProperInterval ;
  skos:definition "If a proper interval T1 is intervalDisjoint another proper interval T2, then the beginning of T1 is after the end of T2, or the end of T1 is before the beginning of T2, i.e. the intervals do not overlap in any way, but their ordering relationship is not known."@en ;
  skos:note "This interval relation is not included in the 13 basic relationships defined in Allen (1984), but is defined in (T.3) as the union of :intervalBefore v :intervalAfter . However, that is outside OWL2 expressivity, so is implemented as an explicit property, with :intervalBefore , :intervalAfter as sub-properties"@en ;
.
:intervalDuring
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalDuring another proper interval T2, then the beginning of T1 is after the beginning of T2, and the end of T1 is before the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval during"@en ;
  rdfs:range :ProperInterval ;
  rdfs:subPropertyOf :intervalIn ;
  owl:inverseOf :intervalContains ;
  skos:definition "If a proper interval T1 is intervalDuring another proper interval T2, then the beginning of T1 is after the beginning of T2, and the end of T1 is before the end of T2."@en ;
.
:intervalEquals
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalEquals another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval equals"@en ;
  rdfs:range :ProperInterval ;
  owl:propertyDisjointWith :intervalIn ;
  skos:definition "If a proper interval T1 is intervalEquals another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
.
:intervalFinishedBy
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalFinishedBy another proper interval T2, then the beginning of T1 is before the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval finished by"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalFinishes ;
  skos:definition "If a proper interval T1 is intervalFinishedBy another proper interval T2, then the beginning of T1 is before the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
.
:intervalFinishes
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalFinishes another proper interval T2, then the beginning of T1 is after the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval finishes"@en ;
  rdfs:range :ProperInterval ;
  rdfs:subPropertyOf :intervalIn ;
  owl:inverseOf :intervalFinishedBy ;
  skos:definition "If a proper interval T1 is intervalFinishes another proper interval T2, then the beginning of T1 is after the beginning of T2, and the end of T1 is coincident with the end of T2."@en ;
.
:intervalIn
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalIn another proper interval T2, then the beginning of T1 is after the beginning of T2 or is coincident with the beginning of T2, and the end of T1 is before the end of T2, or is coincident with the end of T2, except that end of T1 may not be coincident with the end of T2 if the beginning of T1 is coincident with the beginning of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval in"@en ;
  rdfs:range :ProperInterval ;
  owl:propertyDisjointWith :intervalEquals ;
  skos:definition "If a proper interval T1 is intervalIn another proper interval T2, then the beginning of T1 is after the beginning of T2 or is coincident with the beginning of T2, and the end of T1 is before the end of T2, or is coincident with the end of T2, except that end of T1 may not be coincident with the end of T2 if the beginning of T1 is coincident with the beginning of T2."@en ;
  skos:note "This interval relation is not included in the 13 basic relationships defined in Allen (1984), but is referred to as 'an important relationship' in Allen and Ferguson (1997). It is the disjoint union of :intervalStarts v :intervalDuring v :intervalFinishes . However, that is outside OWL2 expressivity, so is implemented as an explicit property, with :intervalStarts , :intervalDuring , :intervalFinishes as sub-properties"@en ;
.
:intervalMeets
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalMeets another proper interval T2, then the end of T1 is coincident with the beginning of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval meets"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalMetBy ;
  skos:definition "If a proper interval T1 is intervalMeets another proper interval T2, then the end of T1 is coincident with the beginning of T2."@en ;
.
:intervalMetBy
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalMetBy another proper interval T2, then the beginning of T1 is coincident with the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval met by"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalMeets ;
  skos:definition "If a proper interval T1 is intervalMetBy another proper interval T2, then the beginning of T1 is coincident with the end of T2."@en ;
.
:intervalOverlappedBy
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalOverlappedBy another proper interval T2, then the beginning of T1 is after the beginning of T2, the beginning of T1 is before the end of T2, and the end of T1 is after the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval overlapped by"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalOverlaps ;
  skos:definition "If a proper interval T1 is intervalOverlappedBy another proper interval T2, then the beginning of T1 is after the beginning of T2, the beginning of T1 is before the end of T2, and the end of T1 is after the end of T2."@en ;
.
:intervalOverlaps
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalOverlaps another proper interval T2, then the beginning of T1 is before the beginning of T2, the end of T1 is after the beginning of T2, and the end of T1 is before the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval overlaps"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalOverlappedBy ;
  skos:definition "If a proper interval T1 is intervalOverlaps another proper interval T2, then the beginning of T1 is before the beginning of T2, the end of T1 is after the beginning of T2, and the end of T1 is before the end of T2."@en ;
.
:intervalStartedBy
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalStarted another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is after the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval started by"@en ;
  rdfs:range :ProperInterval ;
  owl:inverseOf :intervalStarts ;
  skos:definition "If a proper interval T1 is intervalStarted another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is after the end of T2."@en ;
.
:intervalStarts
  rdf:type owl:ObjectProperty ;
  rdfs:comment "If a proper interval T1 is intervalStarts another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is before the end of T2."@en ;
  rdfs:domain :ProperInterval ;
  rdfs:label "interval starts"@en ;
  rdfs:range :ProperInterval ;
  rdfs:subPropertyOf :intervalIn ;
  owl:inverseOf :intervalStartedBy ;
  skos:definition "If a proper interval T1 is intervalStarts another proper interval T2, then the beginning of T1 is coincident with the beginning of T2, and the end of T1 is before the end of T2."@en ;
.
:minute
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Minute position in a calendar-clock system."@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "minute"@en ;
  rdfs:range xsd:nonNegativeInteger ;
  skos:definition "Minute position in a calendar-clock system."@en ;
.
:minutes
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length, or element of, a temporal extent expressed in minutes"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "minutes"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "length, or element of, a temporal extent expressed in minutes"@en ;
.
:month
  rdf:type owl:DatatypeProperty ;
  rdfs:comment """Month position in a calendar-clock system.

The range of this property is not specified, so can be replaced by any specific representation of a calendar month from any calendar. """@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "month"@en ;
  skos:definition """Month position in a calendar-clock system.

The range of this property is not specified, so can be replaced by any specific representation of a calendar month from any calendar. """@en ;
.
:monthOfYear
  rdf:type owl:ObjectProperty ;
  rdfs:comment "The month of the year, whose value is a member of the class time:MonthOfYear"@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "month of year"@en ;
  rdfs:range :MonthOfYear ;
  skos:definition "The month of the year, whose value is a member of the class time:MonthOfYear"@en ;
  skos:editorialNote "Feature at risk - added in 2017 revision, and not yet widely used. "@en ;
.
:months
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in months"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "months duration"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "length of, or element of the length of, a temporal extent expressed in months"@en ;
.
:nominalPosition
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "The (nominal) value indicating temporal position in an ordinal reference system "@en ;
  rdfs:domain :TimePosition ;
  rdfs:label "Name of temporal position"@en ;
  rdfs:range xsd:string ;
  skos:definition "The (nominal) value indicating temporal position in an ordinal reference system "@en ;
.
:numericDuration
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Value of a temporal extent expressed as a decimal number scaled by a temporal unit"@en ;
  rdfs:domain :Duration ;
  rdfs:label "Numeric value of temporal duration"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "Value of a temporal extent expressed as a decimal number scaled by a temporal unit"@en ;
.
:numericPosition
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "The (numeric) value indicating position within a temporal coordinate system "@en ;
  rdfs:domain :TimePosition ;
  rdfs:label "Numeric value of temporal position"@en ;
  rdfs:range xsd:decimal ;
  skos:definition "The (numeric) value indicating position within a temporal coordinate system "@en ;
.
:second
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Second position in a calendar-clock system."@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "second"@en ;
  rdfs:range xsd:decimal ;
.
:seconds
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in seconds"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "seconds duration"@en ;
  rdfs:range xsd:decimal ;
  rdfs:seeAlso <http://www.bipm.org/en/publications/si-brochure/second.html> ;
.
:timeZone
  rdf:type owl:ObjectProperty ;
  rdfs:comment "The time zone for clock elements in the temporal position"@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "in time zone"@en ;
  rdfs:range :TimeZone ;
  skos:historyNote """In the original 2006 version of OWL-Time, the range of time:timeZone was a TimeZone class in a separate namespace "http://www.w3.org/2006/timezone#". 
An alignment axiom 
	tzont:TimeZone rdfs:subClassOf time:TimeZone . 
allows data encoded according to the previous version to be consistent with the updated ontology. """ ;
  skos:note """IANA maintains a database of timezones. These are well maintained and generally considered authoritative, but individual items are not available at individual URIs, so cannot be used directly in data expressed using OWL-Time.

DBPedia provides a set of resources corresponding to the IANA timezones, with a URI for each (e.g. http://dbpedia.org/resource/Australia/Eucla). The World Clock service also provides a list of time zones with the description of each available as an individual webpage with a convenient individual URI (e.g. https://www.timeanddate.com/time/zones/acwst). These or other, similar, resources might be used as a value of the time:timeZone property.""" ;
.
:unitDay
  rdf:type :TemporalUnit ;
  rdfs:label "Day (unit of temporal duration)"@en ;
  skos:prefLabel "Tag"@de ;
  skos:prefLabel "dag"@nl ;
  skos:prefLabel "day"@en ;
  skos:prefLabel "dia"@pt ;
  skos:prefLabel "doba"@pl ;
  skos:prefLabel "día"@es ;
  skos:prefLabel "giorno"@it ;
  skos:prefLabel "jour"@fr ;
  skos:prefLabel "يوماً ما"@ar ;
  skos:prefLabel "ある日"@jp ;
  skos:prefLabel "一天"@zh ;
  skos:prefLabel "언젠가"@kr ;
  :days "1"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitHour
  rdf:type :TemporalUnit ;
  rdfs:label "Hour (unit of temporal duration)"@en ;
  skos:prefLabel "Stunde"@de ;
  skos:prefLabel "godzina"@pl ;
  skos:prefLabel "heure"@fr ;
  skos:prefLabel "hora"@es ;
  skos:prefLabel "hora"@pt ;
  skos:prefLabel "hour"@en ;
  skos:prefLabel "ora"@it ;
  skos:prefLabel "uur"@nl ;
  skos:prefLabel "один час"@ru" ;
  skos:prefLabel "ساعة واحدة"@ar ;
  skos:prefLabel "一小時"@zh ;
  skos:prefLabel "一時間"@jp ;
  skos:prefLabel "한 시간"@kr ;
  :days "0"^^xsd:decimal ;
  :hours "1"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitMinute
  rdf:type :TemporalUnit ;
  rdfs:label "Minute (unit of temporal duration)"@en ;
  skos:prefLabel "Minute"@de ;
  skos:prefLabel "minuta"@pl ;
  skos:prefLabel "minute"@en ;
  skos:prefLabel "minute"@fr ;
  skos:prefLabel "minuto"@es ;
  skos:prefLabel "minuto"@it ;
  skos:prefLabel "minuto"@pt ;
  skos:prefLabel "minuut"@nl ;
  skos:prefLabel "одна минута"@ru ;
  skos:prefLabel "دقيقة واحدة"@ar ;
  skos:prefLabel "一分"@jp ;
  skos:prefLabel "等一下"@zh ;
  skos:prefLabel "분"@kr ;
  :days "0"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "1"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitMonth
  rdf:type :TemporalUnit ;
  rdfs:label "Month (unit of temporal duration)"@en ;
  skos:prefLabel "maand"@nl ;
  skos:prefLabel "mes"@es ;
  skos:prefLabel "mese"@it ;
  skos:prefLabel "miesiąc"@pl ;
  skos:prefLabel "mois"@fr ;
  skos:prefLabel "Monat"@de ;
  skos:prefLabel "month"@en ;
  skos:prefLabel "один месяц"@ru ;
  skos:prefLabel "شهر واحد"@ar ;
  skos:prefLabel "一か月"@jp ;
  skos:prefLabel "一個月"@zh ;
  skos:prefLabel "한달"@kr ;
  :days "0"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "1"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitSecond
  rdf:type :TemporalUnit ;
  rdfs:label "Second (unit of temporal duration)"@en ;
  skos:prefLabel "Sekunde"@de ;
  skos:prefLabel "Sekundę"@pl ;
  skos:prefLabel "second"@en ;
  skos:prefLabel "seconde"@fr ;
  skos:prefLabel "seconde"@nl ;
  skos:prefLabel "secondo"@it ;
  skos:prefLabel "segundo"@es ;
  skos:prefLabel "segundo"@pt ;
  skos:prefLabel "ثانية واحدة"@ar ;
  skos:prefLabel "一秒"@jp ;
  skos:prefLabel "一秒"@zh ;
  skos:prefLabel "일초"@kr ;
  :days "0"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "1"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitType
  rdf:type owl:ObjectProperty ;
  rdfs:comment "The temporal unit which provides the precision of a date-time value or scale of a temporal extent"@en ;
  rdfs:domain [
      rdf:type owl:Class ;
      owl:unionOf (
          :GeneralDateTimeDescription
          :Duration
        ) ;
    ] ;
  rdfs:label "temporal unit type"@en ;
  rdfs:range :TemporalUnit ;
.
:unitWeek
  rdf:type :TemporalUnit ;
  rdfs:label "Week (unit of temporal duration)"@en ;
  skos:prefLabel "Woche"@de ;
  skos:prefLabel "semaine"@fr ;
  skos:prefLabel "semana"@es ;
  skos:prefLabel "semana"@pt ;
  skos:prefLabel "settimana"@it ;
  skos:prefLabel "tydzień"@pl ;
  skos:prefLabel "week"@en ;
  skos:prefLabel "week"@nl ;
  skos:prefLabel "одна неделя"@ru ;
  skos:prefLabel "سبوع واحد"@ar ;
  skos:prefLabel "一周"@zh ;
  skos:prefLabel "一週間"@jp ;
  skos:prefLabel "일주일"@kr ;
  :days "0"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "1"^^xsd:decimal ;
  :years "0"^^xsd:decimal ;
.
:unitYear
  rdf:type :TemporalUnit ;
  rdfs:label "Year (unit of temporal duration)"@en ;
  skos:prefLabel "1 년"@kr ;
  skos:prefLabel "1年"@jp ;
  skos:prefLabel "Jahr"@de ;
  skos:prefLabel "rok"@pl ;
  skos:prefLabel "an"@fr ;
  skos:prefLabel "anno"@it ;
  skos:prefLabel "ano"@pt ;
  skos:prefLabel "jaar"@nl ;
  skos:prefLabel "un año"@es ;
  skos:prefLabel "year"@en ;
  skos:prefLabel "один год"@ru ;
  skos:prefLabel "سنة واحدة"@ar ;
  skos:prefLabel "一年"@zh ;
  :days "0"^^xsd:decimal ;
  :hours "0"^^xsd:decimal ;
  :minutes "0"^^xsd:decimal ;
  :months "0"^^xsd:decimal ;
  :seconds "0"^^xsd:decimal ;
  :weeks "0"^^xsd:decimal ;
  :years "1"^^xsd:decimal ;
.
:week
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "Week number within the year."@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "week"@en ;
  rdfs:range xsd:nonNegativeInteger ;
  skos:note "Weeks are numbered differently depending on the calendar in use and the local language or cultural conventions (locale). ISO-8601 specifies that the first week of the year includes at least four days, and that Monday is the first day of the week. In that system, week 1 is the week that contains the first Thursday in the year."@en ;
.
:weeks
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in weeks"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "weeks duration"@en ;
  rdfs:range xsd:decimal ;
.
:xsdDateTime
  rdf:type owl:DatatypeProperty ;
  rdf:type owl:DeprecatedProperty ;
  rdfs:comment "Value of DateTimeInterval expressed as a compact value."@en ;
  rdfs:domain :DateTimeInterval ;
  rdfs:label "has XSD date-time"@en ;
  rdfs:range xsd:dateTime ;
  owl:deprecated "true"^^xsd:boolean ;
  skos:note "Using xsd:dateTime in this place means that the duration of the interval is implicit: it corresponds to the length of the smallest non-zero element of the date-time literal. However, this rule cannot be used for intervals whose duration is more than one rank smaller than the starting time - e.g. the first minute or second of a day, the first hour of a month, or the first day of a year. In these cases the desired interval cannot be distinguished from the interval corresponding to the next rank up. Because of this essential ambiguity, use of this property is not recommended and it is deprecated."@en ;
.
:year
  rdf:type owl:DatatypeProperty ;
  rdfs:comment """Year position in a calendar-clock system.

The range of this property is not specified, so can be replaced by any specific representation of a calendar year from any calendar. """@en ;
  rdfs:domain :GeneralDateTimeDescription ;
  rdfs:label "year"@en ;
.
:years
  rdf:type owl:DatatypeProperty ;
  rdfs:comment "length of, or element of the length of, a temporal extent expressed in years"@en ;
  rdfs:domain :GeneralDurationDescription ;
  rdfs:label "years duration"@en ;
  rdfs:range xsd:decimal ;
.

:DateTimeDescription  
        rdfs:comment     "Descripción de fecha y tiempo estructurada con valores separados para los diferentes elementos de un sistema calendario-reloj. El sistema de referencia temporal está fijado al calendario gregoriano, y el rango de las propiedades año, mes, día restringidas a los correspondientes tipos del XML Schema xsd:gYear, xsd:gMonth y xsd:gDay respectivamente."@es ;
        rdfs:label       "descripción de fecha-tiempo"@es ;
        skos:definition  "Descripción de fecha y tiempo estructurada con valores separados para los diferentes elementos de un sistema calendario-reloj. El sistema de referencia temporal está fijado al calendario gregoriano, y el rango de las propiedades año, mes, día restringidas a los correspondientes tipos del XML Schema xsd:gYear, xsd:gMonth y xsd:gDay respectivamente."@es .

:minute rdfs:comment     "Posición de minuto en un sistema calendario-reloj."@es ;
        rdfs:label       "minuto"@es ;
        skos:definition  "Posición de minuto en un sistema calendario-reloj."@es .

:inXSDgYearMonth  
        rdfs:comment     "Posición de un instante, expresado utilizando xsd:gYearMonth."@es ;
        rdfs:label       "en año-mes gregoriano XSD"@es ;
        skos:definition  "Posición de un instante, expresado utilizando xsd:gYearMonth."@es .

:unitType  
        rdfs:comment  "La unidad de tiempo que proporciona la precisión de un valor fecha-hora o la escala de una extensión temporal."@es ;
        rdfs:label    "tipo de unidad temporal"@es .

:days   rdfs:comment     "Longitud de, o elemento de la longitud de, una extensión temporal expresada en días."@es ;
        rdfs:label       "duración en días"@es ;
        skos:definition  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en días."@es .

:TimeZone
        rdfs:comment      """Un huso horario especifica la cantidad en que la hora local está desplazada con respecto a UTC.
        Un huso horario normalmente se denota geográficamente (p.ej. el horario de verano del este de Australia), con un valor constante en una región dada.
        La región donde aplica y el desplazamiento desde UTC las especifica una autoridad gubernamental localmente reconocida."""@es ;
        rdfs:label        "huso horario"@es ;
        skos:definition   """Un huso horario especifica la cantidad en que la hora local está desplazada con respecto a UTC.
    Un huso horario normalmente se denota geográficamente (p.ej. el horario de verano del este de Australia), con un valor constante en una región dada.
    La región donde aplica y el desplazamiento desde UTC las especifica una autoridad gubernamental localmente reconocida."""@es ;
        skos:historyNote  """En la versión original de OWL-Time de 2006, se definió, en un espacio de nombres diferente "http://www.w3.org/2006/timezone#", la clase 'huso horario', con varias propiedades específicas correspondientes a un modelo específico de huso horario.
    En la versión actual hay una clase con el mismo nombre local en el espacio de nombres de OWL-Time, eliminando la dependencia del espacio de nombres externo.
    Un axioma de alineación permite que los datos codificados de acuerdo con la versión anterior sean consistentes con la ontología actualizada."""@es ;
        skos:note         """Un huso horario designado está asociado con una región geográfica. Sin embargo, para una región particular el desplazamiento desde UTC a menudo varía según las estaciones, y las fechas de los cambios pueden variar de un año a otro. La designación de huso horario  normalmente cambia de una estación a otra (por ejemplo, el horario estándar frente al horario de verano ambos del este de Australia). Además, del desplazamiento para un huso horario puede cambiar sobre escalas de tiempo mayores, aunque su designación no lo haga.
    Se puede encontrar una guía detallada sobre el funcionamiento de husos horarios en http://www.w3.org/TR/timezone/."@es , "En [owl-time-20060927] se describió una ontología para descripciones de husos horarios, y se proporcionó en un espacio de nombres separado tzont:. Sin embargo, dicha ontología estaba incompleta en su alcance, y el ejemplo de conjuntos de datos (datasets) era selectivo. Además, puesto que el uso de una clase de una ontología externa como el rango de una propiedad de objeto en OWL-Time crea una dependencia, la referencia a la clase huso horario se ha reemplazado por una clase que viene a ser un "cajón de sastre" en la en la parte normativa de esta versión de OWL-Time."""@es ;
        skos:scopeNote    "En esta implementación 'huso horario' no tiene definidas propiedades. Se debería pensar como una superclase "abstracta" de todas las implementaciones de huso horario específicas."@es .

:numericDuration
        rdfs:comment     "Valor de una extensión temporal expresada como un número decimal escalado por una unidad de tiempo."@es ;
        rdfs:label       "valor numérico de duración temporal"@es ;
        skos:definition  "Valor de una extensión temporal expresada como un número decimal escalado por una unidad de tiempo."@es .

:hasDateTimeDescription
        rdfs:comment     "Valor de intervalo de fecha-hora expresado como un valor estructurado. El principio y el final del intervalo coincide con los límites del elemento más corto en la descripción."@es ;
        rdfs:label       "tiene descripción fecha-hora"@es ;
        skos:definition  "Valor de intervalo de fecha-hora expresado como un valor estructurado. El principio y el final del intervalo coincide con los límites del elemento más corto en la descripción."@es .

:intervalIn
        rdfs:comment     "Si un intervalo propio T1 es un intervalo interior a otro intervalo propio T2, entonces el principio de T1 está después del principio de T2 o coincide con el principio de T2, y el final de T1 está antes que el final de T2, o coincide con el final de T2, excepto que el final de T1 puede no coincidir con el final de T2 si el principio de T1 coincide con el principio de T2."@es ;
        rdfs:label       "intervalo interior"@es ;
        skos:definition  "Si un intervalo propio T1 es un intervalo interior a otro intervalo propio T2, entonces el principio de T1 está después del principio de T2 o coincide con el principio de T2, y el final de T1 está antes que el final de T2, o coincide con el final de T2, excepto que el final de T1 puede no coincidir con el final de T2 si el principio de T1 coincide con el principio de T2."@es ;
        skos:note        "Esta relación entre intervalos no estaba incluida en las 13 relaciones básicas definidas por Allen (1984), pero se hace referencia a ella como "una relación importante" en Allen y Ferguson (1997). Es la unión disjunta de 'intervalo empieza', 'intervalo durante' y con 'intervalo termina'. Sin embargo, esto está fuera de la expresividad de OWL2, por tanto, se implementa como una propiedad explícita, con 'intervalo empieza', 'intervalo durante' e 'intervalo termina' como sub-propiedades."@es .

:timeZone
        rdfs:label        "en huso horario"@es ;
        skos:historyNote  """En la versión original de OWL-Time de 2006, el rango de 'en huso horario' se definió en un espacio de nombres diferente "http://www.w3.org/2006/timezone#".
            Un axioma de alineación permite que los datos codificados de acuerdo con la versión anterior sean consistentes con la ontología actualizada."""@es ;
        skos:note         """IANA mantiene una base de datos de husos horarios. Éstas están bien mantenidas y generalmente se consideran autorizadas, pero los ítems individuales no están disponibles en URIs individuales, por tanto, no se pueden utilizar directamente en datos expresados utilizando OWL-Time.
            La BDPedia proporciona un conjunto de recursos correspondientes a los husos horarios de IANA, con una URI para cada uno (por ejemplo, http://dbpedia.org/resource/Australia/Eucla). El Servicio de Reloj Mundial también proporciona una lista de husos horarios con la descripción de cada uno de los disponibles como una página Web individual con una URI adecuada individual (por ejemplo, https://www.timeanddate.com/time/zones/acwst). Éstos, y otros recursos similares, se puden usar como un valor de la propiedad 'huso horario'."""@es .

<http://www.w3.org/2006/time>
        rdfs:label       "Tiempo en OWL"@es ;
        dct:contributor  <https://orcid.org/0000-0001-8269-8171> .

:hasXSDDuration 
        rdfs:comment        "Extensión de una entidad temporal, expresada utilizando xsd:duration."@es ;
        rdfs:label          "tiene duración XSD"@es ;
        skos:definition     "Extensión de una entidad temporal, expresada utilizando xsd:duration."@es ;
        skos:editorialNote  "Característica arriesgada - añadida en la revisión de 2017, y todavía no ampliamente utilizada."@es .

:hour   rdfs:comment     "Posición de hora en un sistema calendario-reloj."@es ;
        rdfs:label       "hora"@es ;
        skos:definition  "Posición de hora en un sistema calendario-reloj."@es .

:Instant 
        rdfs:comment     "Una entidad temporal con una extensión o duración cero."@es ;
        rdfs:label       "instante de tiempo."@es ;
        skos:definition  "Una entidad temporal con una extensión o duración cero."@es .

:generalMonth
        rdfs:comment     """Mes del año - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gMonth, excepto que se permiten valores hasta el 20, con el propósito de proporcionar soporte a calendarios con años con más de 12 meses.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es ;
        rdfs:label       "Mes generalizado"@es ;
        skos:definition  """Mes del año - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gMonth, excepto que se permiten valores hasta el 20, con el propósito de proporcionar soporte a calendarios con años con más de 12 meses.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es .

:month  rdfs:comment     """Posición de mes en un sistema calendario-reloj.
    El rango de esta propiedad no está especificado, por tanto, se puede reemplazar por cualquier representación específica de un mes de calendario de un calendario cualquiera."""@es ;
        rdfs:label       "mes"@es ;
        skos:definition  """Posición de mes en un sistema calendario-reloj.
            El rango de esta propiedad no está especificado, por tanto, se puede reemplazar por cualquier representación específica de un mes de calendario de un calendario cualquiera."""@es .

:intervalStarts
        rdfs:comment     "Si un intervalo propio T1 empieza otro intervalo propio T2, entonces del principio de T1 con el principio de T2, y el final de T1 es anterior al final de T2."@es ;
        rdfs:label       "intervalo empieza"@es ;
        skos:definition  "Si un intervalo propio T1 empieza otro intervalo propio T2, entonces del principio de T1 con el final de T2, y el final de T1 es anterior al final de T2."@es .

:dayOfWeek 
        rdfs:comment     "El día de la semana, cuyo valor es un miembro de la clase 'día de la semana'." ;
        rdfs:label       "día de la semana"@es ;
        skos:definition  "El día de la semana, cuyo valor es un miembro de la clase 'día de la semana'."@es .

:inXSDDate 
        rdfs:comment     "Posición de un instante, expresado utilizando xsd:date."@es ;
        rdfs:label       "en fecha XSD"@es ;
        skos:definition  "Posición de un instante, expresado utilizando xsd:date."@es .

:hasDuration 
        rdfs:comment     "Duración de una entidad temporal, expresada como un valor escalado o un valor nominal."@es ;
        rdfs:label       "tiene duración"@es ;
        skos:definition  "Duración de una entidad temporal, evento o actividad, o cosa, expresada como un valor escalado."@es .

:ProperInterval 
        rdfs:comment     "Una entidad temporal con extensión o duración distinta de cero, es decir, para la cual los valores de principio y fin del intervalo son diferentes."@es ;
        rdfs:label       "intervalo propio"@es ;
        skos:definition  "Una entidad temporal con extensión o duración distinta de cero, es decir, para la cual los valores de principio y fin del intervalo son diferentes."@es .

:hasTime 
        rdfs:comment        "Proporciona soporte a la asociación de una entidad temporal (instante o intervalo) a cualquier cosa."@es ;
        rdfs:label          "tiene tiempo"@es ;
        skos:definition     "Proporciona soporte a la asociación de una entidad temporal (instante o intervalo) a cualquier cosa."@es ;
        skos:editorialNote  "Característica arriesgada -añadida en la revisión del 2017 que no ha sido todavía utilizada de forma amplia."@es .

:hasBeginning 
        rdfs:comment     "Comienzo de una entidad temporal."@es ;
        rdfs:label       "tiene principio"@es ;
        skos:definition  "Comienzo de una entidad temporal."@es .

:intervalEquals 
        rdfs:comment              "Si un intervalo propio T1 es igual a otro intervalo propio T2, entonces el principio de T1 coincide con el principio de T2, y el final de T1 coincide con el final de T2."@es ;
        rdfs:label                "intervalo igual"@es ;
        skos:definition           "Si un intervalo propio T1 es igual a otro intervalo propio T2, entonces el principio de T1 coincide con el principio de T2, y el final de T1 coincide con el final de T2."@es .

:MonthOfYear 
        rdfs:comment        "El mes del año."@es ;
        rdfs:label          "mes del año"@es ;
        skos:definition     "El mes del año."@es ;
        skos:editorialNote  "Característica en riesgo - añadida en la revisión de 2017, y no utilizada todavía de forma amplia."@es ;
        skos:note           "La pertenencia a la clase 'mes del año' está abierta, a permitir calendarios anuales alternativos y diferentes nombres de meses."@es .

:seconds 
        rdfs:comment  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en segundos."@es ;
        rdfs:label    "duración en segundos"@es ;
        rdfs:seeAlso  <http://www.bipm.org/en/publications/si-brochure/second.html> .

:intervalOverlappedBy
        rdfs:comment     "Si un intervalo propio T1 es 'intervalo solapado por' otro intervalo propio T2, entonces el principio de T1 es posterior al principio de T2, y el principio de T1 es anterior al final de T2, y el final de T1 es posterior al final de T2."@es ;
        rdfs:label       "intervalo solapado por"@es ;
        skos:definition  "Si un intervalo propio T1 es 'intervalo solapado por' otro intervalo propio T2, entonces el principio de T1 es posterior al principio de T2, y el principio de T1 es anterior al final de T2, y el final de T1 es posterior al final de T2."@es .

:minutes 
        rdfs:comment     "Longitud de, o elemento de la longitud de, una extensión temporal expresada en minutos."@es ;
        rdfs:label       "minutos"@es ;
        skos:definition  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en minutos."@es .

:inXSDgYear 
        rdfs:comment     "Posición de un instante, expresado utilizando xsd:gYear."@es ;
        rdfs:label       "en año gregoriano XSD"@es ;
        skos:definition  "Posición de un instante, expresado utilizando xsd:gYear."@es .

:intervalDuring 
        rdfs:comment     "Si un intervalo propio T1 está durante otro intervalo propio T2, entonces del principio de T1 está después del principio de T2, y el final de T1 está antes que el final de T2."@es ;
        rdfs:label       "intervalo durante"@es ;
        skos:definition  "Si un intervalo propio T1 está durante otro intervalo propio T2, entonces del principio de T1 está después del principio de T2, y el final de T1 está antes que el final de T2."@es .

:intervalStartedBy 
        rdfs:comment     "Si un intervalo propio T1 es empezado por otro intervalo propio T2, entonces el principio de T1 coincide con el principio de T2, y el final de T1 es posterior al final de T2."@es ;
        skos:definition  "Si un intervalo propio T1 es empezado por otro intervalo propio T2, entonces el principio de T1 coincide con el principio de T2, y el final de T1 es posterior al final de T2."@es .

:intervalFinishedBy 
        rdfs:comment     "Si un intervalo propio T1 está terminado por otro intervalo propio T2, entonces el principio de T1 está antes que el principio de T2, y el final de T1 coincide con el final de T2."@es ;
        rdfs:label       "intervalo terminado por"@es ;
        skos:definition  "Si un intervalo propio T1 está terminado por otro intervalo propio T2, entonces el principio de T1 está antes que el principio de T2, y el final de T1 coincide con el final de T2."@es .

:Duration 
        rdfs:comment     "Duración de una extensión temporal expresada como un número escalado por una unidad temporal."@es ;
        rdfs:label       "duración de tiempo" ;
        skos:definition  "Duración de una extensión temporal expresada como un número escalado por una unidad temporal."@es ;
        skos:note        "Alternativa a 'descripción de tiempo' para proporcionar descripción soporte a una duración temporal diferente a utilizar un sistema de calendario/reloj."@es .

:xsdDateTime 
        rdfs:comment  "Valor de 'intervalo de fecha-hora' expresado como un valor compacto."@es ;
        rdfs:label    "tiene fecha-hora XSD"@es ;
        skos:note     "Utilizando xsd:dateTime en este lugar significa que la duración del intervalo está implícita: se corresponde con la longitud del elemento más pequeño distinto de cero del literal fecha-hora. Sin embargo, esta regla no se puede utilizar para intervalos cuya duración es mayor que un rango más pequeño que el tiempo de comienzo - p.ej. el primer minuto o segundo del día, la primera hora del mes, o el primer día del año. En estos casos el intervalo deseado no se puede distinguir del intervalo correspondiente al próximo rango más alto. Debido a esta ambigüedad esencial, no se recomienda el uso de esta propiedad y está desaprobada." .

:second rdfs:comment  "Posición de segundo en un sistema calendario-reloj."@es ;
        rdfs:label    "segundo"@es .

:week   rdfs:comment    "Número de semana en el año."@es ;
        rdfs:label      "semana"@es ;
        skos:scopeNote  "Las semanas están numeradas de forma diferente dependiendo del calendario en uso y de las convenciones lingüísticas y culturales locales (locale en inglés). El ISO-8601 especifica que la primera semana del año incluye al menos cuatro días, y que el lunes es el primer día de la semana. En ese sistema, la semana 1 es la semana que contiene el primer jueves del año."@es .

:intervalMeets 
        rdfs:comment     "Si un intervalo propio T1 se encuentra con otro intervalo propio T2, entonces el final de T1 coincide con el principio de T2."@es ;
        rdfs:label       "intervalo se encuentra"@es ;
        skos:definition  "Si un intervalo propio T1 se encuentra con otro intervalo propio T2, entonces el final de T1 coincide con el principio de T2."@es .

:inDateTime 
        rdfs:comment     "Posición de un instante, expresada utilizando una descripción estructurada."@es ;
        rdfs:label       "en descripción de fecha-hora"@es ;
        skos:definition  "Posición de un instante, expresada utilizando una descripción estructurada."@es .

:intervalFinishes 
        rdfs:comment     "Si un intervalo propio T1 termina otro intervalo propio T2, entonces del principio de T1 está después del principio de T2, y el final de T1 coincide con el final de T2."@es ;
        rdfs:label       "intervalo termina"@es ;
        skos:definition  "Si un intervalo propio T1 termina otro intervalo propio T2, entonces del principio de T1 está después del principio de T2, y el final de T1 coincide con el final de T2."@es .

:intervalMetBy 
        rdfs:comment     "Si un intervalo propio T1 es 'intervalo encontrado por' otro intervalo propio T2, entonces el principio de T1 coincide con el final de T2."@es ;
        rdfs:label       "intervalo encontrado por"@es ;
        skos:definition  "Si un intervalo propio T1 es 'intervalo encontrado por' otro intervalo propio T2, entonces el principio de T1 coincide con el final de T2."@es .

:years  rdfs:comment  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en años."@es ;
        rdfs:label    "duración en años"@es .

:day    rdfs:comment     "Posición de día en un sistema calendario-reloj."@es ;
        rdfs:label       "día"@es ;
        skos:definition  """Posición de día en un sistema calendario-reloj.

El rango de esta propiedad no está especificado, por tanto, se puede reemplazar por una representación específica de un día de calendario de cualquier calendario."""@es .

:inXSDDateTime 
        rdfs:comment     "Posición de un instante, expresado utilizando xsd:dateTime."@es ;
        rdfs:label       "en fecha-tiempo XSD"@es ;
        skos:definition  "Posición de un instante, expresado utilizando xsd:dateTime."@es ;
        skos:note        "La propiedad 'en fecha-hora XSD' ha sido reemplazada por 'en fecha-sello de tiempo XSD' que hace obligatorio el campo 'huso horario'."@es .

:TimePosition 
        rdfs:comment     "Una posición temporal descrita utilizando bien un valor (nominal) de un sistema de referencia ordinal, o un valor (numérico) en un sistema de coordenadas temporales."@es ;
        rdfs:label       "posición de tiempo"@es ;
        skos:definition  "Una posición temporal descrita utilizando bien un valor (nominal) de un sistema de referencia ordinal, o un valor (numérico) en un sistema de coordenadas temporales."@es .

:intervalBefore 
        rdfs:comment     "Si un intervalo propio T1 está antes que otro intervalo propio T2, entonces el final de T1 está antes que el principio de T2."@es ;
        rdfs:label       "intervalo anterior"@es ;
        skos:definition  "Si un intervalo propio T1 está antes que otro intervalo propio T2, entonces el final de T1 está antes que el principio de T2."@es .

:TemporalEntity 
        rdfs:comment     "Un intervalo temporal o un instante."@es ;
        rdfs:label       "entidad temporal"@es ;
        skos:definition  "Un intervalo temporal o un instante."@es .

:intervalDisjoint 
        rdfs:comment     "Si un intervalo propio T1 es disjunto con otro intervalo propio T2, entonces el principio de T1 está después del final de T2, o el final de T1 está antes que el principio de T2, es decir, los intervalos no se solapan de ninguna forma, aunque su relación de orden no se conozca."@es ;
        rdfs:label       "intervalo disjunto"@es ;
        skos:definition  "Si un intervalo propio T1 es disjunto con otro intervalo propio T2, entonces el principio de T1 está después del final de T2, o el final de T1 está antes que el principio de T2, es decir, los intervalos no se solapan de ninguna forma, aunque su relación de orden no se conozca."@es ;
        skos:note        "Esta relación entre intervalos no estaba incluida en las 13 relaciones básicas definidas por Allen (1984), pero está definida en T.3 como la unión de 'intervalo anterior' con 'intervalo posterior'. Sin embargo, esto está fuera de la expresividad de OWL2, por tanto, está implementado como una propiedad explícita, con 'intervalo anterior' e 'intervalo posterior' como sub-propiedades."@es .

:TRS    rdfs:comment     """Un sistema de referencia temporal, tal como un sistema de coordenadas temporales (con un origen, una dirección y una escala), una combinación calendario-reloj, o un sistema ordinal (posiblemente jerárquico).
        Esta clase comodín representa el conjunto de todos los sistemas de referencia temporal."""@es ;
        rdfs:label       "sistema de referencia temporal"@es ;
        skos:definition  """Un sistema de referencia temporal, tal como un sistema de coordenadas temporales (con un origen, una dirección y una escala), una combinación calendario-reloj, o un sistema ordinal (posiblemente jerárquico).
    Esta clase comodín representa el conjunto de todos los sistemas de referencia temporal."""@es ;
        skos:note        "En el ISO 19108:2002 [ISO19108] se proporciona una taxonomía de sistemas de referencia temporal, incluyendo (a) sistemas de calendario + reloj; (b) sistemas de coordenadas temporales (es decir, desplazamiento numérico a partir de una época); (c) sistemas de referencia ordinales temporales (es decir, secuencia ordenada de intervalos nombrados, no necesariamente de igual duración)."@es .

:intervalAfter
        rdfs:comment     "Si un intervalo propio T1 es posterior a otro intervalo propio T2, entonces el principio de T1 está después que el final de T2." ;
        rdfs:label       "intervalo posterior"@es ;
        skos:definition  "Si un intervalo propio T1 es posterior a otro intervalo propio T2, entonces el principio de T1 está después que el final de T2."@es .

:nominalPosition 
        rdfs:comment     "El valor (nominal) que indica posición temporal en un sistema de referencia ordinal."@es ;
        rdfs:label       "nombre de posición temporal"@es ;
        skos:definition  "El valor (nominal) que indica posición temporal en un sistema de referencia ordinal."@es .

:hasEnd rdfs:comment     "Final de una entidad temporal."@es ;
        rdfs:label       "tiene fin"@es ;
        skos:definition  "Final de una entidad temporal."@es .

:numericPosition 
        rdfs:comment     "El valor (numérico) que indica posición temporal en un sistema de referencia ordinal."@es ;
        rdfs:label       "valor numérico de posición temporal"@es ;
        skos:definition  "El valor (numérico) que indica posición temporal en un sistema de referencia ordinal."@es .

:GeneralDurationDescription
        rdfs:comment     "Descripción de extensión temporal estructurada con valores separados para los distintos elementos de un sistema de horario-calendario."@es ;
        rdfs:label       "descripción de duración generalizada"@es ;
        skos:definition  "Descripción de extensión temporal estructurada con valores separados para los distintos elementos de un sistema de horario-calendario."@es ;
        skos:note        "La extensión de una duración de tiempo expresada como una 'descripción de duración general' depende del Sistema de Referencia Temporal. En algunos calendarios la longitud de la semana o del mes no es constante a lo largo del año. Por tanto, un valor como "25 meses" puede no ser necesariamente ser comparado con un duración similar expresada en términos de semanas o días. Cuando se consideran calendarios que no están basados en el movimiento de la Tierra, se deben tomar incluso más precauciones en la comparación de duraciones."@es .

:weeks  rdfs:comment  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en semanas."@es ;
        rdfs:label    "duración en semanas"@es .

:inXSDDateTimeStamp 
        rdfs:comment     "Posición de un instante, expresado utilizando xsd:dateTimeStamp."@es ;
        rdfs:label       "en fecha-sello de tiempo XSD"@es ;
        skos:definition  "Posición de un instante, expresado utilizando xsd:dateTimeStamp."@es .

:intervalContains 
        rdfs:comment     "Si un intervalo propio T1 contiene otro intervalo propio T2, entonces el principio de T1 está antes que el principio de T2, y el final de T1 está después del final de T2."@es ;
        rdfs:label       "intervalo contiene"@es ;
        skos:definition  "Si un intervalo propio T1 contiene otro intervalo propio T2, entonces el principio de T1 está antes que el principio de T2, y el final de T1 está después del final de T2."@es .

:DateTimeInterval 
        rdfs:comment     "'intervalo de fecha-hora' es una subclase de 'intervalo propio', definida utilizando el multi-elemento 'descripción de fecha-hora'."@es ;
        rdfs:label       "intervalo de fecha-hora"@es ;
        skos:definition  "'intervalo de fecha-hora' es una subclase de 'intervalo propio', definida utilizando el multi-elemento 'descripción de fecha-hora'."@es ;
        skos:note        "'intervalo de fecha-hora' se puede utilizar sólo para un intervalo cuyos límites coinciden con un elemento de fecha-hora alineados con el calendario y la zona horaria indicados. Por ejemplo, aunque ambos tienen una duración de un día, el intervalo de 24 horas que empieza en la media noche del comienzo del 8 mayo en Europa Central se puede expresar como un 'intervalo de fecha-hora', el intervalo de 24 horas que empieza a las 1:30pm no."@es .

:dayOfYear 
        rdfs:comment     "El número de día en el año."@es ;
        rdfs:label       "día del año"@es ;
        skos:definition  "El número de día en el año."@es .

:monthOfYear 
        rdfs:comment        "El mes del año, cuyo valor es un miembro de la clase 'mes del año'."@es ;
        rdfs:label          "mes del año"@es ;
        skos:definition     "El mes del año, cuyo valor es un miembro de la clase 'mes del año'."@es ;
        skos:editorialNote  "Característica arriesgada - añadida en la revisión de 2017, y todavía no ampliamente utilizada."@es .

:hasTRS rdfs:comment     "El sistema de referencia temporal utilizado por una posición temporal o descripción de extensión."@es ;
        rdfs:label       "sistema de referencia temporal utilizado"@es ;
        skos:definition  "El sistema de referencia temporal utilizado por una posición temporal o descripción de extensión."@es .

:Interval 
        rdfs:comment     "Una entidad temporal con una extensión o duración."@es ;
        rdfs:label       "intervalo de tiempo"@es ;
        skos:definition  "Una entidad temporal con una extensión o duración."@es .

:GeneralDateTimeDescription
        rdfs:comment     "Descripción de fecha y hora estructurada con valores separados para los distintos elementos de un sistema calendario-reloj."@es ;
        rdfs:label       "descripción de fecha-hora generalizada"@es ;
        skos:definition  "Descripción de fecha y hora estructurada con valores separados para los distintos elementos de un sistema calendario-reloj." ;
        skos:note        "Algunas combinaciones de propiedades son redundantes - por ejemplo, dentro de un 'año' especificado si se proporciona 'día del año' entonces 'día' y 'mes' se pueden computar, y viceversa. Los valores individuales deberían ser consistentes entre ellos y con el calendario, indicado a través del valor de la propiedad 'tiene TRS'."@es .

:inTimePosition 
        rdfs:comment     "Posición de un instante, expresada como una coordenada temporal o un valor nominal."@es ;
        rdfs:label       "posición de tiempo"@es ;
        skos:definition  "Posición de un instante, expresada como una coordenada temporal o un valor nominal."@es .

:year   rdfs:comment  """Posición de año en un sistema calendario-reloj.

l rango de esta propiedad no está especificado, por tanto, se puede reemplazar por cualquier representación específica de un año de calendario de un calendario cualquiera."""@es .

:DayOfWeek 
        rdfs:comment     "El día de la semana"@es ;
        rdfs:label       "día de la semana"@es ;
        skos:definition  "El día de la semana"@es ;
        skos:note        "La pertenencia a la clase 'día de la semana' está abierta, para permitir longitudes de semana alternativas y diferentes nombres de días."@es .

:generalDay
        rdfs:comment     """Día del mes - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gDay, excepto que se permiten valores hasta el 99, con el propósito de proporcionar soporte a calendarios con meses con más de 31 días.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es ;
        rdfs:label       "Día generalizado"@es ;
        skos:definition  """Día del mes - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gDay, excepto que se permiten valores hasta el 99, con el propósito de proporcionar soporte a calendarios con meses con más de 31 días.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es .

:hasTemporalDuration
        rdfs:comment     "Duración de una entidad temporal."@es ;
        rdfs:label       "tiene duración temporal"@es ;
        skos:definition  "Duración de una entidad temporal."@es .

:DurationDescription 
        rdfs:comment     "Descripción de extensión temporal estructurada con valores separados para los distintos elementos de un sistema de horario-calendario. El sistema de referencia temporal se fija al calendario gregoriano, y el intervalo de cada una de las propiedades numéricas se restringe a xsd:decimal."@es ;
        rdfs:label       "descripción de duración"@es ;
        skos:definition  "Descripción de extensión temporal estructurada con valores separados para los distintos elementos de un sistema de horario-calendario. El sistema de referencia temporal se fija al calendario gregoriano, y el intervalo de cada una de las propiedades numéricas se restringe a xsd:decimal."@es ;
        skos:note        "En el calendario gregoriano la longitud de los meses no es fija. Por lo tanto, un valor como "2,5 meses" no se puede comparar exactamente con una duración similar expresada en términos de semanas o días."@es .

:TemporalPosition 
        rdfs:comment     "Una posición sobre una línea de tiempo."@es ;
        rdfs:label       "posición temporal"@es ;
        skos:definition  "Una posición sobre una línea de tiempo."@es .

:generalYear
        rdfs:comment     """Número de año - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gYear, aunque no está restringido a valores del calendario gregoriano.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es ;
        rdfs:label       "Año generalizado"@es ;
        skos:definition  """Número de año - formulado como una cadena de texto con una restricción patrón para reproducir la misma forma léxica que gYear, aunque no está restringido a valores del calendario gregoriano.
            Nótese que el espacio de valores no está definido, por tanto, un procesador genérico de OWL2 no puede computar relaciones de orden de valores de este tipo."""@es .

:hours  rdfs:comment     "Longitud de, o elemento de la longitud de, una extensión temporal expresada en horas."@es ;
        rdfs:label       "duración en horas"@es ;
        skos:definition  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en horas."@es .

:TemporalUnit 
        rdfs:comment     "Una duración estándar, que proporciona un factor de escala para una extensión de tiempo, o la granularidad o precisión para una posición de tiempo."@es ;
        rdfs:label       "unidad de tiempo"@es ;
        skos:definition  "Una duración estándar, que proporciona un factor de escala para una extensión de tiempo, o la granularidad o precisión para una posición de tiempo."@es ;
        skos:note        "La pertenencia de la clase 'unidad de tiempo' está abierta, para permitir otras unidades de tiempo utilizadas en algunas aplicaciones técnicas (por ejemplo, millones de años o el mes Baha'i)."@es .

:hasDurationDescription
        rdfs:comment     "Duración de una entidad temporal, expresada utilizando una descripción estructurada."@es ;
        rdfs:label       "tiene descripción de duración"@es ;
        skos:definition  "Duración de una entidad temporal, expresada utilizando una descripción estructurada."@es .

:intervalOverlaps 
        rdfs:comment     "Si un intervalo propio T1 se solapa con otro intervalo propio T2, entonces el principio de T1 es anterior al principio de T2, el final de T1 es posterior al principio de T2, y el final de T1 es anterior al final de T2."@es , "Asume una dirección en el tiempo. Si una entidad temporal T1 está después de otra entidad temporal T2, entonces el principio de T1 está después del final de T2."@es ;
        rdfs:label       "intervalo se solapa"@es ;
        skos:definition  "Si un intervalo propio T1 se solapa con otro intervalo propio T2, entonces el principio de T1 es anterior al principio de T2, el final de T1 es posterior al principio de T2, y el final de T1 es anterior al final de T2."@es .

:before rdfs:comment     "Asume una dirección en el tiempo. Si una entidad temporal T1 está antes que otra entidad temporal T2, entonces el final de T1 está antes que el principio de T2. Así, "antes" se puede considerar básica para instantes y derivada para intervalos."@es ;
        rdfs:label       "antes"@es ;
        skos:definition  "Asume una dirección en el tiempo. Si una entidad temporal T1 está antes que otra entidad temporal T2, entonces el final de T1 está antes que el principio de T2. Así, "antes" se puede considerar básica para instantes y derivada para intervalos."@es .

:after  rdfs:comment     "Asume una dirección en el tiempo. Si una entidad temporal T1 está después de otra entidad temporal T2, entonces el principio de T1 está después del final de T2."@es ;
        rdfs:label       "después"@es ;
        skos:definition  "Asume una dirección en el tiempo. Si una entidad temporal T1 está después de otra entidad temporal T2, entonces el principio de T1 está después del final de T2."@es .

:inside rdfs:comment     "Un instante que cae dentro del intervalo. Se asume que no es ni el principio ni el final de ningún intervalo."@es ;
        rdfs:label       "tiene instante de tiempo dentro"@es ;
        skos:definition  "Un instante que cae dentro del intervalo. Se asume que no es ni el principio ni el final de ningún intervalo."@es .

:inTemporalPosition 
        rdfs:comment     "Posición de un instante de tiempo."@es ;
        rdfs:label       "posición temporal"@es ;
        skos:definition  "Posición de un instante de tiempo."@es .

xsd:dateTimeStamp  rdfs:label  "sello de tiempo"@es .

:months rdfs:comment     "Longitud de, o elemento de la longitud de, una extensión temporal expresada en meses."@es ;
        rdfs:label       "duración en meses"@es ;
        skos:definition  "Longitud de, o elemento de la longitud de, una extensión temporal expresada en meses."@es .

:TemporalDuration 
        rdfs:comment     "Extensión de tiempo; duración de un intervalo de tiempo independiente de su posición de inicio particular."@es ;
        rdfs:label       "duración temporal"@es ;
        skos:definition  "Extensión de tiempo; duración de un intervalo de tiempo independiente de su posición de inicio particular."@es .
''';
