//
//  ViewController.swift
//  TechFetch
//
//  Created by Jason Park on 2/10/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
    

}

extension ViewController {
    
    func fetchArticles() {
        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=600327379ddc468db9d7a55a47e56599"
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String, let publishDate = articleFromJson["publishedAt"] as? String {
                
                            article.title = title
                            article.desc = desc
                            article.author = author
                            article.date = publishDate
                            article.url = url
                            article.imgUrl = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlString = url
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        task.resume()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.titleLabel.text = self.articles?[indexPath.item].title
        cell.descLabel.text = self.articles?[indexPath.item].desc
        cell.authorLabel.text = self.articles?[indexPath.item].author
        cell.dateLabel.text = self.articles?[indexPath.item].date
        cell.imgView?.downloadImage(from: (self.articles?[indexPath.item].imgUrl)!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wkVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WKWebviewViewController
        
        wkVC.url = self.articles?[indexPath.item].url
        
        self.present(wkVC, animated: true, completion: nil)
    }
    
    //Trying to create IBAction for Bar Button Item named "Source" from the main storyboard but xcode does not let me control-drag to create IBActions or even Outlets. 
    
    
}




















