//
//  ColorPickerView.swift
//  SiPaint
//
//  Created by Rivaldo Fernandes on 15/04/22.
//

import Foundation
import SwiftUI

struct ColorPickerView: View {
    let colors = [Color.red, Color.orange, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self){ color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill: Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

