#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri'


page1 = Nokogiri::HTML(open("2015-10-22_IT.htm"))

#odstrani vsechny span značky, ale nechá jejich obsah
page1.css("span.highlighted").each do |span| 
	span.replace " #{span.content}"
end

#kvuli nejake chybe znovunacitam html soubor, ale jako promennou
page = Nokogiri::HTML(page1.to_xml)


page.css('.documentContentDiv').each {|x|

	#Rozpozna a zpracuje metadata z každého článku
	#K_datum, K_nazev, K_rubrika, K_puvod, K_autor, K_zdroj
	x.css('.verticalField').each {|y|
		vrchniMeta = y.text.split(":",2)

		case vrchniMeta[0]
		when "\nSkóre"
			puts "Skore: #{vrchniMeta[1]}"
		when "\nK_datum"
			puts "Datum #{vrchniMeta[1]}"
		when "\nK_nazev"
			puts "Nazev #{vrchniMeta[1]}"
		when "\nK_rubrika"
			puts "Rubrika #{vrchniMeta[1]}"
		when "\nK_puvod"
			puts "Puvod #{vrchniMeta[1]}"
		when "\nK_autor"
			puts "Autor #{vrchniMeta[1]}"
		when "\nK_zdroj"
			puts "Zdroj #{vrchniMeta[1]}"
		else
			p "Neznámý typ!! Vyvolávám chybu"
			p vrchniMeta[0]
			exit
		end
	}
	#Rozpozna s zpracuje text clanku a take vlozena metadata
	#text = obsahuje samotny text clanku
	#Rozpoznana metadata: Zdroj, Datum, Název, Číslo, Rubrika, Jazyk, Domicil, Odkaz, Oblast, Zpracováno, Identifikace, Hash, ShortcutGroup, ShortcutArea, Shortcut, Text
	x.css('.documentText').each {|c|

		data = c.text.split("Text:",2)

		#metadata v čánku
		c.search("text()").map{ |g|
			next if g.text == "\n"
			break if g.text == "Text: "
			spodniMeta = g.text.split(":",2)
		case spodniMeta[0]
		when "Autor"
			p "Autor #{spodniMeta[1]}"
		when "Číslo"
			p "Číslo #{spodniMeta[1]}"
		when "Datum"
			p "Datum #{spodniMeta[1]}"
		when "Domicil"
			p "Domocil #{spodniMeta[1]}"
		when "Hash"
			p "Hash #{spodniMeta[1]}"
		when "Identifikace"
			p "Identifikace #{spodniMeta[1]}"
		when "ISSN"
			p "ISSN #{spodniMeta[1]}"
		when "Jazyk"
			p "Jazyk #{spodniMeta[1]}"
		when "Název"
			p "Nazev #{spodniMeta[1]}"
		when "Oblast"
			p "Oblast #{spodniMeta[1]}"
		when "Odkaz"
			p "Odkaz #{spodniMeta[1]}"
		when "Rubrika"
			p "Rubrika #{spodniMeta[1]}"
		when "Shortcut"
			p "Shortcut #{spodniMeta[1]}"
		when "ShortcutArea"
			p "ShortcutArea #{spodniMeta[1]}"
		when "ShortcutGroup"
			p "ShortcutGroup #{spodniMeta[1]}"
		when "Text"
			p "Text #{spodniMeta[1]}"
		when "Zdroj"
			p "Zdroj #{spodniMeta[1]}"
		when "Zpracováno"
			p "Zpracováno #{spodniMeta[1]}"
		else
			p "Neznámý typ!! Vyvolávám chybu"
			p spodniMeta[0]
			exit
		end
		}

		#Samotný text článku
		text = data[1].gsub!("\n", " ")
		p text
	}
}

