//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Knox on 4/2/21.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let crewMissions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    ForEach(self.crewMissions, id: \.id) {
                        mission in
                        Text(String(mission.displayName))
                    }
                    .font(.headline)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        var matches = [Mission]()
        
        for mission in missions {
            if mission.crew.contains(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }
        
        self.crewMissions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
