//
//  AppDelegate.swift
//  Test
//
//  Created by Nelson on 9/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

/*
 Add following code to end of your AppDelegate.swift file but have to be outside of AppDelegate class not inside.
 
 Locate line "newObject!["date"] = Date()" in migrateRealm method in AppDelegate extension and change "date" to name of your property in
 your Item class for example, mine is @objc dynamic var date : Date = Date() so in [] I give "date", if yours is
 like @objc dynamic var dateCreated : Date = Date() then you give "dateCreated" in []. Doing so is basically setting
 a new created current date object to realm database during migration process.
 
 In your todo item view controller class you replace line "let realm = try! Realm()" to "let realm = AppDelegate.getRealm()"
 and do the same thing to category view controller. Note. we have made an extened static method getRealm() to AppDelegate so we can just call it from AppDelegate.
 
 Remember to change your Item model class to have date property
 
 Note. Whenever you modify your model for example, in Item.swift or Category.swift. you have to change schema version which is
 grater than old version, defaul schema version when create Realm is 0.
 
 Realm offical documentation for migration https://realm.io/docs/swift/latest/#migrations
*/

extension AppDelegate{
    
    /**
    Get Realm object
     */
    static func getRealm() -> Realm{
        
        //run migration check if it need to migrate
        migrateRealm()
        
        do{
            let realm = try Realm()
            
            return realm
        }
        catch{
            
            fatalError("Create realm fail \(error)")
        }
    }
    
    /**
    method to check if realm need to be migrated and perfrom
     migration when it need to.
     
    fileprivate to make this method only accessible
    in this file
     */
    fileprivate static func migrateRealm(){
        
        //struct to track migration status
        struct migrateStatus{
            
            //false to make sure app try to check if realm need to be
            //migrate
            static var migrated = false
        }
        
        //if realm need to be migrated
        if(!migrateStatus.migrated){
            /////////////////////////////////
            ////Perform realm migration//////
            /////////////////////////////////
            
            //How to migrate https://realm.io/docs/swift/latest/#migrations
            
            //new Realm version. Change version every time you change model
            //version number must greater than old version otherwise it will not
            //migrate
            let migrateVersion : UInt64 = 1
            
            //create a configuration
            let config = Realm.Configuration(
                
                //version of new realm must greater than old version
                //default realm version is 0
                schemaVersion: migrateVersion,
                
                // Set the block which will be called automatically when opening a Realm with
                // a schema version lower than the one set above
                migrationBlock:{
                    migration, oldSchemaVersion in
                    
                    //if old version is smaller than migrattion version
                    if(oldSchemaVersion < migrateVersion){
                        
                        //perform any migrate operation here by using migration value
                        migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
                            // we set data property in Item to a new date object which is current date
                            newObject!["date"] = Date()
                        }
                    }
            })
            
            // Tell Realm to use this new configuration object for the default Realm
            Realm.Configuration.defaultConfiguration = config
            
            migrateStatus.migrated = true
        }
    }
}

