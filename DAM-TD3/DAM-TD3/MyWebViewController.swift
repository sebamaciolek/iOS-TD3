//
//  MyWebViewController.swift
//  DAM-TD3
//
//  Created by MACIOLEK Sebastian and LANDRAUDIE Marine on 17/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit

class MyWebViewController: UIViewController, UIScrollViewDelegate {
    
    var webView = UIWebView()
    var getURL = ""
    var getURLTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sendButton = UIBarButtonItem(title: "Safari", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyWebViewController.openSafari))
        self.navigationItem.rightBarButtonItem = sendButton
        
        webView = UIWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        loadWebView()
        self.view.addSubview(webView)
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: self.view.frame.size.height - 93, width: self.view.frame.size.width, height: 49)
        toolBar.sizeToFit()
        
        let boutonRetour = UIButton(type: .custom)
        boutonRetour.setImage(UIImage(named:"backArrow"), for: .normal)
        boutonRetour.imageView?.contentMode = .scaleAspectFit
        boutonRetour.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        boutonRetour.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        let ToolBarButtonBack = UIBarButtonItem(customView: boutonRetour)
        
        let boutonSuivant = UIButton(type: .custom)
        boutonSuivant.setImage(UIImage(named:"nextArrow"), for: .normal)
        boutonSuivant.imageView?.contentMode = .scaleAspectFit
        boutonSuivant.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        boutonSuivant.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        let ToolBarButtonNext = UIBarButtonItem(customView: boutonSuivant)
        
        let boutonRafraichir = UIButton(type: .custom)
        boutonRafraichir.setImage(UIImage(named:"refresh"), for: .normal)
        boutonRafraichir.imageView?.contentMode = .scaleAspectFit
        boutonRafraichir.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        boutonRafraichir.addTarget(self, action: #selector(actionRefresh), for: .touchUpInside)
        let ToolBarButtonRefresh = UIBarButtonItem(customView: boutonRafraichir)
        
        let boutonStop = UIButton(type: .custom)
        boutonStop.setImage(UIImage(named:"cancel"), for: .normal)
        boutonStop.imageView?.contentMode = .scaleAspectFit
        boutonStop.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        boutonStop.addTarget(self, action: #selector(actionStop), for: .touchUpInside)
        let ToolBarButtonStop = UIBarButtonItem(customView: boutonStop)
        
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ToolBarButtonBack, flexibleSpace, ToolBarButtonNext, flexibleSpace, ToolBarButtonRefresh, flexibleSpace, ToolBarButtonStop], animated: true)
        
        self.view.addSubview(toolBar)
    }
    
    func actionBack(){
        webView.goBack()
    }
    
    func actionNext(){
        webView.goForward()
    }
    
    func actionRefresh(){
        webView.reload()
    }
    
    func actionStop(){
        webView.stopLoading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebView(){
        var myURL = URL(string: getURL)
            
        navigationItem.title = getURLTitle
        if(myURL == nil){
            myURL = URL(string: "http://google.com")
            navigationItem.title = "Google"
        }
        let myURLRequest:URLRequest = URLRequest(url: myURL!)
        webView.loadRequest(myURLRequest)
    }
    
    func openSafari(sender:UIButton) {
        UIApplication.shared.open(URL(string: getURL)!, options: [:], completionHandler: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
