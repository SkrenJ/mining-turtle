-- Funktion zum Ernten und Pflanzen von Weizen auf einem Feld
function farmField()
    local stepsX = 0  -- Zähler für Schritte in X-Richtung
    local stepsZ = 0  -- Zähler für Schritte in Z-Richtung
  
    for z = 0, 8 do  -- Schleife über die Z-Achse (9 Blöcke)
      for x = 0, 8 do  -- Schleife über die X-Achse (9 Blöcke)
        farmWheat()  -- Weizen auf der aktuellen Kachel bearbeiten
  
        -- Schritte in X-Richtung zählen
        if x < 8 then
          turtle.forward()
          stepsX = stepsX + 1
        end
      end
  
      -- Schritte in Z-Richtung zählen und wenden
      if z < 8 then
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        stepsZ = stepsZ + 1
      end
  
      -- Optimierung: Nach jeder Reihe in Z-Richtung wenden, um die nächste Reihe in umgekehrter Richtung abzufahren
      turtle.turnRight()
      turtle.turnRight()
    end
  
    -- Zurück zur Startposition
    for i = 1, stepsZ do  -- Schritte in Z-Richtung rückgängig machen
      turtle.turnLeft()
      turtle.forward()
      turtle.turnRight()
    end
  
    for i = 1, stepsX do  -- Schritte in X-Richtung rückgängig machen
      turtle.back()
    end
  end

function farmWheat()
    local success, blockInfo = turtle.inspectDown()

    if success then
        if blockInfo.name == "minecraft:wheat" then -- Überprüfen, ob es sich um Weizen handelt
            if blockInfo.state.age == 7 then        -- Überprüfen, ob der Weizen ausgewachsen ist (age = 7)
                turtle.digDown()                    -- Weizen ernten
                turtle.select(1)                    -- Weitzensamen auswählen (Annahme: Slot 1)
                turtle.placeDown()                  -- Weitzensamen pflanzen
                print("Weizen geerntet und neu gepflanzt")
            else
                print("Weizen wächst noch...")
            end
        else
            print("Kein Weizen gefunden")
        end
    else
        print("Kein Block gefunden")
    end
end

-- Funktion zur manuellen Bewegung der Turtle
function moveTo(targetX, targetZ)
    local currentX, currentZ = gps.locate()

    -- Bewegung in X-Richtung
    while currentX ~= targetX do
        if currentX < targetX then
            if not turtle.forward() then return false end -- Bewege dich vorwärts, falls möglich
            currentX = currentX + 1
        else
            if not turtle.back() then return false end -- Bewege dich rückwärts, falls möglich
            currentX = currentX - 1
        end
    end

    -- Bewegung in Z-Richtung
    while currentZ ~= targetZ do
        if currentZ < targetZ then
            turtle.turnRight()
            if not turtle.forward() then return false end
            turtle.turnLeft()
            currentZ = currentZ + 1
        else
            turtle.turnLeft()
            if not turtle.forward() then return false end
            turtle.turnRight()
            currentZ = currentZ - 1
        end
    end

    return true -- Bewegung erfolgreich abgeschlossen
end

-- Hauptprogramm
while true do
    farmField()
    sleep(10) -- Wartezeit zwischen den Durchläufen
end
