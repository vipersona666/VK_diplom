//
//  CoreDataManager.swift
//  VK
//
//  Created by Andrei on 13.07.2023.
//

import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    private init(){
        reloadPosts()
    }
    
    var posts = [Posts]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Post")
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
    
    func createPost(title: String, descriptionPost: String, image: String, likes: Int16, views: Int16, id: String){
        let post = Posts(context: persistentContainer.viewContext)
        post.title = title
        post.descriptionPost = descriptionPost
        post.image = image
        post.likes = likes
        post.views = views
        post.id = id
        saveContext()
        reloadPosts()
    }
    
    func reloadPosts(){
        let request = Posts.fetchRequest()
        let posts = try? persistentContainer.viewContext.fetch(request)
        self.posts = posts ?? []
    }
    
    func deletePost(post: Posts){
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
    }
}

