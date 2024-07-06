-- Funktion zum Ausgeben der Blockinformationen
function printBlockInfo()
    local blockInfo = turtle.inspectDown()          -- Informationen über den Block unter der Turtle abrufen
    print("Name:", blockInfo.name)                  -- Name des Blocks ausgeben
    print("Metadaten:", blockInfo.metadata)         -- Metadaten des Blocks ausgeben (falls vorhanden)
    if blockInfo.state then                         -- Überprüfen, ob Blockzustände vorhanden sind (Minecraft 1.8+)
        print("Zustände:")
        for key, value in pairs(blockInfo.state) do -- Alle Blockzustände ausgeben
            print("  ", key, "=", value)
        end
    end   -- Meldung ausgeben, wenn kein Block unter der Turtle ist
end

-- Hauptprogramm
printBlockInfo()   -- Funktion aufrufen, um die Blockinformationen auszugeben
