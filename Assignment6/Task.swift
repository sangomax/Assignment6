//
//  Task.swift
//  Assignment6
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-08.
//

import Foundation

struct Task : Codable{
    var noChecked: Bool
    var name: String
    var desc: String
    var priority: String
    
    
    init(lName: String, lDesc: String, lPrio: String) {
        noChecked = true
        name = lName
        desc = lDesc
        priority = lPrio
    }
    
    static var archiveURL: URL {
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let archiveURL = documentsURL.appendingPathComponent("tasks").appendingPathExtension("plist")
      
      return archiveURL
    }
    
    static func saveToFile(tasks: [[Task]]) {
      let encoder = PropertyListEncoder()
      do {
        let encodedTasks = try encoder.encode(tasks)
        try encodedTasks.write(to: Task.archiveURL)
      } catch {
        print("Error encoding tasks: \(error.localizedDescription)")
      }
    }
    
    static func loadFromFile() -> [[Task]]? {
      guard let taskData = try? Data(contentsOf: Task.archiveURL) else { return nil }
      
      do {
        let decoder = PropertyListDecoder()
        let decodedTasks = try decoder.decode([[Task]].self, from: taskData)
        
        return decodedTasks
      } catch {
        print("Error decoding tasks: \(error)")
        return nil
      }
    }
}
