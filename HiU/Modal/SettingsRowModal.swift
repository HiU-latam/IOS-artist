//
//  SettingsRowModal.swift
//  HiU
//
//  Created by Shiny solutions on 7/26/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

public func dataFromFile(_ filename: String) -> Data? {
    NSLog("dataFromFile", "")
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class Settings{
    var settingsNumberRequests = [SettingsNumberRequest]()
    var settingsCharityPreferences = [SettingsCharityPreferences]()
    
    init?(data: Data) {
        NSLog("Settings - init", "")
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                
                NSLog("Settings - init - %@", json)
                
                if let settingsNumberRequest = body["numberRequestAllowed"] as? [[String: Any]] {
                    self.settingsNumberRequests = settingsNumberRequest.map { SettingsNumberRequest(json: $0) }
                    NSLog("Settings - init - %@", self.settingsNumberRequests)
                }
                
                if let settingsCharityPreferences = body["charityPreferences"] as? [[String: Any]] {
                    self.settingsCharityPreferences = settingsCharityPreferences.map { SettingsCharityPreferences(json: $0) }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

class SettingsNumberRequest{
    var name: String?
    var selected: String?
    
    init(json: [String: Any]) {
        NSLog("SettingsNumberRequest - init", "")
        self.name = json["name"] as? String
        self.selected = json["selected"] as? String
    }
}

class SettingsCharityPreferences{
    var name: String?
    var selected: String?
    
    init(json: [String: Any]) {
        NSLog("SettingsCharityPreferences - init", "")
        self.name = json["name"] as? String
        self.selected = json["selected"] as? String
    }
}

class SettingsRowModal: NSObject {

    var name: String
    var selected: String
    var type: String
    
    init(name: String, selected: String, type: String){
        self.name = name
        self.selected = selected
        self.type = type
    }
    
}

enum Selection: String {
    case Yes
    case No
}
