//
//  ViewController.swift
//  waifuGenerator
//
//  Created by vladislav bek on 14.08.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var starr: UIImageView!
    
    var waifuManager = WaifuManager()
    var myWaifu = Waifu(images: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waifuManager.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func getWaifuPressed(_ sender: Any) {
        
        waifuManager.getWaifu()
        starr.flashImage(image: "starPressed", wait: 0.2)
        
        //  backgroundView.newImage(new: "bg1", wait: 0.3)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.backgroundView.image = UIImage(named: "bg1")
//        }
      
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.backgroundView.image = UIImage(named: "bg2")
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.backgroundView.image = UIImage(named: "bg2")
//        }
        
        
    }
    
}

extension UIImageView {
    func newImage(new: String, wait: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + wait) {
            self.image = UIImage(named: new)
        }
    }
    func flashImage(image: String, wait: Double) {
        let old = self.image
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.image = UIImage(named: image)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + wait) {
            self.image = old
        }
    }
}

extension UIImageView {
  func imageFrom(url:URL){
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
          }
        }
      }
    }
  }
}

extension ViewController: sendWaifuDelegate {
    func sendWaifu(_ waifu: Waifu) {
        myWaifu = waifu
//        let waifuUrl = URL(string: myWaifu.images?.first?.url ?? "")!
//         backgroundView.imageFrom(url: waifuUrl)
        DispatchQueue.main.async {
            var waifuController = WaifuController()
            waifuController.waifuUrl = URL(string: waifu.images?.first?.url ?? "")
        }
               
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "waifuSegue", sender: self)
        }
    }
}
