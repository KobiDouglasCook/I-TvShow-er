//
//  ShowCell.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var premiereLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let identifier = String(describing: ShowCell.self)
    
    var show: Show? {
        didSet {
            guard let show = show else { return }
            let date = Date(fromString: show.premiered)
            let days = date?.diffInDays
            let premiereText = days == nil ? "Premiere Date Unavailable" : "Days Since Release: \(days!.addCommas!) days"
            nameLabel.text = show.name
            premiereLabel.text = premiereText
            summaryLabel.text = show.summary
            sharedCacheService.download(from: show.images.original) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.mainImage.image = image
                case .failure:
                    self.mainImage.backgroundColor = .lightGray
                }
            }
        }
    }
    
}
