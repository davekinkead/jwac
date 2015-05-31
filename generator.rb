# generate JSON data representing individual posting histories
# { '8110000': [
#   {'posNbr': '146335', dateIn': '01 Jan 2014', 'dateOut': '17 Nov 2014'}
# ]}
#
# Create a markov generator to fake the data for each member
#

# NEOC
# JWAC Ph 1
# JWAC Ph 2
# MSB
# JWAC Ph 3 Shore
# JWAC Ph 3 Sea
# Fleet Board
# NOLC1
# JWAC Warfare
# JWAC Ph 4 Sim
# JWAC PE

require 'json'

results = {}
ranks = %w{MIDN ASBT SBLT LEUT}
first_names = %w{Jaqen Stannis Sansa Shae Eddard Ygritte Sandor Robb Tyrion Talisa Jaime Missandei Margaery Daario Catelyn Roose Robert Arya Davos Cersei Tormund Jon Samwell Gendry Bronn Khal Jeor Joffrey Ramsay Bran Ellaria Jorah Viserys Gilly Brienne Daenerys Olenna Tommen Tywin Melisandre Theon Baelish Varys}
last_names = %w{H'ghar Baratheon Stark Stark Ygritte Clegane Stark Lannister Stark Lannister Missandei Tyrell Naharis Stark Bolton Baratheon Stark Seaworth Lannister Giantsbane Snow Tarly Gendry Bronn Drogo Mormont Baratheon Bolton Stark Sand Mormont Targaryen Gilly Tarth Targaryen Tyrell Baratheon Lannister Melisandre Greyjoy Baelish}

gates = ["NEOC", "JWAC 1", "JWAC 2", "MSB", "JWAC 3 Shore", "JWAC 3 Sea", "Fleet Board", "NOLC1", "JWAC Warfare", "JWAC Simulator", "JWAC Endorsement"]

courses = {
  neoc: { name: "NEOC", min: 10, max: 50, duration: 90, outputs: [
      jwacPh1: 0.8, resignation: 0.1, medical: 0.1
    ]},

  # JWAC Ph 1
# JWAC Ph 2
# MSB
# JWAC Ph 3 Shore
# JWAC Ph 3 Sea
# Fleet Board
# NOLC1
# JWAC Warfare
# JWAC Ph 4 Sim
# JWAC PE
}

300.times do |i|
  id = 8151000 + i
  name = "#{ranks.sample} #{first_names.sample} #{last_names.sample}"
end

p results.to_json