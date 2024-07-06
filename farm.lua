-- Funktion zum Ernten und Pflanzen von Weizen, Tomaten oder Mais auf einem Feld
function farmField()
    local stepsX = 0
    local stepsZ = 0
    local forward = false -- Startrichtung nach Westen (-x)

    for z = 8, 0, -1 do   -- Schleife über die Z-Achse (9 Blöcke, absteigend)
        stepsX = 0        -- Zähler für X-Richtung am Anfang jeder Reihe zurücksetzen
        for x = 8, 0, -1 do -- Schleife über die X-Achse (9 Blöcke, absteigend)
            farmCrop("minecraft:wheat", 7, 1, 1)
            farmCrop("thermal:tomato", 10, 2, 1)
            farmCrop("thermal:corn", 9, 3, 2)
            farmCrop("thermal:eggplant", 10, 4, 1)

            -- Schritte in X-Richtung zählen und bewegen (nur wenn nicht am Ende der Reihe)
            if x > 0 then
                if forward then
                    turtle.forward()
                    stepsX = stepsX + 1
                else
                    turtle.back()
                    stepsX = stepsX - 1
                end
            end
        end

        -- Richtung der Bewegung in X-Richtung umkehren
        forward = not forward

        -- Schritte in Z-Richtung zählen und bewegen (nur wenn nicht am Ende des Feldes)
        if z > 0 then
            turtle.turnLeft() -- Immer nach links drehen, da wir in -z Richtung gehen
            turtle.forward()
            turtle.turnRight()
            stepsZ = stepsZ + 1
        end
    end

    -- Zurück zur Startposition
    for i = 1, stepsZ do
        turtle.turnRight() -- Immer nach rechts drehen, da wir zurück in +z Richtung gehen
        turtle.forward()
        turtle.turnLeft()
    end

    -- Schritte in X-Richtung rückgängig machen (in umgekehrter Richtung)
    if forward then
        turtle.turnRight()
        turtle.turnRight()
    end
    for i = 1, stepsX do
        turtle.forward()
    end
end

-- Funktion zum Ernten und Pflanzen einer bestimmten Pflanze
function farmCrop(cropName, matureAge, seedSlot, height)
    local success, blockInfo = turtle.inspectDown()
    if success and blockInfo.name == cropName then
        if blockInfo.state.age == matureAge then
            for i = 1, height do
                turtle.digDown()
                if i < height then
                    turtle.up()
                end
            end
            turtle.select(seedSlot)
            turtle.placeDown()
            for i = 1, height - 1 do
                turtle.up()
                turtle.placeUp()
            end
            print(cropName .. " geerntet und neu gepflanzt")
        else
            print(cropName .. " wächst noch...")
        end
    else
        print("Kein " .. cropName .. " gefunden")
    end
end

-- Hauptprogramm
while true do
    farmField()
    sleep(10) -- Wartezeit zwischen den Durchläufen
end
