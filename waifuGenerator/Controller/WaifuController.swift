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
        if let url = waifuUrl {
            waifuImageView.image = loadGif("fallingSpiral")
            waifuImageView.imageFrom(url: url)
        }
    }
    @IBAction func buttonBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: - load gif

func loadGif(_ name: String) -> UIImage {
    if let gifURL = Bundle.main.url(forResource: name, withExtension: "gif"),
        let gifData = try? Data(contentsOf: gifURL),
        let source = CGImageSourceCreateWithData(gifData as CFData, nil) {
        let imageCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []

        for i in 0..<imageCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }

        let animatedImage = UIImage.animatedImage(with: images, duration: TimeInterval(imageCount) * 0.1)
        
        return animatedImage!
    }
    let emptyImage = UIImage(systemName: "rain")
    return emptyImage!
}
