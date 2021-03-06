//
//  CoreDataManager.swift
//  Cuisiner
//
//  Created by Fatih Gursoy on 28.06.2022.
//

import Foundation
import CoreData

class CoreDataManager {

    init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cuisiner")
        
        container.loadPersistentStores(completionHandler: { _, error in
                    _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
    
// - MARK: Functions
    
    var savedRecipes: [SavedRecipe] {
        guard let items = try? mainContext.fetch(fetchRequest) else { return [] }
        return items
    }
    
    @objc func didChange() {
        
        
    }
    
    func fetchRecipe(_ recipeID: String) -> SavedRecipe? {
                
        guard let request = try? mainContext.fetch(fetchRequest) else { return nil }
        
        let recipes = request.filter { $0.recipeID == recipeID }
        return recipes.first
    }
    
    func addNewRecipe(_ recipeID: String) {
        
        if savedRecipes.filter({ $0.recipeID == recipeID }).count < 1 {
            
            let newRecipe = SavedRecipe(context: mainContext)
            newRecipe.recipeID = recipeID
                
            do {
                try self.mainContext.save()
            } catch {
                let error = error as NSError
                print("Unable to Save: \(error)")
            }
        }
    }
    
    func deleteRecipe(with recipeID: String) {
        
        guard let recipe = fetchRecipe(recipeID) else { return }
        mainContext.delete(recipe)
        
        do {
            try self.mainContext.save()
        } catch {
            let error = error as NSError
            print("Unable to Delete: \(error)")
        }
    }

}
