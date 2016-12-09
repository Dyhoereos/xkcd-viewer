//
//  ViewController.swift
//  xkcd viewer
//
//  Created by arcui on 2016-12-08.
//  Copyright © 2016 Dyhoer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {

    let maxNum = 1769
    var curNum = 1769
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var altLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadComic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadComic(){
        let url = "http://xkcd.com/\(curNum)/info.0.json"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                   let alt = json["alt"].stringValue

                    self.altLabel.text = alt

                    
                  
                    Alamofire.request(json["img"].string!).responseImage { response in
                        if let image = response.result.value{
                            self.imageView.image = image
                        }
                    }

                    
                    
                case .failure(let error):
                    print(error)
                }
        }
      
    }

    @IBAction func nextClicked(_ sender: UIButton) {
        if (curNum < maxNum) {
            curNum += 1;
        }
        loadComic()
        
    }

    @IBAction func prevClicked(_ sender: AnyObject) {
        if (curNum > 0) {
            curNum -= 1
        }
        loadComic()
    }
}

