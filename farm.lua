-- Funktion zum Ernten und Pflanzen von Weizen, Tomaten oder Mais auf einem Feld
function farmField()
    local stepsX = 0
    local stepsZ = 0
    local forward = true

    for z = 0, 8 do
        stepsX = 0 -- Zähler für X-Richtung am Anfang jeder Reihe zurücksetzen
        for x = 0, 8 do
            farmCrop("minecraft:wheat", 7, 1, 1)
            farmCrop("thermal:tomato", 10, 2, 1)
            farmCrop("thermal:corn", 9, 3, 2)
            farmCrop("thermal:eggplant", 10, 4, 1)

            -- Schritte in X-Richtung zählen und bewegen (nur wenn nicht am Ende der Reihe)
            if x < 8 then
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
        if z < 8 then
            if forward then -- Wenn vorwärts, nach rechts drehen
                turtle.turnRight()
            else        -- Wenn rückwärts, nach links drehen
                turtle.turnLeft()
            end
            turtle.forward()
            if forward then -- Wenn vorwärts, nach links drehen
                turtle.turnLeft()
            else        -- Wenn rückwärts, nach rechts drehen
                turtle.turnRight()
            end
            stepsZ = stepsZ + 1
        end
    end

    -- Zurück zur Startposition
    for i = 1, stepsZ do
        if forward then -- Wenn vorwärts, nach links drehen
            turtle.turnLeft()
        else          -- Wenn rückwärts, nach rechts drehen
            turtle.turnRight()
        end
        turtle.forward()
        if forward then -- Wenn vorwärts, nach rechts drehen
            turtle.turnRight()
        else          -- Wenn rückwärts, nach links drehen
            turtle.turnLeft()
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
end

-- Funktion zum Ernten und Pflanzen einer bestimmten Pflanze
function farmCrop(cropName, matureAge, seedSlot, height)
    local currentY = 0

    for i = 1, height do
        local success, blockInfo = turtle.inspectDown()
        if success and blockInfo.name == cropName then
            if blockInfo.state.age == matureAge then -- Nur ernten, wenn die Pflanze reif ist
                turtle.digDown()
            else
                break -- Schleife abbrechen, wenn die Pflanze nicht reif ist
            end
        end

        if i < height and currentY < height - 1 then
            turtle.up()
            currentY = currentY + 1
        end
    end

    -- Nur pflanzen, wenn die Pflanze geerntet wurde (d.h. die Schleife nicht vorzeitig abgebrochen wurde)
    if i == height then
        turtle.select(seedSlot)
        turtle.placeDown()
        for i = 1, height - 1 do
            turtle.up()
            turtle.placeUp()
        end
        print(cropName .. " geerntet und neu gepflanzt")
    end

    -- Move down to the original Y level
    for i = 1, currentY do
        turtle.down()
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
