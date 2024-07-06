-- Funktion zum Ausgeben der Blockinformationen
function printBlockInfo()
    local success, blockInfo = turtle.inspectDown()  -- Informationen über den Block unter der Turtle abrufen
    if success then  -- Überprüfen, ob ein Block gefunden wurde
      print("Name:", blockInfo.name)  -- Name des Blocks ausgeben
      print("Metadaten:", blockInfo.metadata)  -- Metadaten des Blocks ausgeben (falls vorhanden)
      -- Blockzustände (nur Minecraft 1.8+) wurden hier entfernt, da sie in den meisten Fällen nicht benötigt werden
    else
      print("Kein Block gefunden")  -- Meldung ausgeben, wenn kein Block unter der Turtle ist
    end
  end
  
  -- Hauptprogramm
  printBlockInfo()  -- Funktion aufrufen, um die Blockinformationen auszugeben
  