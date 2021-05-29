//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Knox on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            ForEach(mission.crew, id: \.name) {
                                astronaut in
                                VStack {
                                    Text(astronaut.name.localizedCapitalized)
                                }
                            }
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button(showDate ? "Crew View" : "Date View") {
                    self.showDate.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
