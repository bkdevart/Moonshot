//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Knox on 4/2/21.
//

import SwiftUI

struct AstronautView: View {
    struct CrewMemberMission {
        // see if this needs more to do join
        let id: Int
        let name: Mission.CrewRole
    }
    
    let astronaut: Astronaut
    let missions: [CrewMemberMission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
//                    ForEach(self.missions, id: \.id) {
//                        mission in
//                        Text(String(mission.id))
//                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [CrewMemberMission]()
        
        for mission in missions {
            if let match = missions.first(where: { CrewMemberMission.name == astronaut.id}) {
                matches.append(CrewMemberMission(id: match.id))
            } else {
                fatalError("Missing \(mission)")
            }
        }
        
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)  // , mission: missions[0]
    }
}
