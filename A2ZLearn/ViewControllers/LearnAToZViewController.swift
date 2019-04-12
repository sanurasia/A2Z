//
//  LearnAToZViewController.swift
//  A2ZLearn
//
//  Created by sanjay kumar chaurasia on 11/04/19.
//  Copyright © 2019 sanjay kumar chaurasia. All rights reserved.
//

import UIKit
import FSPagerView
import AVFoundation

class LearnAToZViewController: UIViewController {
    
    fileprivate let lettersName = ["A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
            let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
            self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
     func imageWith(name: String?,frame: CGRect) -> UIImage? {
       // let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 200)
        nameLabel.text = name
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
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



extension LearnAToZViewController:FSPagerViewDelegate,FSPagerViewDataSource{
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return lettersName.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = self.imageWith(name: lettersName[index], frame: self.pagerView.frame)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.speakTheLetter(text: "This is" + lettersName[index])
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int){
        self.speakTheLetter(text: lettersName[index])
    }
    
    func speakTheLetter(text:String){
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string:text)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 3.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
    }
}
