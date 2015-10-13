#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'fileutils'

OUTPUT_FOLDER = "output"
PAGES_FOLDER = "pages"
TEMPLATES_FOLDER = "templates"
TEMPLATES_EXTENSION = ".xsl"
DEFAULT_EXTENSION = "html"

#
# Example mode
#
if ARGV.empty?
xml = File.open(PAGES_FOLDER+"/index.xml")
xsl = File.open(TEMPLATES_FOLDER+"/xmltohtml.xsl")

doc = Nokogiri::XML(xml,nil,"UTF-8") do |config|
	config.noblanks
end

xslt = Nokogiri::XSLT(xsl)

puts "=============== Example ==============="
puts xslt.transform(doc)

output = File.new(OUTPUT_FOLDER+"/out.html", "w");
output.puts(xslt.transform(doc))
output.close

puts "==== Output File at MLPaser/output ===="

puts "Run MLPaser.bat --help to get all commands"

xml.close
xsl.close

#
# End of Example Mode
#

#
# Import template
#
elsif ARGV[0] == "-import" && ARGV[1].split(".").last == "xsl"
	puts "Importing Template..."
	import_dir = Dir[ARGV[1]]
	import_dir.each do |filename|
		FileUtils.cp(filename,TEMPLATES_FOLDER)
	end

elsif ARGV[0] == "parse" && ARGV[1] == "-i" && ARGV[2] != "" && ARGV[3] == "-t" && ARGV[4] != ""
	
		
		xsl = File.open(TEMPLATES_FOLDER+"/"+ARGV[4]+TEMPLATES_EXTENSION)
		extension = ARGV[2].split(".").last
		puts extension
		if (extension == "html") then

			html = File.open(ARGV[2])
			doc = Nokogiri::HTML(html,nil,"UTF-8") do |config|
				config.noblanks
			end

		else
			puts "buceta"
			xml = File.open(ARGV[2])
			doc = Nokogiri::XML(xml,nil,"UTF-8") do |config|
				config.noblanks
			end

		end

		xslt = Nokogiri::XSLT(xsl)

		puts "=============== Output ==============="
		puts xslt.transform(doc)

		folder = OUTPUT_FOLDER

		if ARGV[5] == "-o" && ARGV[6] !="" 
			folder = ARGV[6]
		elsif ARGV[7] == "-o" && ARGV[8] !=""
			folder = ARGV[8]
		end
				

		filename = ARGV[2].split(".").first

		if ARGV[5] == "-e" && ARGV[6] !="" 
			ext = ARGV[6]
		elsif ARGV[7] == "-e" && ARGV[8] !=""
			ext = ARGV[8]
		else
			case ARGV[4]
			when "xmltohtml"
				ext="html"
			else
				ext=DEFAULT_EXTENSION
			end
		end

		

		output = File.new(folder+"/"+filename+"."+ext, "w");
		output.puts(xslt.transform(doc))
		output.close

	else

		puts "Invalid Command"
		puts "Run MLPaser.bat --help to get all commands"

end