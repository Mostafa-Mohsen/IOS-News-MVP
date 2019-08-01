//
//  NewsTableViewCell.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
