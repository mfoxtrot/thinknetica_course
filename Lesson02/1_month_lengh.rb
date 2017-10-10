months = Hash.new
months[:january]=31
months[:february]=28
months[:march]=31
months[:april]=30
months[:may]=31
months[:june]=30
months[:july]=31
months[:august]=31
months[:september]=30
months[:october]=31
months[:november]=30
months[:december]=31

months.each do |k,v|
  puts k if v == 30
end
