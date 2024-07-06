-- Funktion zum Ernten und Pflanzen von Weizen, Tomaten oder Mais auf einem Feld
function farmField()
    local stepsX = 0
    local stepsZ = 0
    local forward = true -- Startrichtung nach Osten (+x)

    for z = 0, 8 do
        stepsX = 0
        for x = 0, 8 do
            farmCrop("minecraft:wheat", 7, 1, 1)
            farmCrop("thermal:tomato", 10, 2, 1)
            farmCrop("thermal:corn", 9, 3, 2)
            farmCrop("thermal:eggplant", 10, 4, 1)

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
            turtle.turnRight()
            turtle.forward()
            turtle.turnLeft()
            stepsZ = stepsZ + 1
        end
    end

    -- Zurück zur Startposition
    for i = 1, stepsZ do
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
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

-- Funktion zum Ernten und Pflanzen einer bestimmten Pflanze
function farmCrop(cropName, matureAge, seedSlot, height)
    local currentY = 0 -- Variable to keep track of the current Y level

    for i = 1, height do
        local success, blockInfo = turtle.inspectDown()
        if success and blockInfo.name == cropName then
            if blockInfo.state.age == matureAge then
                turtle.digDown()
                currentY = currentY + 1 -- Nach dem Ernten nach oben bewegen
            else
                break             -- Schleife abbrechen, wenn die Pflanze nicht reif ist
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

        -- Move down to the original Y level
        for i = 1, currentY do
            turtle.down()
        end

        for i = 1, height - 1 do
            turtle.up()
            turtle.placeUp()
        end
        print(cropName .. " geerntet und neu gepflanzt")
    end
end

-- Hauptprogramm
while true do
    farmField()
    sleep(10) -- Wartezeit zwischen den Durchläufen
end
