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
    var waifuUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waifuManager.delegate = self
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getWaifuPressed(_ sender: Any) {
        waifuManager.getWaifu()
        starr.flashImage(image: "starPressed", wait: 0.2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "waifuSegue" {
            print(waifuUrl)
            let destinationVC = segue.destination as! WaifuController
            destinationVC.waifuUrl = waifuUrl
        }
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
        waifuUrl = URL(string: myWaifu.images?.first?.url ?? "")
        DispatchQueue.main.async {
            //self.present(waifuController, animated: true)
            self.performSegue(withIdentifier: "waifuSegue", sender: self)
        }
    }
}


