//
//  ContentView.swift
//  Animated Indicator
//
//  Created by 드즈 on 2022/12/20.
//

import SwiftUI

extension Color {
    static let mainCyan = Color("Cyan+")
    static let mainYellow = Color("Yellow+")
    static let mainGreen = Color("Green+")
}

struct ContentView: View {
    var body: some View {
        
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    // colors as Tabs...
    // use your own tabs here...
    var colors: [Color] = [.mainCyan, .mainYellow, .mainGreen]
    
    // offset...
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        // TabView has problem in ignoring top edge...
        // fix use scrollView...
        ScrollView(.init()) {
            
            TabView {
                
                ForEach(colors.indices,id: \.self) {index in
                    
                    if index == 0 {
                        colors[index]
                            .overlay(
                                
                                // GeometryReader for getting offset...
                                GeometryReader{proxy -> Color in
                                    
                                    let minX = proxy.frame(in: .global).minX
                                    
                                    print(minX)
                                    
                                    DispatchQueue.main.async {
                                        withAnimation(.default) {
                                            
                                            self.offset = -minX
                                        }
                                    }
                                    
                                    return Color.clear
                                }
                                .frame(width: 0, height: 0)
                                
                                ,alignment: .leading
                            )
                    }
                    else{
                        colors[index]
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
            
                // Animated Indicators...
                HStack(spacing: 15) {
                    
                    ForEach(colors.indices,id: \.self) {index in
                        
                        Capsule()
                            .fill(Color.white)
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                // Smooth Sliding Effect...
                .overlay(
                    
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 20, height: 7)
                        .offset(x: getOffset())
                    
                    ,alignment: .leading
                )
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .padding(.bottom,10)
                        
                ,alignment: .bottom
            )
        }
        .ignoresSafeArea()
    }
    
    // getting Index...
    func getIndex() -> Int {
        
        let index = Int(round(Double(offset / getWidth())))
        
        return index
    }
    
    // getting Offset for Capsule Shape...
    func getOffset() -> CGFloat{
        
        // spacing = 15
        // Circle width = 7
        // so total = 22
        
        let progress = offset / getWidth()
        
        return 22 * progress
    }
}

// extending View to get width...

extension View {
    
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}
