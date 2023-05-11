//
//  ViewController.swift
//  PageView
//
//  Created by apple on 10/02/23.
//

import UIKit

class ViewController: UIViewController {
    private let scrolView = UIScrollView()



    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .systemFill
        return pageControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrolView.delegate =  self
        pageControl.addTarget(self,
                                     action: #selector(pageControlDidChange(_:)),
                              for: .valueChanged)
        scrolView.backgroundColor = .red
        view.addSubview(scrolView)
        view.addSubview(pageControl)

    }
    @objc private func pageControlDidChange(_ sender:UIPageControl){
        let current =  sender.currentPage
        scrolView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)

    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 100, y: view.frame.size.height - 100, width: view.frame.size.width - 200, height: 20)
        scrolView.frame = CGRect (x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 0)
        if scrolView.subviews.count == 2 {
            configureScrollView()
        }

    }

    private func configureScrollView() {
        scrolView.contentSize = CGSize(width: view.frame.size.width*5, height: scrolView.frame.size.height)
        scrolView.isPagingEnabled = true
        let colors:[UIColor] = [
            .systemRed,
            .systemGray,
            .systemGreen,
            .systemOrange,
            .systemPink
        ]
        for x in 0..<5 {
            let page = UIView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrolView.frame.size.height))
            page.backgroundColor = colors [x]
            scrolView.addSubview(page)

        }
    }




}
extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float( scrollView.frame.size.width)))
   }
}

