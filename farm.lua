-- Funktion zum Ernten und Pflanzen von Weizen
function farmWheat()
    local success, blockInfo = turtle.inspectDown()
  
    if success then
      if blockInfo.name == "minecraft:wheat" then  -- Überprüfen, ob es sich um Weizen handelt
        if blockInfo.state.age == 7 then  -- Überprüfen, ob der Weizen ausgewachsen ist (age = 7)
          turtle.digDown()  -- Weizen ernten
          turtle.select(1)  -- Weitzensamen auswählen (Annahme: Slot 1)
          turtle.placeDown()  -- Weitzensamen pflanzen
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
  while true do  -- Endlosschleife, um den Weizen kontinuierlich zu überprüfen
    farmWheat()
    sleep(10)  -- Wartezeit zwischen den Überprüfungen (in Sekunden)
  end
  