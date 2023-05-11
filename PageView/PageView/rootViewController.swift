//
//  rootViewController.swift
//  PageView
//
//  Created by apple on 10/02/23.
//

import UIKit

class rootViewController: UIPageViewController {
    private let scrolView = UIScrollView()
    lazy var vcList:[UIViewController] = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let firstVC = storyboard.instantiateViewController(identifier: "FirstVC")
            let secondVC = storyboard.instantiateViewController(identifier: "SecondVC")
              
            return [firstVC, secondVC]
              
        }()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.backgroundColor = .systemFill
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
     //   scrolView.delegate =  self
        pageControl.addTarget(self,
                                     action: #selector(pageControlDidChange(_:)),
                              for: .valueChanged)
        view.addSubview(pageControl)
        
        self.dataSource = self as! UIPageViewControllerDataSource
                if let vc = vcList.first{
                    self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
                }
                  
            }
    
    @objc private func pageControlDidChange(_ sender:UIPageControl){
        
        let current =  sender.currentPage
         scrolView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 100, y: view.frame.size.height - 100, width: view.frame.size.width - 200, height: 20)
        
    }

        // Do any additional setup after loading the view.

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension rootViewController : UIPageViewControllerDataSource{
      
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.lastIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcList.count else {return nil}
        return vcList[previousIndex]
          
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = vcList.lastIndex(of: viewController) else { return nil }
        let previousIndex = index + 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcList.count else {return nil}
        return vcList[previousIndex]
  
  
    }
}
//extension rootViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float( scrollView.frame.size.width)))
//    }
//
//}
   
