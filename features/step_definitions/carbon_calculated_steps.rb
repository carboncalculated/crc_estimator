When /^I connect to CarbonCalculated Service$/ do
   @cc_session ||= CrcEstimator.calculated_session
   #puts "Session instantiated, #{@cc_session.inspect}"
end

Then /^I should have a valid reference$/ do
  @cc_session.should_not == nil
end

When /^I am using the fuel_crc object template$/ do
  #http://browser.carboncalculated.com/object_templates/fuel_crc
  #ID is 4cade6a1ab9f017c8e000005

  #Computation is named "Crc Fuel General"
  #http://browser.carboncalculated.com/calculators/4cbaf8bf1076f10d25000001/computations/4cbaf8c11076f10d25000002
  @computation_id = '4cbaf8c11076f10d25000002'
  #call signature: { :amount => value, :formula_input_name => "emissions_per_kwh", fuel_object_id -> "4cbdbbd0b64f7a41cc0000c8"}

  #Fuel Electricity Object
  #http://browser.carboncalculated.com/object_templates/fuel_crc/generic_objects/4cbdbbd0b64f7a41cc0000c8
    #Formula Inputs: emissions_per_kwh
  @electricity_object_id = '4cbdbbd0b64f7a41cc0000c8'
  @formula_input_name_for_electricity_object = 'emissions_per_kwh'
end

When /^I enter (\d+) kWh of electricity$/ do |arg1|
  @value_kWh = arg1
end

When /^I calculate the amount of CO2$/ do
  @result = CrcEstimator.calculated_session.answer_for_computation(@computation_id,
          :amount => @value_kWh,
          :formula_input_name =>@formula_input_name_for_electricity_object,
          :fuel => @electricity_object_id 
          )
  #puts @result   #6905.324
end

Then /^I should see "([^"]*)" tonnes of CO2$/ do |arg1|
  @value = ( (@result["calculations"]["co2"]["value"] || 0).to_f / 1000 )
  puts (@value - arg1.to_f).abs
  # float comparison: (expected_float - actual_float).abs <= delta
  (@value - arg1.to_f).abs.should <= 0.000001
end