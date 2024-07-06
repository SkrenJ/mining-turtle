function testen()
    local success, blockInfo = turtle.inspectDown() -- Informationen über den Block unter der Turtle abrufen
    print(success)

    if success then
        print("erfolg!")
    end

    print(blockInfo.name)

    for i = 1, 4 do
        print("Hallo Welt, ", i)
    end
end

testen()
