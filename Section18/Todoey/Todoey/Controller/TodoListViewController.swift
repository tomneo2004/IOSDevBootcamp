//
//  ViewController.swift
//  Todoey
//
//  Created by Nelson on 8/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

    //let realm = try! Realm()
    let realm = AppDelegate.getRealm()
    var todoItems : Results<Item>?
    var userDefault = UserDefaults.standard
    //let dataFilePath  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        
        tableView.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let colorHex = selectedCategory?.backgroundColor else{
            fatalError("No color")
        }
            
        title = selectedCategory!.name
        
        updateNavBar(colorHex: colorHex)
        
        searchBar.barTintColor = UIColor(hexString: colorHex)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateNavBar(colorHex: "007AFF")

    }
    
    //MARK: - Update nav bar
    func updateNavBar(colorHex : String){
        
        guard let navBar = navigationController?.navigationBar else{
            fatalError("Navigation bar does not exist")
        }
        
        navBar.barTintColor = UIColor(hexString: colorHex)
        navBar.tintColor = UIColor.init(contrastingBlackOrWhiteColorOn: navBar.barTintColor, isFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(contrastingBlackOrWhiteColorOn: navBar.barTintColor, isFlat: true)!]
        
        
    }
    
    //MARK: - Add new item
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let textFields : [UITextField] = alert.textFields{
                
                
                if let currentCategory = self.selectedCategory{
                    
                    do{
                        
                        try self.realm.write {
                            
                            let newItem = Item()
                            newItem.title = textFields[0].text!
                            newItem.date = Date()
                            currentCategory.items.append(newItem)
                        }
                        
                    }
                    catch{
                        print("Error saving new items \(error)")
                    }
                    
                }
                
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
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row]{
         
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            if let color = UIColor(hexString: selectedCategory?.backgroundColor).darken(byPercentage: CGFloat(indexPath.row)/CGFloat(todoItems!.count)){
                cell.backgroundColor = color
            }
            cell.textLabel?.textColor = UIColor.init(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
        }
        else{
            
            cell.textLabel?.text = "No item added"
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        if let item = todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                    
                    item.done = !item.done
                }
            }
            catch{
                
                print("Error chaning done for item \(error)")
            }
        }
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    
    //MARK: override from super for updating model
    override func updateModel(at indexPath: IndexPath) {
        
        do{
            
            if let item = todoItems?[indexPath.row]{
                
                try self.realm.write {
                    realm.delete(item)
                }
            }
            
        }
        catch{
            print("Delete category error \(error)")
        }
        
        
        //update all items' color after delete index path
        let visibleCells = tableView.visibleCells
        for i in 0..<visibleCells.count{
            if i <= indexPath.row{
                continue
            }
            
            let cell = visibleCells[i]
            if let color = UIColor(hexString: selectedCategory?.backgroundColor).darken(byPercentage: CGFloat(i-1)/CGFloat(todoItems!.count)){
                cell.backgroundColor = color
            }
            cell.textLabel?.textColor = UIColor.init(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
        }
    }
    
    //MARK: - Other method

    func loadData(){
        

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        //not sorted
        //todoItems = realm.objects(Item.self).filter("%@ IN parentCategory", selectedCategory!)
        

        self.tableView.reloadData()

    }
    
}

extension TodoListViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = selectedCategory?.items.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)

        tableView.reloadData()

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
