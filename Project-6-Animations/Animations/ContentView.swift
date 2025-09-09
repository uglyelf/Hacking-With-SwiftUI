//
//  ContentView.swift
//  Animations
//
//  Created by Gregory Randolph on 5/24/25.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    @State private var scaleAnimationAmount = 1.0
    
    @State private var rotationAnimationAmount = 0.0
    @State private var rotationEnabled = false
    @State private var rotationDragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var textDragEnabled = false
    @State private var textDragAmount = CGSize.zero
    
    @State private var isShowingRed = false
    
    var body: some View {
        print(scaleAnimationAmount)
        
        return GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    Spacer()
                    
                    Button("Tap") {
                        withAnimation {
                            animationAmount += 1
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                animationAmount = 1.0
                            }
                        }
                    }
                    .padding(20)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    //        .scaleEffect(animationAmount)
                    .overlay(
                        Circle()
                            .stroke(.green)
                            .scaleEffect(animationAmount)
//                            .opacity(2 - animationAmount)
                            .animation(
                                .easeOut(duration: 1)
                                .repeatCount(3, autoreverses: false),
                                value: animationAmount
                            )
                            
                    )
                    .onAppear {
                        animationAmount = 2
                    }
                    
                    //        .animation(
                    //            .easeInOut(duration: 1)
                    //            .repeatForever(autoreverses: true),
                    ////            .repeatCount(3, autoreverses: true),
                    ////            .delay(1),
                    //            value: animationAmount
                    //        )
                    //        .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
                    
                    Spacer()
                    
                    ZStack {
                        VStack {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 60)
                            Button("Scale") { }
                                .padding(30)
                                .background(Color.mint)
                                .foregroundStyle(.white)
                                .clipShape(.circle)
                                .scaleEffect(scaleAnimationAmount)
                        }
                        
                        VStack {
                            LinearGradient(
                                colors: [.blue, .gray],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                            .frame(width: 300, height: 50)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay {
                                Stepper("Scale amount", value: $scaleAnimationAmount.animation(
                                    .easeInOut(duration: 1)
                                    .repeatCount(3, autoreverses: true)
                                ), in: 1...10)
                                .frame(width: 290, height: 50)
                            }
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 60)
                        }
                    }
                    .frame(height: 120)

                    
                    Spacer()
                    
                    Button("Tap Me") {
                        //            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                        rotationEnabled.toggle()
                        rotationAnimationAmount += 360
                        //            }
                    }
                    .padding(20)
                    .background(rotationEnabled ? .blue : .red)
                    .animation(nil, value: rotationEnabled)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: rotationEnabled ? 60 : 0))
                    .animation(.spring(duration: 1, bounce: 0.6), value: rotationEnabled)
                    .rotation3DEffect(.degrees(rotationAnimationAmount), axis: (x:0, y:1, z:0))
                    .animation(.default, value: rotationEnabled)
                    .animation(
                        .default,
                        value: rotationAnimationAmount
                    )
                    .rotation3DEffect(.degrees(rotationAnimationAmount), axis: (x:1, y:0, z:0))
                    .animation(
                        .default
                            .delay(0.5),
                        value: rotationAnimationAmount
                    )
                    .rotation3DEffect(.degrees(rotationAnimationAmount), axis: (x:0, y:0, z:1))
                    .animation(
                        .default
                            .delay(1),
                        value: rotationAnimationAmount
                    )
                    .rotation3DEffect(.degrees(rotationAnimationAmount), axis: (x:1, y:1, z:1))
                    .animation(
                        .default
                            .delay(1.5),
                        value: rotationAnimationAmount
                    )
                    
                    Spacer()
                    
                    LinearGradient(
                        colors: [.yellow, .red],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    .frame(width: 200, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(rotationDragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { rotationDragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.bouncy) {
                                    rotationDragAmount = .zero
                                }
                            }
                    )
                    .animation(.bouncy, value: rotationDragAmount)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)
                                .background(textDragEnabled ? .blue : .red)
                                .offset(textDragAmount)
                                .animation(.linear.delay(Double(num) / 20), value: textDragAmount)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { textDragAmount = $0.translation }
                            .onEnded { _ in
                                textDragAmount = .zero
                                textDragEnabled.toggle()
                            }
                    )
                    
                    Spacer()
                    
                    ZStack {
                        // If you put the Rectangle and the If in the same ZStack,
                        // then the pivot out gets hidden behind the blue rectangle
                        ZStack {
                            Rectangle()
                                .fill(.blue)
                                .frame(width: 100, height: 100)
                        }
                        
                        ZStack {
                            if isShowingRed {
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 100, height: 100)
                                    .transition(.pivot)
                            }
                        }
                    } // ZStack
                    .onTapGesture {
                        //            withAnimation {
                        isShowingRed.toggle()
                        //            }
                    }
                    .animation(.default, value: isShowingRed)
                    Spacer()
                    Spacer()
                } // VStack
                .frame(minHeight: geometry.size.height)
            } // ScrollView
            .frame(width: geometry.size.width)
        } // GeometryReader
    }
}

    
    //    var body: some View {
   
    //    }
//}

#Preview {
    ContentView()
}
