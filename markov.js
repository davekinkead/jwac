var markov = {
  "NEOC": [
    {"JWAC 1": 0.8},
    {"Medical": 0.1},
    {"Resignation": 0.1}
  ],
  "Changeover": [
    {"JWAC 1": 1.0}
  ],
  "Transfer": [
    {"JWAC 1": 1.0}
  ],     
  "ADFA 1": [
    {"ADFA 2": 0.9},
    {"Medical": 0.05},
    {"Resignation": 0.05}
  ], 
  "ADFA 2": [
    {"ADFA 3": 0.9},
    {"Medical": 0.05},
    {"Resignation": 0.05}
  ], 
  "ADFA 3": [
    {"JWAC 2": 0.9},
    {"Medical": 0.05},
    {"Resignation": 0.05}
  ], 
  "JWAC 1": [
    {"JWAC 2": 0.3},
    {"ADFA 1": 0.6},
    {"Medical": 0.025},
    {"Resignation": 0.025},
    {"Training Failure": 0.05}
  ], 
  "JWAC 2": [
    {"MSB": 0.9},
    {"Medical": 0.025},
    {"Resignation": 0.025},
    {"Training Failure": 0.05}   
  ], 
  "MSB": [
    {"JWAC 3 Shore": 0.925},
    {"Medical": 0.025},
    {"Training Failure": 0.05} 
  ], 
  "JWAC 3 Shore": [
    {"JWAC 3 Sea": 0.925},
    {"Medical": 0.025},
    {"Resignation": 0.025},
    {"Training Failure": 0.025} 
  ], 
  "JWAC 3 Sea": [
    {"Fleet Board": 0.9},
    {"Medical": 0.025},
    {"Resignation": 0.025},
    {"Training Failure": 0.05} 
  ], 
  "Fleet Board": [
    {"NOLC1": 0.85},
    {"JWAC 3 Sea": 0.10},
    {"Training Failure": 0.05} 
  ], 
  "NOLC1": [
    {"JWAC Warfare": 0.95},
    {"Medical": 0.01},
    {"Resignation": 0.02},
    {"Training Failure": 0.02} 
  ], 
  "JWAC Warfare": [
    {"JWAC Simulator": 0.95},
    {"Medical": 0.01},
    {"Resignation": 0.02},
    {"Training Failure": 0.02} 
  ], 
  "JWAC Simulator": [
    {"JWAC Endorsement": 0.95},
    {"Medical": 0.01},
    {"Resignation": 0.02},
    {"Training Failure": 0.02} 
  ], 
  "JWAC Endorsement": [],
  "Resignation": [],
  "Training Failure": [],
  "Resignation": [],
  "Medical": []
}