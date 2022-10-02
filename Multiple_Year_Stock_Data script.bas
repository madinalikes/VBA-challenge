Attribute VB_Name = "Module1"
Sub multiYearStocks()

'Looping through multiple worksheets
For Each ws In Worksheets
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percent Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    ws.Cells(1, 17).Value = "Value"
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"
    
'Declaring variables calculate yearly total, percent change, and total volume by ticker
  Dim i As Long
  Dim Open_Price_Row As Long
  Dim tickerName As String
  Dim Open_Yearly_Price As Double
  Dim Total_Stock_Volume As Double
      Total_Stock_Volume = 0
  Dim Yearly_Change As Double
      Yearly_Change = 0
  Dim Yearly_Percent_Change As Double
  Dim Print_Row As Long
      Print_Row = 2
  Dim lastRow As Long
  
      lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
      Open_Price_Row = 2
      
'Getting the open value of the stock at the beginning of the year
  
       Open_Yearly_Price = ws.Cells(Open_Price_Row, 3).Value

'Looping through the work sheet starting at row 2

  For i = 2 To lastRow
  

'If the next ticker cell is not equal to the previous ticker cell then print the value in colomn "I"

    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
       tickerName = ws.Cells(i, 1).Value
       ws.Range("I" & Print_Row).Value = tickerName
       
'Calculating Yearly Change of stock price.
       Yearly_Change = (ws.Cells(i, 6).Value - Open_Yearly_Price)
        
       ws.Range("J" & Print_Row).Value = Yearly_Change
    
'Calculating percent change of yearly stock price
        Yearly_Percent_Change = (Yearly_Change / Open_Yearly_Price)
        ws.Range("K" & Print_Row).Value = Yearly_Percent_Change
        ws.Range("K" & Print_Row).Style = "Percent"
    
'Calculating Total Stock Volume
        Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
        ws.Range("L" & Print_Row).Value = Total_Stock_Volume
        
'Resetting the variable
        Print_Row = Print_Row + 1
        Yearly_Change = 0
        Total_Stock_Volume = 0
        Open_Yearly_Price = ws.Cells(i + 1, 3).Value
        
    Else
'Always add stock volume to the total
        Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
    End If
Next i

'Declaring variables for cell formatting
  Dim Year_Last_Row As Long

      Year_Last_Row = ws.Cells(Rows.Count, 10).End(xlUp).Row

'Adding Loop for cell formatting
For i = 2 To Year_Last_Row

'Adding Conditional for cell formatting
    If ws.Cells(i, 10).Value >= 0 Then
       ws.Cells(i, 10).Interior.ColorIndex = 4
    Else
        ws.Cells(i, 10).Interior.ColorIndex = 3
    End If
Next i
    
'Declaring variables to find max & min
  
  Dim Percent_Last_Row As Long
      Percent_Last_Row = ws.Cells(Rows.Count, 11).End(xlUp).Row
  Dim percent_max As Double
      percent_max = 0
  Dim percent_min As Double
      percent_min = 0

'Adding Loop for finding max & min
For i = 2 To Percent_Last_Row

'Add Conditional for max & min
    If percent_max < ws.Cells(i, 11).Value Then
        percent_max = ws.Cells(i, 11).Value
        ws.Cells(2, 17).Value = percent_max
        ws.Cells(2, 17).Style = "Percent"
        ws.Cells(2, 16).Value = ws.Cells(i, 9).Value
    ElseIf percent_min > ws.Cells(i, 11).Value Then
        percent_min = ws.Cells(i, 11).Value
        ws.Cells(3, 17).Value = percent_min
        ws.Cells(3, 17).Style = "Percent"
        ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
    End If
Next i

'Declaring variable for greatest total volume

  Dim Total_Stock_Volume_Row As Long
      Total_Stock_Volume_Row = ws.Cells(Rows.Count, 12).End(xlUp).Row
  Dim Total_Stock_Volume_Row_Max As Double
      Total_Stock_Volume_Row_Max = 0

'Adding Loop for finding greatest total volume
 
 For i = 2 To Total_Stock_Volume_Row

'Adding Conditional for greatest total volume
    If Total_Stock_Volume_Row_Max < ws.Cells(i, 12).Value Then
       Total_Stock_Volume_Row_Max = ws.Cells(i, 12).Value
       ws.Cells(4, 17).Value = Total_Stock_Volume_Row_Max
       ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
       
    End If
Next i
    
Next ws

End Sub


