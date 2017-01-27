//
//  WebsitesTableViewController.swift
//  DAM-TD3
//
//  Created by MACIOLEK Sebastian and LANDRAUDIE Marine on 16/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit

class WebsitesTableViewController: UITableViewController{
    var sites: [String:String] = [
        "Apple" : "http://apple.com",
        "Facebook" : "http://facebook.com",
        "YouTube" : "http://youtube.com",
        "Microsoft" : "http://microsoft.com",
        "Sony" : "http://sony.com",
        "" : ""
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //add your data into tables array from textField
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellLabel", for: indexPath)
        
        let key = Array(sites.keys)[indexPath.row]
        let value = Array(sites.values)[indexPath.row]
        
        if key == "" && value == ""{
            cell.imageView?.image = UIImage(named: "plus")
            cell.textLabel?.text = "Ajouter un nouveau site"
            cell.detailTextLabel?.text = ""
        }
        else{
            let strurl = NSURL(string: "http://www.google.com/s2/favicons?domain="+value)!
            let dtinternet = NSData(contentsOf:strurl as URL)!
            
            cell.imageView?.image = UIImage(data:dtinternet as Data)
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = value
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        let theWebViewController = MyWebViewController()
        
        theWebViewController.getURL = currentCell.detailTextLabel!.text!
        theWebViewController.getURLTitle = currentCell.textLabel!.text!
        
        if currentCell.imageView?.image == UIImage(named: "plus") {
            let alert: UIAlertController = UIAlertController(title: "Nouveau site", message: "", preferredStyle: .alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Annuler", style: .cancel) { action -> Void in
                
            }
            alert.addAction(cancelAction)
            
            let nextAction: UIAlertAction = UIAlertAction(title: "Ajouter", style: .default) { action -> Void in
                
                let label = alert.textFields![0].text
                let URL = alert.textFields![1].text
                
                if label == "" || URL == ""{
                    let alertError: UIAlertController = UIAlertController(title: "Alerte", message: "Veuillez saisir un nom et une adresse correcte", preferredStyle: .alert)
                    let closeAction: UIAlertAction = UIAlertAction(title: "Fermer", style: .cancel) { action -> Void in
                    }
                    alertError.addAction(closeAction)
                    
                    self.present(alertError, animated: true, completion: nil)
                }
                else{
                    self.sites[label!] = URL
                    tableView.reloadData()
                }
            }
            alert.addAction(nextAction)
            
            alert.addTextField { textField -> Void in
                textField.placeholder = "Nom du site"
            }
            
            alert.addTextField { textField -> Void in
                textField.placeholder = "URL"
                textField.text = "http://"
            }
            
            self.present(alert, animated: true, completion: nil)
        }
        else{
            navigationController?.pushViewController(theWebViewController, animated: true)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
