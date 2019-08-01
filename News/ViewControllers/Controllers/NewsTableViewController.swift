//
//  NewsTableViewController.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit
import SDWebImage
import PopupDialog
import CountryPickerView
class NewsTableViewController: UITableViewController {

    private var news:[News] = []
    private var newsPresenter:INewsPresenter!
    private var refreshController:UIRefreshControl?
    
    @IBOutlet weak var countryCodeView: CountryPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsPresenter = NewsPresenter(newsView: self)
        self.countryCodeView.showPhoneCodeInView = false
        self.countryCodeView.delegate = self
        
        self.newsPresenter.getCountryCode()
        self.newsPresenter.getNews(refresh: false)
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshController = sender
        self.newsPresenter.getNews(refresh: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell

        cell.newsImage?.sd_setImage(with: URL(string: (self.news[indexPath.row].urlToImage)), placeholderImage: UIImage(named: "PlaceHolder"))
        cell.newsTitle.text = self.news[indexPath.row].title
        cell.newsDescription.text = self.news[indexPath.row].descriptions
        cell.newsAuthor.text = self.news[indexPath.row].author
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.news.count - 1)) && self.news.count > 5 {
            self.newsPresenter.getNews(refresh: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newsPresenter.openDialogDetails(new: self.news[indexPath.row])
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsTableViewController: INewsView{
    
    func renderNewsWithObjects(news: [News]) {
        self.news = self.news + news
        self.tableView.reloadData()
    }
    
    func resetNews(){
        self.news = []
    }
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let refreshControl = self.refreshController {
            if refreshControl.isRefreshing {
                self.refreshController?.endRefreshing()
            }
        }
    }
    
    func showErrorMessage(title:String ,errorMessage: String) {
        let alert = UIAlertController.init(title: title, message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openDialogDetails(new:News){
        let title = new.descriptions
        let message = ""
        let imageView :UIImageView? = UIImageView()
        imageView?.sd_setImage(with: URL(string: (new.urlToImage)), placeholderImage: UIImage(named: "PlaceHolder"))
        let popup = PopupDialog.init(title: title, message: message, image: imageView?.image, buttonAlignment: .vertical, transitionStyle: .fadeIn, preferredWidth: 340, tapGestureDismissal: true, panGestureDismissal: true, hideStatusBar: true, completion: nil)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func setCountryCode(countryCode:String) {
        self.countryCodeView.setCountryByCode(countryCode)
    }
}

extension NewsTableViewController: CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.newsPresenter.setCountryCode(countryCode: country.code)
        self.newsPresenter.getNews(refresh: false)
    }
}
