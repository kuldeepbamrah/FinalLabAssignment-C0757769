//
//  ProductDetailViewController.swift
//  FinalLabAssignment-C0757769
//
//  Created by MacStudent on 2020-01-24.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var desclabel: UITextView!
    
    @IBOutlet weak var priceLabel: UILabel!
    var productArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromCoreData()
        titleLabel.text = productArray[0].name
        desclabel.text = productArray[0].description
        priceLabel.text = "\(productArray[0].price)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func listBtn(_ sender: Any)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let newVC = sb.instantiateViewController(identifier: "listTable") as! ProductTableViewController
        navigationController?.pushViewController(newVC, animated: true)
    }
    func loadFromCoreData()
    {
        
        productArray = [Item]()
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do{
            let results = try context.fetch(fetchRequest)
            if results is [NSManagedObject]
            {
                for result in results as! [NSManagedObject]
                {
                    let name = result.value(forKey: "name") as! String
                    let desc = result.value(forKey: "desc") as! String
                    let price = result.value(forKey: "price") as! Double
                    let id = result.value(forKey: "id") as! String
                    let product = Item(id: id, name: name, description: desc, price: price)
                    self.productArray.append(product)
                    print(productArray.count)
                    //print(result)

                }
            }
        } catch{
            print(error)
        }
                      
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
