//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by David Roberts on 11/07/2023.
//

import Foundation
import CoreData

struct MenuList: Codable {
    
    let menu: [MenuItem]
    
    static func getMenuData(viewContext: NSManagedObjectContext) {
        
        PersistenceController.shared.clear()
        
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: serverURLString)
        guard let url = url else {
            print("Invalid server URL")
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let menuList = try decoder.decode(MenuList.self, from: data)
                    
                    DispatchQueue.main.async {
                        Dish.createDishesFrom(menuItems: menuList.menu, viewContext)
                        Dish.save(viewContext)
                    }
                    
                } catch {
                    print("Error decoding menu data: \(error)")
                }
            }
        }
        task.resume()
    }
}


struct MenuItem: Codable {
    let title: String
    let price: String
    let description: String
    let image: String
    let category: String
}
