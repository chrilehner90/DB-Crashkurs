# Hausübung: Bank

Ein **Kunde** hat ein **Konto**. Für jedes Konto werden die **Aktivitäten** abgespeichert.

## Attribute:
	- Kunde: Name
	- Konto: Kontonummer, Kontostand
	- Aktivitäten: Typ (mögliche Werte: abhebung, überweisung, aufladung -> mit SET constraint), Betrag, Zweck

## Kunden
	- Annemarie Müller
	- Petra Meier
	- Herbert Schuster

## Transaktionen
	- Frau Müller lädt 500 Euro auf sein Konto
	- Frau Meier lädt 1000 Euro auf ihr Konto
	- Herr Schuster lädt 250 Euro auf ihr Konto
	- Frau Meier überweist Frau Schuster 250 Euro. Grund hierfür ein Bestellung im Internet
	- Frau Meier überweist Herrn Müller 100 Euro. Als Grund gibt sie den neuen Anstrich ihres Zaunes an
	- Frau Müller behebt 375 Euro. Sie gibt keinen Grund an.

##TODO:
- Beziehungen?
- Ruby Script, welches die Datenbank + Tabellen erstellt und alles in die Datenbank schreibt bzw. bei jeder Transaktion updated.
- Abfragen mit name, kontonr, kontostand, typ, betrag und zweck
- Ein paar Abfragen mit Aggregatsfunktionen (z.B. max, min, avg, ...) + Order By, usw. Spielt euch selbst ein wenig ;-)

## ACHTUNG:
Nicht auf Update Operationen bei jeder Aktivität vergessen
