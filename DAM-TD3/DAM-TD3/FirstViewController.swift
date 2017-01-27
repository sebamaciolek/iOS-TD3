//
//  FirstViewController.swift
//  DAM-TD3
//
//  Created by MACIOLEK Sebastian and LANDRAUDIE Marine on 16/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var imageView = UIImageView()
    var image = UIImage()
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionCreateImage(_ sender: UIButton) {
        self.view.addSubview(imageView)
    }
    
    @IBAction func actionSetImage(_ sender: UIButton) {
        image = UIImage(named: "lambo")!
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: screenSize.width, width: screenSize.width, height: 200)
        imageView.contentMode = .scaleAspectFill
        
    }
    
    @IBAction func actionShowImage(_ sender: UIButton) {
        if let url = URL(string: "http://dam.lanoosphere.com/remote_sample.png") {
            do  {
                let data = try Data(contentsOf: url)
                imageView.image = UIImage(data: data)
            }
            catch {
                print("error retrieving file")
            }
        }
        else {
            print("not a URL")
        }
    }

}

