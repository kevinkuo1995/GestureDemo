//
//  ViewModel.swift
//  GestureDemo
//
//  Created by DEVV on 2021/5/29.
//

import Foundation

class ViewModel {
    
    var section1: [GestureType] {
        let data = GestureType.allCases
        return data
    }
    
}
