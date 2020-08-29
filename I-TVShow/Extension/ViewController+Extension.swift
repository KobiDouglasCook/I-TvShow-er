//
//  ViewController+Extension.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
}
