import Foundation
import CoreData

extension Dish {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var price: Float
    @NSManaged public var image: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var category: String?
}



extension Dish: Identifiable {
    
    public var id: String {
        return self.title!
    }
    
    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = false
        return request
    }
    
    static func exists(name: String,
                     _ context:NSManagedObjectContext) -> Dish? {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "title == %@", name)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title",
                                              ascending: false,
                                              selector: #selector(NSString .localizedStandardCompare))
        request.sortDescriptors = [sortDescriptor]
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else { return nil }
            return dish
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func delete(with name: String,
                       _ context:NSManagedObjectContext) -> Bool {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "title == %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else {
                return false
            }
            context.delete(dish)
            return true
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    
    class func deleteAll(_ context:NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            save(context)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }


    static func save(_ context:NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            
            if let _ = exists(name: menuItem.title, context) {
                continue
            }
            
            let dish = Dish(context: context)
            dish.title = menuItem.title
            dish.price = Float(menuItem.price) ?? 0
            dish.image = menuItem.image
            dish.itemDescription = menuItem.description
            dish.category = menuItem.category
        }
    }
}
