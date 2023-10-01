//
//  Persistence.swift
//  evoluservices
//
//  Created by Manollo on 29/09/23.
//

import CoreData
import Combine

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer
    
    let dataChangedPublisher = PassthroughSubject<Void, Never>()
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "evoluservices")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                
                fatalError("Erro ao iniciar o Core Data: \(error.localizedDescription)")
                
            }
        }
    } //classe singleton
    
    
    
    func getAllItems() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
           return []
        }
    }
    
    func saveItem(title: String, description: String, date: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let item = Item(context: persistentContainer.viewContext)
        item.id = UUID().uuidString
        item.title = title
        item.descript = description
        item.date = date
        
        do{
            try persistentContainer.viewContext.save()
            dataChangedPublisher.send()
            completion(.success(true))
        } catch {
            completion(.failure(error))
            print("Falha ao salvar item: \(title)")
            
        }
        
        
        
    }
    
    func deleteItem(item: Item){
        
        persistentContainer.viewContext.delete(item)
        
        do{
            
            try persistentContainer.viewContext.save()
            dataChangedPublisher.send()
            
        } catch {
            
            persistentContainer.viewContext.rollback()
            print("Erro ao deletar Item")
            
        }
        
    }
    
    func updateItem(id: String, title: String, description: String, date: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let item: Item!
        
        let fetchItems : NSFetchRequest<Item> = Item.fetchRequest()
        fetchItems.predicate = NSPredicate(format: "id = %@", id)
        
        let fetchResults = try? persistentContainer.viewContext.fetch(fetchItems)
            
        if fetchResults?.count != 0 {
            
            item = fetchResults!.first
            
            item.date = date
            item.descript = description
            item.title = title

            do{
                try persistentContainer.viewContext.save()
                dataChangedPublisher.send()
                completion(.success(true))
                
            } catch {
                completion(.failure(error))
                print("Erro ao editar Item")
                
            }
                
            
            
            
            
        } else {
            
            print("Item não localizado.")
            
        }
                
            
        
        
    }
    
}
