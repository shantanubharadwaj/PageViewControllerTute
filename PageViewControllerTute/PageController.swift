//
//  PageController.swift
//  PageViewControllerTute
//
//  Created by Shantanu Dutta on 08/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var pageDataInfo: PageDataInfo!
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        textLabel.text = pageDataInfo.labelText
        view.backgroundColor = pageDataInfo.color
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
