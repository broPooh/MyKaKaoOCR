//
//  OCRViewController.swift
//  MyKaKaoOCR
//
//  Created by bro on 2022/05/10.
//

import UIKit

class OCRViewController: UIViewController {

    @IBOutlet weak var ocrImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    var resultString: [String] = []
    //var resultString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        guard let image = ocrImageView.image else { return }
        
        OCRAPIManager.shared.fetchOcrData(image: image) { code, json in
            //print("result", json["result"])
            
            for item in json["result"].arrayValue {
                print(item["recognition_words"][0].stringValue)
                self.resultString.append(item["recognition_words"][0].stringValue)
                //self.resultString.append(" \(item["recognition_words"].stringValue.replacingOccurrences(of: "\"", with: ""))")
            }
            
            self.resultLabel.text = self.resultString.joined(separator: " ")

        }
    }
    
    
}
