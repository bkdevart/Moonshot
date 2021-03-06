//
//  MissionView.swift
//  Moonshot
//
//  Created by Brandon Knox on 4/2/21.
//
//Change project 8 (Moonshot) so that when you scroll down in MissionView the mission badge image gets smaller. It doesn’t need to shrink away to nothing – going down to maybe 80% is fine.

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: geo.frame(in: .global).maxX,
                                   minHeight: geo.frame(in: .global).maxY * 0.8)
                            .padding(.top)
                            .accessibility(removeTraits: .isImage)
                    }
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.headline)
                        .padding()
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) {
                        crewMember in
                            HStack {
                                NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                        
                                            .overlay(Capsule()
                                            .stroke(Color.primary, lineWidth: 1))
                                    
                                    VStack(alignment: .leading) {
                                        
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                            .padding(.horizontal)
                            .foregroundColor(crewMember.role == "Commander" ? /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/ : .black)
                        }
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
