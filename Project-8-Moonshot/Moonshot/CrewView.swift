//
//  CrewBrief.swift
//  Moonshot
//
//  Created by Gregory Randolph on 7/22/25.
//

import SwiftUI

struct CrewView: View {
    let crewMember: CrewMember
    
    init(crewMember: CrewMember) {
        self.crewMember = crewMember
    }
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.white, lineWidth: 1)
                )

            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundStyle(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundStyle(.white.opacity(0.5))
                    .italic()
            }
        } // HStack
        .padding(.horizontal)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let astronaut = astronauts["aldrin"]!
    let mission = missions[1]
    let crewMember = CrewMember(role: mission.crew[0].role, astronaut: astronaut)
    
    return CrewView(crewMember: crewMember)
        .preferredColorScheme(.dark)
}
