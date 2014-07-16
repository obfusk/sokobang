#!/usr/bin/env ruby
require 'json'
sets      = File.read('level.data').scan(/\w[^@\#$.*+\n]*\n[@\#$.*+ \n\x00]*/)
setsdata  = sets.each_with_index.map do |set, i|
  lines = set.lines; name = lines.first.chomp
  levels = lines.drop(1).join.split(/\x00\n/).reject(&:empty?) \
            .map(&:lines).map { |x| x.map(&:chomp) }
  levels.each_with_index do |level, j|
    h = level.length; w = level.map(&:length).max
    d = level.map { |x| (x+' '*w)[0...w] }
    leveldata = { height: h, width: w, data: d }
    File.write("level_#{i}_#{j}.json", leveldata.to_json)
  end
  { name: name, levels: levels.length }
end
File.write("levels.json", setsdata.to_json)
