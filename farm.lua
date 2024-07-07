-- Funktion zum Ernten und Pflanzen von Weizen, Tomaten oder Mais auf einem Feld
function farmField()
    local stepsX = 0
    local stepsZ = 0
    local forward = true -- Startrichtung nach Osten (+x)

    for z = 0, 8 do
        stepsX = 0
        goLane(8, forward) -- Abarbeiten einer Spur (8 Schritte, vorwärts oder rückwärts)

        -- Schritte in Z-Richtung zählen und bewegen (nur wenn nicht am Ende des Feldes)
        if z < 8 then
            if forward then
                rightCurve() -- Rechtskurve
            else
                leftCurve()  -- Linkskurve
            end
            stepsZ = stepsZ + 1
        end

        -- Richtung der Bewegung in X-Richtung umkehren
        forward = not forward
    end


    -- Zurück zur Startposition
    for i = 1, stepsZ do
        if forward then
            leftCurve()  -- Linkskurve
        else
            rightCurve() -- Rechtskurve
        end
    end

    -- Schritte in X-Richtung rückgängig machen (in umgekehrter Richtung)
    if not forward then
        turtle.turnRight()
        turtle.turnRight()
    end
    for i = 1, stepsX do
        turtle.forward()
    end

    -- Umdrehen am Ende der Runde
    turtle.turnRight()
    turtle.turnRight()
end

-- Funktion zum Abarbeiten einer Spur
function goLane(length, forward)
    for x = 0, length do
        farmCrop("minecraft:wheat", 7, 1, 1)
        farmCrop("thermal:tomato", 10, 2, 1)
        farmCrop("thermal:corn", 9, 3, 2)
        farmCrop("thermal:eggplant", 10, 4, 1)
        farmCrop("thermal:peanut", 10, 5, 1)


        if x < length then
            turtle.forward()
        end
    end
end

-- Funktion für eine Rechtskurve
function rightCurve()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
end

-- Funktion für eine Linkskurve
function leftCurve()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
end

-- Funktion zum Ernten und Pflanzen einer bestimmten Pflanze
function farmCrop(cropName, matureAge, seedSlot, height)
    local currentY = 0 -- Variable to keep track of the current Y level

    -- Ernten
    for i = 1, height do
        local success, blockInfo = turtle.inspectDown()
        if success and blockInfo.name == cropName then
            if blockInfo.state.age == matureAge then
                turtle.digDown()
            else
                break -- Schleife abbrechen, wenn die Pflanze nicht reif ist
            end
        else
            break -- Schleife abbrechen, wenn kein Block oder falscher Block gefunden wurde
        end

        -- Gegenstände aufnehmen
        turtle.select(16)        -- Einen leeren Slot auswählen (z.B. den letzten)
        while turtle.suckDown() do end -- Alle Gegenstände aufnehmen

        -- Nach oben bewegen, wenn es noch höhere Blöcke gibt
        if i < height then
            turtle.up()
            currentY = currentY + 1 -- Y-Position aktualisieren
        end
    end


    -- Pflanzen (nur wenn alle Blöcke der Pflanze geerntet wurden)
    if currentY == height - 1 then -- Überprüfen, ob alle Blöcke geerntet wurden
        turtle.select(seedSlot)
        turtle.placeDown()

        -- Nach unten bewegen und restliche Samen pflanzen
        for i = 1, height - 1 do
            turtle.down()
            turtle.placeUp()
        end
    else
        -- Zurück zur ursprünglichen Höhe, wenn nicht alle Blöcke geerntet wurden
        for i = 1, currentY do
            turtle.down()
        end
    end
end

-- Hauptprogramm
while true do
    farmField()
    sleep(10) -- Wartezeit zwischen den Durchläufen

    print("zzzzz")
end
