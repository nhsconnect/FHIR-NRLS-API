require 'find'
require 'yaml'

allowed_tags = YAML.safe_load(File.read('_data/tags.yml'))['allowed-tags']

tag_usage_numbers = Hash.new(0)

puts "\n"

out_lines = []

Find.find('./pages') do |file_name|
    next unless file_name.end_with?('.md') || file_name.end_with?('.html')

    text = File.read(file_name)

    m = text.match(/^---\r?\n([\s\S]+)\r?\n---/)

    tags = m && YAML.safe_load(m[1])['tags']

    next unless tags

    tags.each { |t| tag_usage_numbers[t] += 1 }

    disallowed = tags.reject { |t| allowed_tags.include? t }

    next if disallowed.empty?

    out_lines << "* #{file_name}\n  #{disallowed.join('', '')}"
end

puts "---\n\n"

unless out_lines.empty?
    puts "# Invalid tags\n\n"
    puts out_lines.join("\n\n")

    puts "\n---\n\n"
end

unused_tags = allowed_tags.filter { |t| tag_usage_numbers[t].zero? }

unless unused_tags.empty?
    puts "# Unused tags\n\n"
    puts unused_tags.map { |l| '* ' + l } .join("\n")

    puts "\n---\n\n"
end

puts "# Page count by tag\n\n"

tag_usage_numbers
    .to_a
    .sort_by { |kv| 0 - kv[1] }
    .each { |kv| puts "* #{kv[0]} - #{kv[1]}" }

puts "\n"
