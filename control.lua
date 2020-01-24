function instrumental_output(line)
   game.write_file("factorio." .. game.tick, line .. "\n", true)
end

script.on_nth_tick(900, -- every 15 seconds
  function(event)
    for k, force in pairs(game.forces) do
      for item, amount in pairs(force.item_production_statistics.input_counts) do
        instrumental_output("item_production." .. item .. " " .. amount)
      end
      for item, amount in pairs(force.item_production_statistics.output_counts) do
        instrumental_output("item_consumption." .. item .. " " .. amount)
      end
      for item, amount in pairs(force.fluid_production_statistics.input_counts) do
        instrumental_output("fluid_production." .. item .. " " .. amount)
      end
      for item, amount in pairs(force.fluid_production_statistics.output_counts) do
        instrumental_output("fluid_consumption." .. item .. " " .. amount)
      end
    end
  end
)