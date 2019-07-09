//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nelson on 9/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    //MARK: UITableView Datasource Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name!
        
        return cell
    }
    
    //MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            let category = categories[indexPath.row]
            
            vc.selectedCategory = category
        }
    }

   
    @IBAction func addButtonPress(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add Category", message: "Add new category", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
            textField.placeholder = "Category Name"
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let name = alert.textFields?[0].text
            
            //create new category
            let newCategory = Category(context: self.context)
            newCategory.name = name
            
            self.categories.append(newCategory)
            
            self.saveData()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension CategoryViewController{
    
    func loadData(with request:NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categories = try context.fetch(request)
        }
        catch{
            
            print("Error fetch data \(error)")
        }
        
        tableView.reloadData()
    }
    
    func saveData(){
        
        do{
            try context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
}

extension CategoryViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadData(with: request)
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
