//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nelson on 9/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    //let realm = try! Realm()
    let realm = AppDelegate.getRealm()
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    //MARK: UITableView Datasource Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added yet!!!"
        
        return cell
    }
    
    //MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            vc.selectedCategory = categories?[indexPath.row]
        }
    }

   //MARK: Add category
    @IBAction func addButtonPress(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add Category", message: "Add new category", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
            textField.placeholder = "Category Name"
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let name = alert.textFields?[0].text
            
            //create new category
            let newCategory = Category()
            newCategory.name = name!
            
            self.saveData(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension CategoryViewController{
    
    func loadData(){

        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    func saveData(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
}

extension CategoryViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        categories = categories?.filter("name CONTAINS[cd] %@", searchBar.text!)
        
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
