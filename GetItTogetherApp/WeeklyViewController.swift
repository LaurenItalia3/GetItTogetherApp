import UIKit

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
   
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [Date]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        var current = CalenderHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalenderHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalenderHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalenderHelper().monthString(date: selectedDate)
        + " " + CalenderHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath)  as! CalenderCell
        
        let date = totalSquares[indexPath.item]
        cell.monthLabel.text = String(CalenderHelper().dayOfMonth(date: date))
        
        if(date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemGreen
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
    }
    
    @IBAction func previousWeek(_ sender: Any)
    {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: -7)
        setMonthView()
    }
    
    @IBAction func nextWeek(_ sender: Any)
    {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

