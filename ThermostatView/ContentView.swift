//
//  ContentView.swift
//  ThermostatView
//
//  Created by Adrien Surugue on 19/09/2022.
//

import SwiftUI

struct ContentView: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var angle: Double = 160
    @State var progress: CGFloat = 160/360
    @State var gestureCircle: CGFloat = 40
    
    @Binding var currentTemp: Float
    @Binding var location: String
   
    let gradient = LinearGradient(gradient: Gradient(
        colors: [Color("circle.color.1") ,
                 Color("circle.color.2"),
                 Color("circle.color.3")]),startPoint: .bottomTrailing ,endPoint: .bottomLeading)
    
    var body: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: 240/360)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .butt))
                .frame(width: 300, height: 300, alignment: .center)
                .rotationEffect(.init(degrees: 150))
            Circle()
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .overlay(Circle().stroke(gradient, lineWidth: 4))
                .frame(width: 200, height: 200, alignment: .center)
                .rotationEffect(.init(degrees: -angle))
            Circle()
                .trim(from: 0, to: progress)
                .stroke(gradient, style: StrokeStyle(lineWidth: 40, lineCap: .butt))
                .frame(width: 250, height: 250, alignment: .center)
                .rotationEffect(.init(degrees: -210))
            Circle()
                .fill(Color.white)
                .frame(width: gestureCircle, height: gestureCircle)
                .offset(x: 250/2)
                .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                .rotationEffect(.init(degrees: angle))
                .gesture(DragGesture().onChanged(onDrag(value:)).onEnded(endDrag(value:)))
                .rotationEffect(.init(degrees: -210))
            VStack(spacing: 10) {
                Text("Living Room")
                    .fontWeight(.heavy)
                Text(String(currentTemp)+" °C")
                    .fontWeight(.heavy)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(String(format: "%.1f", angle/8)+" °C")
                    .fontWeight(.heavy)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - gestureCircle/2, vector.dx - gestureCircle/2)
        var angle = radian * 180 / .pi
        if angle < 0 {
            angle = 360 + angle
        }
        let progress = angle / 360
        if angle <= 240 {
            self.angle = Double(angle)
            self.progress = progress
        }
    }
    
    func endDrag(value: DragGesture.Value) {
        let setPoint = angle/8
        print(setPoint)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentTemp: .constant(20.0), location: .constant("Living Room"))
    }
}
