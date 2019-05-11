//
//  ViewController.swift
//  A2ZLearn
//
//  Created by sanjay kumar chaurasia on 11/04/19.
//  Copyright © 2019 sanjay kumar chaurasia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var action = -1
    var  lettersName = ["a","b","c","d","e","F","G","H",
                        "I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var numbers = ["1","2","3","4","5","6","7","8",
                   "9","10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LearnAToZAction(_ sender: UIButton) {
        action = sender.tag
        self.performSegue(withIdentifier: "learnAToZSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LearnAToZViewController{
            
            if(action == 1){
                destination.lettersName = lettersName
            }else{
                destination.lettersName = numbers
            }
        }
    }
    

}

