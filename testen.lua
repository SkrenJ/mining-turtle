function testen()
    local success, blockInfo = turtle.inspectDown() -- Informationen über den Block unter der Turtle abrufen

    print(success)

    for i = 1, 4 do
        print("Hallo Welt, ", i)
    end
end

testen()