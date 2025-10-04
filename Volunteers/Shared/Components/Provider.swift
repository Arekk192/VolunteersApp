//
//  Provider.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

enum Provider {
    case Apple
    case Google
    case Facebook
}

extension Provider {
    @ViewBuilder
    var icon: some View {
        GeometryReader { geo in
            let rect = CGRect(origin: .zero, size: geo.size)
            
            switch self {
            case .Google:
                ZStack {
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }
                        
                        path.move(to: p(0.5, 0.2582))
                        path.addCurve(to: p(0.65377, 0.3181), p(0.55917, 0.2582), p(0.61177, 0.27865))
                        path.addLine(to: p(0.76883, 0.20304))
                        path.addCurve(to: p(0.5, 0.09821), p(0.69907, 0.13803), p(0.60848, 0.09821))
                        path.addCurve(to: p(0.14131, 0.31993), p(0.34294, 0.09821), p(0.20743, 0.18843))
                        path.addLine(to: p(0.275, 0.42366))
                        path.addCurve(to: p(0.5, 0.2582), p(0.30678, 0.32869), p(0.39554, 0.2582))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 234, g: 67, b: 53))
                    
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }

                        path.move(to: p(0.275, 0.57634))
                        path.addCurve(to: p(0.26222, 0.5), p(0.26696, 0.55223), p(0.26222, 0.52666))
                        path.addCurve(to: p(0.275, 0.42366), p(0.26222, 0.47334), p(0.26696, 0.44777))
                        path.addLine(to: p(0.275, 0.31993))
                        path.addLine(to: p(0.14131, 0.31993))
                        path.addCurve(to: p(0.09821, 0.5), p(0.11392, 0.37399), p(0.09821, 0.43498))
                        path.addCurve(to: p(0.14131, 0.68007), p(0.09821, 0.56502), p(0.11392, 0.62601))
                        path.addLine(to: p(0.24541, 0.59899))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 251, g: 188, b: 5))
                    
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }

                        path.move(to: p(0.5, 0.90179))
                        path.addCurve(to: p(0.76591, 0.80463), p(0.60848, 0.90179), p(0.69943, 0.86599))
                        path.addLine(to: p(0.63551, 0.70345))
                        path.addCurve(to: p(0.5, 0.74217), p(0.59972, 0.72756), p(0.55406, 0.74217))
                        path.addCurve(to: p(0.275, 0.5767), p(0.39554, 0.74217), p(0.30678, 0.67167))
                        path.addLine(to: p(0.14131, 0.5767))
                        path.addLine(to: p(0.14131, 0.68044))
                        path.addCurve(to: p(0.5, 0.90179), p(0.20743, 0.81157), p(0.34294, 0.90179))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 52, g: 168, b: 83))
                    
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }

                        path.move(to: p(0.88571, 0.50913))
                        path.addCurve(to: p(0.87841, 0.42695), p(0.88571, 0.48064), p(0.88316, 0.45325))
                        path.addLine(to: p(0.5, 0.42695))
                        path.addLine(to: p(0.5, 0.58255))
                        path.addLine(to: p(0.71623, 0.58255))
                        path.addCurve(to: p(0.63551, 0.70345), p(0.70674, 0.63259), p(0.67825, 0.67496))
                        path.addLine(to: p(0.63551, 0.80463))
                        path.addLine(to: p(0.76591, 0.80463))
                        path.addCurve(to: p(0.88571, 0.50913), p(0.84188, 0.7345), p(0.88571, 0.63149))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 66, g: 133, b: 244))
                }
            case .Apple:
                ZStack {
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }
                        
                        path.move(to: p(0.51046, 0.25962))
                        path.addCurve(to: p(0.62776, 0.19604), p(0.54956, 0.25962), p(0.59857, 0.23237))
                        path.addCurve(to: p(0.67347, 0.07117), p(0.65419, 0.16312), p(0.67347, 0.11714))
                        path.addCurve(to: p(0.67182, 0.05357), p(0.67347, 0.06492), p(0.67292, 0.05868))
                        path.addCurve(to: p(0.54461, 0.12169), p(0.62831, 0.05527), p(0.576, 0.08365))
                        path.addCurve(to: p(0.49725, 0.24259), p(0.51983, 0.15063), p(0.49725, 0.19604))
                        path.addCurve(to: p(0.4989, 0.25848), p(0.49725, 0.2494), p(0.49835, 0.25621))
                        path.addCurve(to: p(0.51046, 0.25962), p(0.50165, 0.25905), p(0.50606, 0.25962))
                        path.closeSubpath()
                        
                        path.move(to: p(0.37279, 0.94643))
                        path.addCurve(to: p(0.51652, 0.90953), p(0.42621, 0.94643), p(0.44989, 0.90953))
                        path.addCurve(to: p(0.6586, 0.94529), p(0.58426, 0.90953), p(0.59912, 0.94529))
                        path.addCurve(to: p(0.79297, 0.83518), p(0.71697, 0.94529), p(0.75607, 0.88967))
                        path.addCurve(to: p(0.85244, 0.7086), p(0.83427, 0.77274), p(0.85134, 0.71144))
                        path.addCurve(to: p(0.7368, 0.5281), p(0.84859, 0.70746), p(0.7368, 0.66035))
                        path.addCurve(to: p(0.82987, 0.35781), p(0.7368, 0.41344), p(0.82491, 0.36179))
                        path.addCurve(to: p(0.6586, 0.26926), p(0.77149, 0.27154), p(0.68283, 0.26926))
                        path.addCurve(to: p(0.50606, 0.31013), p(0.59307, 0.26926), p(0.53965, 0.31013))
                        path.addCurve(to: p(0.36508, 0.27154), p(0.46971, 0.31013), p(0.4218, 0.27154))
                        path.addCurve(to: p(0.14756, 0.53718), p(0.25714, 0.27154), p(0.14756, 0.36349))
                        path.addCurve(to: p(0.23842, 0.83291), p(0.14756, 0.64503), p(0.18831, 0.75912))
                        path.addCurve(to: p(0.37279, 0.94643), p(0.28137, 0.89534), p(0.31882, 0.94643))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 255, g: 255, b: 255))
                }
                
            case .Facebook:
                ZStack {
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }
                        
                        path.move(to: p(0.90179, 0.5))
                        path.addCurve(to: p(0.5, 0.09821), p(0.90179, 0.2781), p(0.7219, 0.09821))
                        path.addCurve(to: p(0.09821, 0.5), p(0.2781, 0.09821), p(0.09821, 0.2781))
                        path.addCurve(to: p(0.40294, 0.88995), p(0.09821, 0.68843), p(0.22793, 0.84653))
                        path.addLine(to: p(0.40294, 0.62278))
                        path.addLine(to: p(0.32009, 0.62278))
                        path.addLine(to: p(0.32009, 0.5))
                        path.addLine(to: p(0.40294, 0.5))
                        path.addLine(to: p(0.40294, 0.44709))
                        path.addCurve(to: p(0.59909, 0.24695), p(0.40294, 0.31034), p(0.46483, 0.24695))
                        path.addCurve(to: p(0.68643, 0.25694), p(0.62454, 0.24695), p(0.66846, 0.25194))
                        path.addLine(to: p(0.68643, 0.36824))
                        path.addCurve(to: p(0.64001, 0.36674), p(0.67695, 0.36724), p(0.66048, 0.36674))
                        path.addCurve(to: p(0.54868, 0.45658), p(0.57413, 0.36674), p(0.54868, 0.39169))
                        path.addLine(to: p(0.54868, 0.5))
                        path.addLine(to: p(0.67991, 0.5))
                        path.addLine(to: p(0.65737, 0.62278))
                        path.addLine(to: p(0.54868, 0.62278))
                        path.addLine(to: p(0.54868, 0.89884))
                        path.addCurve(to: p(0.90179, 0.5), p(0.74762, 0.87481), p(0.90179, 0.70542))
                    }
                    .fill(Color(r: 8, g: 102, b: 255))
                    
                    Path { path in
                        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
                            CGPoint(x: x * rect.width, y: y * rect.height)
                        }
                        
                        path.move(to: p(0.65737, 0.62278))
                        path.addLine(to: p(0.67991, 0.5))
                        path.addLine(to: p(0.54868, 0.5))
                        path.addLine(to: p(0.54868, 0.45658))
                        path.addCurve(to: p(0.64001, 0.36674), p(0.54868, 0.39169), p(0.57413, 0.36674))
                        path.addCurve(to: p(0.68643, 0.36824), p(0.66048, 0.36674), p(0.67695, 0.36724))
                        path.addLine(to: p(0.68643, 0.25694))
                        path.addCurve(to: p(0.59909, 0.24695), p(0.66846, 0.25194), p(0.62454, 0.24695))
                        path.addCurve(to: p(0.40294, 0.44709), p(0.46483, 0.24695), p(0.40294, 0.31034))
                        path.addLine(to: p(0.40294, 0.5))
                        path.addLine(to: p(0.32009, 0.5))
                        path.addLine(to: p(0.32009, 0.62278))
                        path.addLine(to: p(0.40294, 0.62278))
                        path.addLine(to: p(0.40294, 0.88995))
                        path.addCurve(to: p(0.5, 0.90179), p(0.43402, 0.89767), p(0.46653, 0.90179))
                        path.addCurve(to: p(0.54868, 0.89884), p(0.51648, 0.90179), p(0.53272, 0.90077))
                        path.addLine(to: p(0.54868, 0.62278))
                        path.closeSubpath()
                    }
                    .fill(Color(r: 255, g: 255, b: 255))
                }
            }
        }
    }
}

fileprivate extension Path {
    mutating func addCurve(to point: CGPoint, _ control1: CGPoint, _ control2: CGPoint) {
        self.addCurve(to: point, control1: control1, control2: control2)
    }
}

fileprivate extension Color {
    init(r: Int, g: Int, b: Int) {
        let red = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue = CGFloat(b) / 255
        
        self.init(red: red, green: green, blue: blue, opacity: 1.0)
    }
}
