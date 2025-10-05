-- CloudMonitoring - Factorio Production Metrics Exporter
-- Copyright (C) Zax Lofful
-- Licensed under GPL-3.0

-- Writes a line of metric data to the output file
-- @param line The formatted metric line to write
function instrumental_output(line)
  game.write_file("factorio." .. game.tick, line .. "\n", true)
end

-- Collects and exports production statistics for all forces
-- Runs every 900 ticks (15 seconds at 60 UPS)
script.on_nth_tick(900,
  function(event)
    -- Wrap in pcall to prevent crashes from unexpected errors
    local success, error_msg = pcall(function()
      for force_name, force in pairs(game.forces) do
        -- Skip forces that don't have production statistics
        if not force.item_production_statistics or not force.fluid_production_statistics then
          goto continue
        end
        
        -- Export item production metrics
        for item, amount in pairs(force.item_production_statistics.input_counts) do
          instrumental_output("item_production." .. item .. " " .. amount)
        end
        
        -- Export item consumption metrics
        for item, amount in pairs(force.item_production_statistics.output_counts) do
          instrumental_output("item_consumption." .. item .. " " .. amount)
        end
        
        -- Export fluid production metrics
        for item, amount in pairs(force.fluid_production_statistics.input_counts) do
          instrumental_output("fluid_production." .. item .. " " .. amount)
        end
        
        -- Export fluid consumption metrics
        for item, amount in pairs(force.fluid_production_statistics.output_counts) do
          instrumental_output("fluid_consumption." .. item .. " " .. amount)
        end
        
        ::continue::
      end
    end)
    
    -- Log any errors that occurred during metric collection
    if not success then
      game.print("[CloudMonitoring] Error collecting metrics: " .. tostring(error_msg))
      game.write_file("cloudmonitoring_errors.log", 
        game.tick .. ": " .. tostring(error_msg) .. "\n", true)
    end
  end
)