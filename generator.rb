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

results = []

ranks = %w{MIDN ASBT SBLT LEUT}
first_names = %w{Jaqen Stannis Sansa Shae Eddard Ygritte Sandor Robb Tyrion Talisa Jaime Missandei Margaery Daario Catelyn Roose Robert Arya Davos Cersei Tormund Jon Samwell Gendry Bronn Khal Jeor Joffrey Ramsay Bran Ellaria Jorah Viserys Gilly Brienne Daenerys Olenna Tommen Tywin Melisandre Theon Baelish Varys}
last_names = %w{H'ghar Baratheon Stark Stark Ygritte Clegane Stark Lannister Stark Lannister Missandei Tyrell Naharis Stark Bolton Baratheon Stark Seaworth Lannister Giantsbane Snow Tarly Gendry Bronn Drogo Mormont Baratheon Bolton Stark Sand Mormont Targaryen Gilly Tarth Targaryen Tyrell Baratheon Lannister Melisandre Greyjoy Baelish}

gates = ["NEOC", "JWAC 1", "JWAC 2", "MSB", "JWAC 3 Shore", "JWAC 3 Sea", "Fleet Board", "NOLC1", "JWAC Warfare", "JWAC Simulator", "JWAC Endorsement"]
starting_vectors = [
  {"NEOC" => 0.4}, 
  {"ADFA" => 0.5}, 
  {"Transfer" => 0.05}, 
  {"Changover" => 0.05}
]
terminating_vectors = ["Medical", "Resignation", "Failure", "JWAC Endorsement"]

vectors = {
  "NEOC" => [
    {"JWAC 1" => 0.8},
    {"Medical" => 0.1},
    {"Resignation" => 0.1}
  ], 
  "ADFA" => [
    {"JWAC 1" => 0.7},
    {"Medical" => 0.15},
    {"Resignation" => 0.15}
  ],
  "Transfer" => [
    {"JWAC 1" => 1.0}
  ],
  "Changover" => [
    {"JWAC 1" => 1.0}
  ],
  "JWAC 1" => [
    {"JWAC 2" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05}
  ], 
  "JWAC 2" => [
    {"MSB" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05}    
  ], 
  "MSB" => [
    {"JWAC 3 Shore" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ], 
  "JWAC 3 Shore" => [
    {"JWAC 3 Sea" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ],  
  "JWAC 3 Sea" => [
    {"Fleet Board" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ],  
  "Fleet Board" => [
    {"NOLC1" => 0.85},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.1}
  ],  
  "NOLC1" => [
    {"JWAC Warfare" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ],  
  "JWAC Warfare" => [
    {"JWAC Simulator" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ],  
  "JWAC Simulator" => [
    {"JWAC Endorsement" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Failure" => 0.05} 
  ]
}

def choose(array)
  sum = 0
  cut = rand
  array.select do |node|
    return node.keys.first if cut <= sum + node.values.first
    sum += node.values.first
  end
end

100.times do |i|
  id = 8151000 + i
  name = "#{ranks.sample} #{first_names.sample} #{last_names.sample}"
  postings = []

  current_posting = choose(starting_vectors)  
  until terminating_vectors.include? current_posting
    postings << current_posting
    if current_posting == 'Backclass'
      i = gates.index (postings[-2]) || 1
      current_posting = choose(vectors[gates[i]])
    else
      current_posting = choose(vectors[current_posting])
    end
  end
  postings << current_posting
  
  results << {id: id, name: name, postings: postings}
end

File.open "data.json", "w+" do |f|
  f.write results.to_json
end

p "Complete!"