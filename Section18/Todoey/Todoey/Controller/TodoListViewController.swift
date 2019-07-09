//
//  ViewController.swift
//  Todoey
//
//  Created by Nelson on 8/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    var userDefault = UserDefaults.standard
    //let dataFilePath  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory : Category?{
        
        didSet{
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //print(dataFilePath!)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        
        //loadData()
        

    }
    
    //MARK: - Add new item
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let textFields : [UITextField] = alert.textFields{
                
                
                let newItem = Item(context: self.context)
                
                newItem.title = textFields[0].text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                self.itemArray.append(newItem)
                
                self.saveItems()
                
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Tableview Datasource Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK: - Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        item.done = !item.done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveItems()
        
        
        
        //tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    
    //MARK: - Other method
    func saveItems(){
        
//        let encoder = PropertyListEncoder()
//
//        do{
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//        }
//        catch{
//
//            print("encode data fail\(error)")
//        }
        
        do{
            try context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){
        
//        let decoder = PropertyListDecoder()
//
//        do{
//            let data = try Data(contentsOf: dataFilePath!)
//            itemArray = try decoder.decode([Item].self, from: data)
//        }
//        catch{
//            print("Decode data fail \(error)")
//        }
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
            
            let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
            
            var predicates = [categoryPredicate]
            
            if let otherPredicate = predicate{
                predicates.append(otherPredicate)
            }
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            
            itemArray = try context.fetch(request)
        }
        catch{
            print("Error fetching request \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
}

extension TodoListViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate =  NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
//        do{
//            itemArray = try context.fetch(request)
//        }
//        catch{
//            print("Error fetch request \(error)")
//        }
        
        loadData(with: request, predicate: predicate)
        
        //tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            loadData()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
