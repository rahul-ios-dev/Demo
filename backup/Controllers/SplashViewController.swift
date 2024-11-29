//
//  SplashViewController.swift
//  backup
//
//  Created by Rahul Acharya on 29/11/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var onCollection: UICollectionView!
    var counter: Int = 0  // Variable to track current page
    var onboardData: [OnboardModel] = [
        OnboardModel(title: "Welcome to Duplicate Backup",
                     image: UIImage(named: "onImg1")!,
                     description: "Get monthly money tips and stay on top of your finances"),
        OnboardModel(title: "Understand your financial habits",
                     image: UIImage(named: "onImg2")!,
                     description: "Analyze your finance with beautiful, simple and easy to understand."),
        OnboardModel(title: "Make your spending stress-free",
                     image: UIImage(named: "onImg3")!,
                     description: "You can follow me if you wantand comment on any to get some freebies"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = onboardData.count
        pageControl.currentPage = 0
        onCollection.delegate = self
        onCollection.dataSource = self
        onCollection.register(UINib(nibName: "OnBoardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnBoardCollectionViewCell")
        
        if #available(iOS 11.0, *) {
            onCollection.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        // Increment counter to go to next page
        if counter < onboardData.count - 1 {
            counter += 1
            let indexPath = IndexPath(item: counter,
                                      section: 0)
            onCollection.scrollToItem(at: indexPath,
                                      at: .centeredHorizontally,
                                      animated: true)
            pageControl.currentPage = counter
        } else {
            if let secondVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                navigationController?.pushViewController(secondVC, animated: true)
            }
            print("Last page reached!")
        }
    }
}

extension SplashViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardCollectionViewCell", for: indexPath) as? OnBoardCollectionViewCell else { return UICollectionViewCell() }
        cell.setupConfig(with: onboardData[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width,
                      height: collectionView.bounds.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        pageControl.currentPage = currentPage
        counter = currentPage
        
        if currentPage == 0 {
            self.view.backgroundColor = ThemeColor.on1.getColor
        } else {
            self.view.backgroundColor = ThemeColor.on3.getColor
        }
    }
}

struct OnboardModel {
    let title: String
    let image: UIImage
    let description: String
}
