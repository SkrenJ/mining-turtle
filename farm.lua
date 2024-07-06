-- Funktion zum Ernten und Pflanzen von Weizen auf einem Feld
function farmField()
    local startX, startZ = gps.locate() -- Startposition ermitteln

    for z = 0, 8 do                     -- Schleife über die Z-Achse (9 Blöcke)
        for x = 0, 8 do                 -- Schleife über die X-Achse (9 Blöcke)
            local targetX = startX + x
            local targetZ = startZ + z

            -- Effiziente Bewegung zur nächsten Kachel
            turtle.goTo(targetX, nil, targetZ) -- Nur x und z ändern, y bleibt gleich

            farmWheat()                    -- Weizen auf der aktuellen Kachel bearbeiten
        end

        -- Optimierung: Nach jeder Reihe in Z-Richtung wenden, um die nächste Reihe in umgekehrter Richtung abzufahren
        turtle.turnRight()
        turtle.turnRight()
    end

    -- Zurück zur Startposition
    turtle.goTo(startX, nil, startZ)
end

function farmWheat()
    local success, blockInfo = turtle.inspectDown()

    if success then
        if blockInfo.name == "minecraft:wheat" then -- Überprüfen, ob es sich um Weizen handelt
            if blockInfo.state.age == 7 then      -- Überprüfen, ob der Weizen ausgewachsen ist (age = 7)
                turtle.digDown()                  -- Weizen ernten
                turtle.select(1)                  -- Weitzensamen auswählen (Annahme: Slot 1)
                turtle.placeDown()                -- Weitzensamen pflanzen
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

-- Hauptprogramm
while true do
    farmField()
    sleep(10) -- Wartezeit zwischen den Durchläufen
end
