//
//  OnboardingVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 15.09.2022.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Başla", for: .normal)
            }else {
                nextBtn.setTitle("Sonraki", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [OnboardingSlide(title: "Lezzetli Yemekler", desciption: "Dünyanın dört bir yanındaki farklı kültürlerden çeşitli harika yemekleri deneyimleyin.", image: UIImage(named: "slide1")!),
                  OnboardingSlide(title: "Birinci Sınıf Şefler", desciption: "Yemeklerimiz sadece en iyiler tarafından hazırlanır.", image: UIImage(named: "slide2")!), OnboardingSlide(title: "Anında Dünya Çapında Teslimat", desciption: "Siparişleriniz, konumunuzdan bağımsız olarak anında teslim edilecektir.", image: UIImage(named: "slide3")!)]
        pageControl.numberOfPages = slides.count
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    @IBAction func btnNext(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "LoginVC") as! UIViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    

}
extension OnboardingVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let widht = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / widht)
    }
    
}
