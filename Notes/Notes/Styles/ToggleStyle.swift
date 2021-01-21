//
//  ToggleStyle.swift
//  Notes
//
//  Created by Егор on 19.01.2021.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle{

    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            configuration.label
             
            Spacer()
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                    print("tap")
            }
        }
    }
}
