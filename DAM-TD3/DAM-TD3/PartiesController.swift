//
//  PartiesController.swift
//  DAM-TD3
//
//  Created by MACIOLEK Sebastian and LANDRAUDIE Marine on 23/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import SWXMLHash

class PartiesController: UITableViewController {
    
    var tabEvent = [Event]()
    
    @IBOutlet weak var outletSortStatus: UIBarButtonItem!
    
    var sortStatus = true
    
    var dateFormatterDateHeure = DateFormatter()
    var dateFormatterDate = DateFormatter()
    var dateFormatterHeure = DateFormatter()
    var imageViewFlyer : UIImageView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatterDateHeure.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatterDate.dateFormat = "dd/MM/yyyy"
        dateFormatterHeure.dateFormat = "HH:mm"

        
        
        if let url = URL(string: "http://sealounge.lanoosphere.com/seadata_en.xml")
        {
            do{
                let data = try Data(contentsOf: url)
                let xml = SWXMLHash.parse(String(data: data, encoding: .utf8)!)
                
                for elem in xml["Data"]["Event"].all {
                    let dateString = elem.element?.attribute(by: "date")?.text
                    var dateConverted = Date()
    
                    dateConverted = dateFormatterDateHeure.date(from: (dateString)!)!
                    
                    tabEvent.append(Event(id: Int((elem.element?.attribute(by: "id")?.text)!)!,
                                          dateHeure: dateConverted,
                                          nom: (elem.element?.attribute(by: "name")?.text)!,
                                          flyer: URL(string: (elem.element?.attribute(by: "flyer")?.text)!)!)
                    )
                }
            }
            catch{
                print("error retrieving file")
            }
        }
        else{
            print("not an URL")
        }
        tabEvent = tabEvent.sorted(by: { $0.dateHeure > $1.dateHeure })
        
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
        return tabEvent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let leEvent = tabEvent[indexPath.row]
        self.imageViewFlyer = cell.viewWithTag(100) as! UIImageView?
        
    
            let dtinternet = NSData(contentsOf:leEvent.flyer! as URL)!
            
            DispatchQueue.global(qos: .background).sync {
                self.imageViewFlyer?.image = UIImage(data:dtinternet as Data)
                self.imageViewFlyer?.alpha = 0
            }
        // Call the function for the fade in animation
        fadeIn()

        
        if let labelDate = cell.viewWithTag(101) as? UILabel {
            labelDate.text = "le " + dateFormatterDate.string(from: leEvent.dateHeure)
        }
        
        if let labelHeure = cell.viewWithTag(102) as? UILabel {
            labelHeure.text = dateFormatterHeure.string(from: leEvent.dateHeure)
        }
        
        if let labelName = cell.viewWithTag(103) as? UILabel {
            labelName.text = leEvent.nom
        }
        
        return cell
    }

    @IBAction func actionSort(_ sender: UIBarButtonItem) {
        if sortStatus{
            tabEvent = tabEvent.sorted(by: { $1.dateHeure > $0.dateHeure })
            sortStatus = false
            outletSortStatus.title = "Anciens"
        }
        else{
            tabEvent = tabEvent.sorted(by: { $0.dateHeure > $1.dateHeure })
            sortStatus = true
            outletSortStatus.title = "Récents"
        }
        tableView.reloadData()
    }
   
    // Function doing the animation on the image
    func fadeIn(duration: TimeInterval = 0.50, delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
         self.imageViewFlyer?.alpha = 0
            
            if self.imageViewFlyer == nil {
                print("nul")
            }
            self.imageViewFlyer?.alpha = 1
        }, completion: completion)  }
    
    
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
