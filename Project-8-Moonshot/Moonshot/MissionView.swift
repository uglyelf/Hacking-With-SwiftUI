//
//  MissionView.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/22/25.
//

import SwiftUI

struct MissionView: View {
    let crew: [CrewMember]
    let mission: Mission
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map {
            if let astronaut = astronauts[$0.name] {
                return CrewMember(role: $0.role, astronaut: astronaut)
            } else {
                fatalError("Missing \($0.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView() {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                if mission.launchDate != nil {
                    Text("Launched On: \(mission.formattedLaunchDate)")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.top)
                }
                
                VStack(alignment: .leading) {
                    HorizontalBar()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 0.5)
                    
                    Text(mission.description)
                    HorizontalBar()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember.astronaut) {
                                CrewView(crewMember: crewMember)
                            } // label for NavigationLink
                        } // ForEach crew
                    } // HStack
                } // ScrollView
            } // VStack
            .padding(.bottom)
        } // ScrollView
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    } // body
}

/*
 #Preview {
     let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
     let path = NavigationPath()
     
     return AstronautView(astronaut: astronauts["aldrin"]!, navigationPath: .constant(path))
         .preferredColorScheme(.dark)
 }
 */

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
