require 'find'

allowed_tags = File.read('_data/tags.yml').split("\n")
    .filter { |l| l =~ /^\s*-\s*/ }
    .map { |l| l.scan(/^\s*-\s*(\w+)/)[0][0] }

used_tags_hash = Hash.new(0)

puts "\n"

out_lines = []

Find.find("./pages") do |fname|
    next unless (fname.end_with? ".md") || (fname.end_with? ".html")

    File.open(fname).each do |line|
        next unless line =~ /^\s*tags:/

        _tags = line.scan(/\[(.*)\]/)
        
        tags = _tags && _tags[0] && _tags[0][0].split(',') || []

        tags.each { |t| used_tags_hash[t] += 1 }

        disallowed = tags.reject { |t| allowed_tags.include? t }

        next if disallowed.length == 0
        
        out_lines << "* " + fname + "\n" + "  " + disallowed.join(", ")
    end
end

puts "---\n\n"

if out_lines.size > 0
    puts "# Invalid tags\n\n"
    puts out_lines.join("\n\n")
    
    puts "\n---\n\n"
end

unused_tags = allowed_tags.filter { |t| used_tags_hash[t] == 0 }

if unused_tags.size > 0
    puts "# Unused tags\n\n"
    puts unused_tags.map { |l| "* " + l } .join("\n")
    
    puts "\n---\n\n"
end

puts "# Page count by tag\n\n"

used_tags_hash
    .to_a
    .sort_by { |kv| 0 - kv[1] }
    .each { |kv| puts "* #{kv[0]} - #{kv[1]}" }

puts "\n"