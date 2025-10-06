#!/usr/bin/env ruby
manuals = Dir["manuals/*.md"].sort
out = ["# Manual Index\n"]

manuals.each do |f|
  out << "\n## #{File.basename(f, '.md')}\n"
  lns = File.readlines(f)
  hdrs = lns.each_with_index.select { |ln, _| ln[0] == '#' && ln[/^##[^#]/] }

  hdrs.each_with_index do |(ln, i), idx|
    nxt = hdrs[idx + 1]
    end_ln = nxt ? nxt[1] - 1 : lns.size
    title = ln.sub(/^##\s*/, '').strip.gsub(/^(Chapter \d+|Part [IVX]+): /, '')
    out << "• #{title} (L#{i + 1}-#{end_ln})\n"
  end
end

File.write("MANUAL_INDEX.md", out.join)
puts "Generated MANUAL_INDEX.md"
