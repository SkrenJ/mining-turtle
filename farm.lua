-- Funktion zum Ernten und Pflanzen von Weizen, Tomaten oder Mais auf einem Feld
function farmField()
    local stepsX = 0  -- Zähler für Schritte in X-Richtung
    local stepsZ = 0  -- Zähler für Schritte in Z-Richtung
    local forward = true  -- Richtung der Bewegung in X-Richtung (true = vorwärts, false = rückwärts)
  
    for z = 0, 8 do  -- Schleife über die Z-Achse (9 Blöcke)
      for x = 0, 8 do  -- Schleife über die X-Achse (9 Blöcke)
        farmCrop("minecraft:wheat", 7, 1, 1)  -- Weizen ernten und pflanzen
        farmCrop("thermal:tomato", 10, 2, 1)  -- Tomaten ernten und pflanzen
        farmCrop("thermal:corn", 9, 3, 2)     -- Mais ernten und pflanzen
        farmCrop("thermal:eggplant", 10, 4, 1) -- Auberginen ernten und pflanzen
  
        -- Schritte in X-Richtung zählen und bewegen
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
  
      -- Schritte in Z-Richtung zählen und bewegen
      if z < 8 then
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        stepsZ = stepsZ + 1
      end
  
      -- Richtung der Bewegung in X-Richtung umkehren
      forward = not forward
    end
  
    -- Zurück zur Startposition
    for i = 1, stepsZ do  -- Schritte in Z-Richtung rückgängig machen
      turtle.turnLeft()
      turtle.forward()
      turtle.turnRight()
    end
  
    -- Schritte in X-Richtung rückgängig machen (in umgekehrter Richtung)
    if not forward then  -- Wenn die letzte Bewegung rückwärts war, jetzt vorwärts fahren
      turtle.turnRight()
      turtle.turnRight()
    end
    for i = 1, stepsX do
      turtle.forward()
    end
  end



-- Funktion zum Ernten und Pflanzen einer bestimmten Pflanze
function farmCrop(cropName, matureAge, seedSlot, height)
    local currentY = 0 -- Variable to keep track of the current Y level
  
    for i = 1, height do
      local success, blockInfo = turtle.inspectDown()
      if success and blockInfo.name == cropName then
        if blockInfo.state.age == matureAge then
          turtle.digDown()
        end
      end
  
      -- Move up only if not already at the top
      if i < height and currentY < height - 1 then 
        turtle.up()
        currentY = currentY + 1
      end
    end
  
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
