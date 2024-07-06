function testen()
    local success, blockInfo = turtle.inspectDown() -- Informationen über den Block unter der Turtle abrufen
    print(success)

    if success then
        print("erfolg!")
        print(blockInfo.name)
        print("Metadaten:", blockInfo.metadata)     -- Metadaten des Blocks ausgeben (falls vorhanden)

        if blockInfo.state then
            print("State: ", blockInfo.state)
        end

    end

    

    for i = 1, 4 do
        print("Hallo Welt, ", i)
    end
end

testen()
