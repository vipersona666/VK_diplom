//
//  CoreDataService.swift
//  VK
//
//  Created by Andrei on 16.08.2023.
//

import CoreData

class CoreDataService{
    static let shared = CoreDataService()
    private init(){
        reloadData()
    }
    //Массив постов сохраненных в coredata
    var data = [RickMortiDataPost]()
    //Массив постов полученных из сети
    var postsData = [RickMortiData.Hero]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
            }
        }
    }
    
    func createData(id: String, status: String, name: String, image: String){
        let dataPost = RickMortiDataPost(context: persistentContainer.viewContext)
        dataPost.id = id
        dataPost.name = name
        dataPost.image = image
        dataPost.status = status
        //dataPost.uuid = uuid
        saveContext()
        reloadData()
    }
    
    func reloadData(){
        let request = RickMortiDataPost.fetchRequest()
        let post = try? persistentContainer.viewContext.fetch(request)
        self.data = post ?? []
    }
    func deletePost(post: RickMortiDataPost){
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadData()
    }
    
    
}

