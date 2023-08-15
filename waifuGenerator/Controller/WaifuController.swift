//
//  WaifuController.swift
//  waifuGenerator
//
//  Created by vladislav bek on 14.08.23.
//

import UIKit

class WaifuController: UIViewController {

    var waifuUrl: URL?
    
    @IBOutlet weak var waifuImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(waifuUrl)
    }


}
