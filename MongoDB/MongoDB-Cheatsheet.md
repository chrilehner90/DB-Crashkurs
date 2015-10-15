# MongoDB Crashkurs

MongoDB speichert Daten in Dokumenten. Ein Dokument bezeichnet aber keine eigene Datei für jeden Datensatz sondern es ist ein Eintrag in der Datenbank (vergleichbar mit einer Zeile in SQL). Solch ein Dokument ist ein JSON-Objekt, das Strings, Zahlen, Arrays, andere Dokumente und Arrays mit Dokumenten behinhalten können, wie z.B.:

{
    _id: ObjectID("123456789ABCDEF"),
    property1: 42,
    property2: "I am a String",
    property3: new Date("2015-09-25T00:00:00Z"),
    property3: [
        "ArrayElement1", "ArrayElement2"
    ],
    property4: [
        {
            key1: value1,
            key2: value2,
            key3: value3
        },
        {
            key1: value1,
            key2: value2,
            key3: value3
        }
    ],
}

Dokumente werden in sogenannten Collections zusammengefasst. Eine Collection sind also mehrere Einträge in der Datenbank (vgl. Tabelle bei relationalen Datenbanken)

## Statements

<COLLECTION> dient in folgenden Beispielen nur als Platzhalter für den Namen der Collection

### CREATE Document

Eine Collection kann entweder durch folgenden Befehl:

    ```
        db.createCollection("MyCollection", options)
    ```

oder durch das erstmalige Einfügen eines Dokuments erstellt werden.

### INSERT

Wie bereits erwähnt, wird eine Collection automatisch erzeugt, wenn das erste Dokument eingefügt wird.

    ```
        db.<COLLECTION>.insert({ 
            name: "Name",
            address: {
                street: "Test Street",
                number: 18,
                zip: 1234,
                city: "Test City"
            },
            hobbies: [
                "swimming", "eating", "travelling"
            ]
        })
    ```

### SELECT

Alle einträge in einer Collection auswählen:

    ```
        db.<COLLECTION>.find()
    ```

Um ein bestimmtes Dokument auszuwählen, übergibt man der find-Funktion ein Objekt. Dabei können mehrere Key-Value-Paare mitgegeben werden. Bei einem Key-Value-Paar werden alle Dokumente zurück gegeben, auf die diese Key-Value-Paar Kombination zutrifft. Bei mehreren Paaren, müssen alle zutreffen.

    ```
        db.<COLLLECTION>.find({
            key1: "value1",
            key2: "value2",
        })
    ```

### UPDATE

Um von einem Dokument Werte zu ändern, muss man der update-Funktion als ersten Parameter ein Dokument mitgeben, welches die Abfrage definiert.
Der zweite Paramter ist dann ein Dokument, das mit update Operatoren (http://docs.mongodb.org/manual/reference/operator/update-field/) angibt, was geändert werden soll.
Im folgenden Beispiel wird nur der Wert, mit Hilfe des $set Operators, eines Key-Value-Paares geändert.

Um ein Dokument in einer Collection zu ändern, gibt es mehrere Methoden:
- update
- updateOne
- updateMany
- findOneAndUpdate

    ```
        db.<COLLECTION>.update(
            {
                key: "value"
            }, {
                $set: {
                    key: "value"
                }
            }
        )
    ```

Um den Wert eines Arrays zu verändern, braucht man den Positionsoperator ($) -> http://docs.mongodb.org/manual/reference/operator/update/positional/
Angenommen man hat folgendes Dokument:
    ```
        {
            hobbies: ["eating sushi", "playing video games", "listening to music"]
        }
    ```

Dann kann man folgendermaßen einen Eintrag ändern (die Anführungszeichen bei hobbies.$ sind erforderlich, da sonst ein SyntaxError zurückgegeben wird):
    ```
        db.<COLLECTION>.update(
            {
                hobbies: "playing video games"    
            }, {
                $set: {
                    "hobbies.$": "learning database stuff"
                }
            }
        )
    ```

### DELETE

Um ein Dokument aus einer Collection zu löschen, gibt es mehrere Methoden:
- remove
- deleteOne
- deleteMany
- findOneAndDelete

    ```
        db.<COLLECTION>.remove(
            {
                key: "value"
            }
        )
    ```

