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
pmkey = 815100

ranks = %w{MIDN ASBT SBLT LEUT}
first_names = %w{Jaqen Stannis Sansa Shae Eddard Ygritte Sandor Robb Tyrion Talisa Jaime Missandei Margaery Daario Catelyn Roose Robert Arya Davos Cersei Tormund Jon Samwell Gendry Bronn Khal Jeor Joffrey Ramsay Bran Ellaria Jorah Viserys Gilly Brienne Daenerys Olenna Tommen Tywin Melisandre Theon Baelish Varys}
last_names = %w{H'ghar Baratheon Stark Stark Ygritte Clegane Stark Lannister Stark Lannister Missandei Tyrell Naharis Stark Bolton Baratheon Stark Seaworth Lannister Giantsbane Snow Tarly Gendry Bronn Drogo Mormont Baratheon Bolton Stark Sand Mormont Targaryen Gilly Tarth Targaryen Tyrell Baratheon Lannister Melisandre Greyjoy Baelish}



nodes = {
  "NEOC" => {duration: 90,
    edges: [
    {"JWAC 1" => 0.8},
    {"Medical" => 0.1},
    {"Resignation" => 0.1}
  ]},
  "Changeover" => {duration: 90, edges: [
    {"JWAC 1" => 1.0}
  ]},
  "Transfer" => {duration: 90, edges: [
    {"JWAC 1" => 1.0}
  ]},     
  "ADFA" => {duration: 1000,
    edges: [
    {"JWAC 2" => 0.7},
    {"Medical" => 0.15},
    {"Resignation" => 0.15}
  ]}, 
  "JWAC 1" => {duration: 60, dates: ['1 Jan', '1 Jun'],
    edges: [
    {"JWAC 2" => 0.3},
    {"ADFA" => 0.6},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Training Failure" => 0.05}
  ]}, 
  "JWAC 2" => {duration: 90, edges: [
    {"MSB" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Training Failure" => 0.05}   
  ]}, 
  "MSB" => {duration: 5, dates: ['1 May', '1 Oct'],
    edges: [
    {"JWAC 3 Shore" => 0.925},
    {"Medical" => 0.025},
    {"Training Failure" => 0.05} 
  ]}, 
  "JWAC 3 Shore" => {duration: 120, edges: [
    {"JWAC 3 Sea" => 0.925},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Training Failure" => 0.025} 
  ]}, 
  "JWAC 3 Sea" => {duration: 120, edges: [
    {"Fleet Board" => 0.9},
    {"Medical" => 0.025},
    {"Resignation" => 0.025},
    {"Training Failure" => 0.05} 
  ]}, 
  "Fleet Board" => {duration: 5, edges: [
    {"NOLC1" => 0.85},
    {"JWAC 3 Sea" => 0.10},
    {"Training Failure" => 0.05} 
  ]}, 
  "NOLC1" => {duration: 30, edges: [
    {"JWAC Warfare" => 0.95},
    {"Medical" => 0.01},
    {"Resignation" => 0.02},
    {"Training Failure" => 0.02} 
  ]}, 
  "JWAC Warfare" => {duration: 30, edges: [
    {"JWAC Simulator" => 0.95},
    {"Medical" => 0.01},
    {"Resignation" => 0.02},
    {"Training Failure" => 0.02} 
  ]}, 
  "JWAC Simulator" => {duration: 150, edges: [
    {"JWAC Endorsement" => 0.95},
    {"Medical" => 0.01},
    {"Resignation" => 0.02},
    {"Training Failure" => 0.02} 
  ]}, 
  "JWAC Endorsement" => {duration: 180, edges: []},
  "Resignation" => {duration: 25, edges: []},
  "Training Failure" => {duration: 25, edges: []},
  "Resignation" => {duration: 25, edges: []},
  "Medical" => {duration: 25, edges: []}
}

starting_vectors = [
  {"NEOC" => 0.8}, 
  {"Transfer" => 0.1}, 
  {"Changeover" => 0.1}
]

terminating_vectors = ["Medical", "Resignation", "Failure", "JWAC Endorsement"]




def choose(array)
  sum = 0
  cut = rand
  array.select do |node|
    return node.keys.first if cut <= sum + node.values.first
    sum += node.values.first
  end
end

require 'date'
date = Date.parse('1 Jan 2011')

6.times do |t|
  (40 + rand * 20).to_i.times do |i|

    pmkey += 1
    name = "#{ranks.sample} #{first_names.sample} #{last_names.sample}"
    postings = []

    current_posting = choose(starting_vectors)  
    while nodes[current_posting][:edges].size > 0
      start_date ||= date
      end_date = start_date + nodes[current_posting][:duration]
      postings << { billet: current_posting, start: start_date.to_s, finish: end_date.to_s }
      current_posting = choose(nodes[current_posting][:edges])
      start_date = end_date + 1
    end

    postings << { billet: current_posting, start: '1 Jan 2014', finish: '1 Jan 2015' }
    postings[-1][:start] = (Date.parse(postings[-2][:finish]) + 1).to_s
    postings[-1][:finish] = (Date.parse(postings[-1][:start]) + 50).to_s
    
    results << {id: pmkey, name: name, postings: postings}
  end

  date += 182
end

File.open "data.json", "w+" do |f|
  f.write results.to_json
end

p "Complete!"