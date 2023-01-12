//
//  tabModel.swift
//  apiCallerSwiftUi
//
//  Created by Aarish Khanna on 11/01/23.
//

import Foundation

struct tabModel: Identifiable  {
    let id = UUID().uuidString
    var tab: String

}

let tabItems: [tabModel] = [
    tabModel(tab: "Users"),
    tabModel(tab: "To Dos"),
]


