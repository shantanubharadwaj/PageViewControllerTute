//
//  ViewController.swift
//  PageViewControllerTute
//
//  Created by Shantanu Dutta on 08/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var currentIndex = 0
    
    let infoArr = [
        PageDataInfo(labelText: "Screen 1", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), index: 0),
        PageDataInfo(labelText: "Screen 2", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), index: 1),
        PageDataInfo(labelText: "Screen 3", color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), index: 2),
        PageDataInfo(labelText: "Screen 4", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), index: 3),
        PageDataInfo(labelText: "Screen 5", color: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), index: 4),
        PageDataInfo(labelText: "Screen 6", color: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), index: 5),
        PageDataInfo(labelText: "Screen 7", color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), index: 6)
    ]
    
    private lazy var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController.view.backgroundColor = UIColor.clear
        pageController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return pageController
    }()
    
    let swipeToPreviouslabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "<- Swipe to Previous Page"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let swipeToNextlabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Swipe to Next Page ->"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let randomButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Random", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.addTarget(self, action: #selector(handleRandomClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPageVC()
        configureLabel()
        configureButton()
    }
    
    func configureButton() {
        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            randomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            randomButton.bottomAnchor.constraint(equalTo: swipeToNextlabel.bottomAnchor, constant: -40)
        ])
    }
    
    func configureLabel() {
        view.addSubview(swipeToNextlabel)
        view.addSubview(swipeToPreviouslabel)
        NSLayoutConstraint.activate([
            swipeToNextlabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            swipeToNextlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            swipeToPreviouslabel.firstBaselineAnchor.constraint(equalTo: swipeToNextlabel.firstBaselineAnchor),
            swipeToPreviouslabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            swipeToPreviouslabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        swipeToPreviouslabel.isHidden = true
    }
    
    @objc func handleRandomClick() {
        let randomIndex = Int.random(in: 0..<infoArr.count)
        var navDirection = UIPageViewController.NavigationDirection.forward
        if randomIndex < currentIndex {
            navDirection = .reverse
        }
        
        let controller = pageViewcontroller(at: randomIndex) ?? PageController()
        pageController.setViewControllers([controller], direction: navDirection, animated: true, completion: nil)
    }

    private func setupPageVC() {
        pageController.delegate = self
        pageController.dataSource = self
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        
        let controller = pageViewcontroller(at: 0) ?? PageController()
        pageController.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }

    func pageViewcontroller(at index: Int) -> PageController? {
        if index < 0 || infoArr.count <= index {
            return nil
        }
        let controller = PageController()
        controller.pageDataInfo = infoArr[index]
        currentIndex = index
        animateLabel(for: index)
        return controller
    }
    
    func animateLabel(for index: Int)  {
        UIView.animate(withDuration: 0.5) {
            DispatchQueue.main.async {
                self.swipeToNextlabel.isHidden = ((index + 1) == self.infoArr.count) ? true : false
                self.swipeToPreviouslabel.isHidden = (index  == 0) ? true : false
            }
        }
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! PageController).pageDataInfo.index
        
        return pageViewcontroller(at: index - 1)
//        guard currentIndex != 0 else {
//            return nil
//        }
//        let controller = PageController()
//        controller.pageDataInfo = infoArr[currentIndex - 1]
//        currentIndex -= 1
//        return controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! PageController).pageDataInfo.index
        
        return pageViewcontroller(at: index + 1)
//        guard (currentIndex + 1) != infoArr.count else {
//            return nil
//        }
//        let controller = PageController()
//        controller.pageDataInfo = infoArr[currentIndex + 1]
//        currentIndex += 1
//        return controller
    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return infoArr.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return currentIndex
//    }
}
