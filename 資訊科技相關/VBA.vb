' Cells屬性 可以用來指定單一儲存格(Range物件), 但是沒有 Cell物件.

' Range屬性 也可以用來指定單一儲存格(Range物件), 有 Range物件.

Cells(row, column)

'第3列, 第2欄的值是"Excel"
Cells(3, 2).Value = "Excel"

Cells(3, "C").Value = "VBA"

' 存取目前和非目前使用中的目標

Range("A1").Value = "Current A1"

Debug.Print Worksheets(1).Name '存取目前工作表名稱

'? = Debug.Print 這個寫法(?)只有在 即時運算視窗內可以用...
? Worksheets(1).Name '存取目前工作表名稱

'指定目標
Worksheets("工作表2").Range("B2").Value = "我是B2格"

'同時開啟多個Workbook, 指定非當前Workbook
'要開啟其他的Workbook, 不然會出錯.
Workbooks("VBA-test2.xlsm").Worksheets(1).Range("A1:C5").Value = #2024/02/08#
Workbooks("VBA-test2.xlsm").Worksheets(1).Range("A1:A6").Value = 20

' 以當前目標或選擇中的目標為對象
ActiveCell '當前儲存格(單格)
Selection '選中的儲存格範圍(多格), 或選擇中的圖形
ActiveSheet '當前工作表
ActiveWorkbook '當前活頁簿
ActiveWindow '當前視窗

ActiveCell.Value = "我只有一格"
Selection.Value = "我有一群"

'注意: ActiveCell & Selection 很像, 但很不一樣.

'變數的使用方式
Sub Variable()

Dim foo as long 
foo = 10

foo = foo * 5
Debug.Print foo

End Sub

'用變數來處理物件
Sub ObjectVariable()

Range("A1:F6").ClearContents

Dim rng as Range 'Range是個物件
Set rng = Range("A1:C3") '指定物件到變數, 要加上 "SET" 關鍵字.. A1:C3這個範圍
rng.Value = "設定值"

End Sub

'常用的資料型態
Sub OftenUsed_DataType()

  Dim s as String '字串
  Dim i as Integer '小整數
  Dim l as Long '大整數
  Dim si as Single '小的小數
  Dim d as Double '大的小數
  Dim date as Date '日期
  dim b as boolean '布林
  dim o as object '任何物件
  dim v as Variant '任何值或物件
  dim ra as Range '特定物件(Range)
  dim wb as Workbook '特定物件(Workbook)
  dim ws as Worksheet '特定物件(Worksheet)

'VBA 無法同時 宣告資料型態 & 給值
  Dim s as String = "ABC" 'Error

'VBA 同時 宣告資料型態 & 給值的方法
  Dim ss as String: ss = "BBC"

'VBA 可以同時 宣告多個變數
  Dim s as String, l as Long

'VBA可以不宣告變數, 直接產生並使用變數(少用比較好)
  Dim num as Long
  num = 10
  nun = num * 5 'nun自動產生.
  Debug.Print "num的值=" , num '應該還是10

  '如何關閉此功能(VBA可以不宣告變數)
  'Option Explicit '模組開頭加上這句, 就須強制須宣告變數
End Sub

'變數給值(=)
Sub AssignValue()

  '其他語言的遞加, 遞減語法, 在VBA內都不適用
  '=Error===========
  'num++, num--
  'num += 10
  'num *= 5
  '=OK===========
  Dim num as Integer
  num = num + 1
  num = num -1
  num = num + 10
  num = num  * 5
  Let num = num *20 '給值要用 = & let, 只是Let都被省略了.

End Sub

'變數給物件(Set), 
Sub AssignObject()

  Dim rg = Range
  Set rg = Range("A1:C3")
  rg.Select

End Sub

'變數作用範圍, 原則上只有巨集內, 除非寫在巨集外
Sub macro1()
  Dim foo as String
  foo = "foo in macro1"
  Debug.Print foo
End Sub

Sub macro2()
  Dim foo as String
  foo = "foo in macro2"
  Debug.Print foo
End Sub

'讓值永遠保留下來的方式
'1.把值寫在工作表的儲存格內
'2.利用SaveSetting敘述 & GetSetting函數

'使用常數Const
Sub UseConst()
  Const tax as Double = 0.08
  Debug.Print "5000元消費稅(*0.08):", tax * 5000
End Sub

'注意: VBA變數是不分大小寫的.(VBA會自動偵側.更正,並提示錯誤)
'注意: 不能有同名的變數名稱,會出錯
Dim foo As String
Dim FOO As String

' 用來計算的算術運算子
Sub Calculate()
  Range("A1").Value = 5+2 ' + (7)
  Range("A2").Value = 5-2 ' - (3)
  Range("A3").Value = 5*2 ' * (10)
  Range("A4").Value = 5/2 ' / , (2.5)
  Range("A5").Value = 5\2 ' \ , 取商的整數部分(2)
  Range("A6").Value = 5 Mod 2 ' Mod, 取除法的餘數(1)
  Range("A7").Value = 5^2 ' ^, 取乘冪 5^2 = 5*5 = (25)
  Range("A8").Value = "5^2" & "結果是25" ' 字串連結可以用 & OR +, 使用+容易混淆
  Range("A9").Value = "5^2" + "結果是25" ' 字串連結可以用 & OR +, 使用+容易混淆
  Range("A10").Value = "5^2" + vbLf + "結果是25" ' vbLf, 在儲存格內換行.

' 用&運算子, 連接數值、日期時, 會自動將數值 & 日期轉換成字串.
  MsgBox "庫存量:" & 15

End Sub

'比較運算子
Sub CompareOperator()
  'VBA沒有 (==) 是否相等, 用的一樣是(=)
  ' 5=2 False
  ' 5 <> 2 True
  ' 5 < 2 False
  ' 5 <= 2 False
  ' 5 > 2 True
  ' 5 >= 2 True
  Range("E3").Value = 5 = 2
  Range("E4").Value = 5 <> 2
  Range("E5").Value = 5 < 2
  Range("E6").Value = 5 <= 2
  Range("E7").Value = 5 > 2
  Range("E8").Value = 5 >= 2

End Sub

' 物件間的比較(Is)
' ==>比較儲存格(Range物件)用IS運算子時, 要很小心(直接不要用)
' Range("A1") is Range("A1") 'False, 很奇怪吧.
' ==>若要確定是不是同一個儲存格, 請使用 Range("A1").Address = Range("A1").Address 比較保險

Sub CompareObject()
  
  MsgBox Worksheets(1) Is Worksheets("工作表1")

  'Nothing = 物件不存在的狀態
  If Cells.Find("VBA") Is Nothing Then
    Debug.Print "找不到值為VBA的儲存格"
  End If

End Sub

Sub LogicOperator

  'And 全為True
  'Or 部分為True即可
  'Not 反轉, True轉為False, False轉為True.

  Not Cells.Find("VBA") Is Nothing

  Range("B1").Value = Not Range("A1").Value = 7 'False

  Range("B2").Value = Range("A2").Value <> "" And IsNumeric(Range("A2").Value) 'True

  Range("B4").Value = Range("A4").Value = "VBA" Or Range("C4").Value = "VBA" 'True


End Sub

'If Else
Sub IfElse()
  
  If Range("A1").Value = 7 Then 
    Debug.Print "A1是" & 7
  Else
    Debug.Print "A1不是" & 7
  End If


End Sub

'For Next Loop(迴圈)
Sub ForNext()

  Dim i as Integer
  For i = 1 to 20
    Cells(i, 5).Value = "第 " & i & " 次處理"
  Next

End Sub

' 利用Step關鍵字, 指定迴圈計數器的方向與開隔
Sub ForNext_Step()
  dim i as Integer
  for i = 5 to 1 step -1
    Cells(i, 6).Value = "第 " & i & " 次處理"
  next 

End Sub

' 每隔三列畫底線, 這個做小計很好用..
Sub ForNext_Step2()
  dim i as Integer
  For i = 1 To 10 Step 3
    Range("B2:D2").Offset(i).Borders(xlEdgeBottom).LineStyle = xlContinuous
  Next

End Sub


' For Each Loop(迴圈)
Sub ForEach()
  dim rng as Range
  For Each rng in Range("F1:H10")
    rng.Value = rng.Value & " 先生.."
  Next

End Sub

'Array要放入Variant資料型態來
Sub ForEachArray()
  dim tmpList as Variant, tmp as Variant
  dim i as Integer

  '注意: For Each的索引變數, 只能用 Variant 或是 物物型態變數.

  tmplist = Array("台南","台北","台中", "台東", "台西")

  For Each tmp in tmplist
    'Cells(i,1).Value = tmp '不能這樣寫
    Debug.Print tmp
  Next

End Sub

'VBA沒有 "Continue" Statement, 跳過剩下的部分.
'如果要達成類似效果, 只能用 If 碰到特定值時, 跳過

'DoWhile
Sub DOWHILE()
  Do while ActiveCell.value <> ""
    ActiveCell.Next.value = "O"
    '使下方儲存格成為新的當前儲存格..
    ActiveCell.Offset(1).Select
  Loop
End Sub

'DOUntil
Sub DOUntil()
  Do Until ActiveCell.value <> ""
    ActiveCell.Next.value = "O"
    '使下方儲存格成為新的當前儲存格..
    ActiveCell.Offset(1).Select
  Loop
End Sub

'最少執行1次
Sub DOUntil2()
  Do 
    ActiveCell.Next.value = "O"
    '使下方儲存格成為新的當前儲存格..
    ActiveCell.Offset(1).Select
  Loop Until ActiveCell.value <> ""
End Sub

' 確認通過檢核後, 再執行巨集的作法 Exit Sub
Sub exitSub()
  If  Range("A1").Value <> "完成" Then
    MsgBox "請在儲存格(A1)輸入完成後,再執行巨集"
    Exit Sub
  End If

End Sub

' Select Case
Sub SelectCase()
  Select Case Range("A1").Value
    Case "編輯中"
      MsgBox "請輸入必要項目"

    Case "完成"
      MsgBox "將以輸入資料開始計算"

    Case Else
      MsgBox "A1值怪怪的, 請重新確認"

  End Select

End Sub

Sub SelectCase2()
  
  If Range("A1").Value = "" Then
        MsgBox "要輸入值, 才能執行"
        Exit Sub
  End If

  Select Case Range("A1").Value
    Case 1
      Debug.Print "儲存格(A1)是:" & 1
    Case Is < 5
      Debug.Print "儲存格(A1)是:小於 " & 5
    Case 6,8,10
      Debug.Print "儲存格(A1)是6 OR 8 OR 10"
    Case 11 TO 20
      Debug.Print "儲存格(A1)是11到20間"
    Case Else
      Debug.Print "儲存格(A1)值是:" & Range("A1").Value
  End Select

End Sub

'=與使用者對話======================

Sub 3-25() '巨集名稱不能用數字
  MsgBox "Hello 合庫證.."
End Sub

Sub sb325()
  MsgBox "Hello 合庫證.."
End Sub

'MsgBox用途(一), 會暫停巨集, 直到使用者確認
Sub sb326()
  MsgBox "想一下答案是多少??"
  Range("G3").Value = Range("C3").Value + Range("E3").Value
End Sub

'MsgBox用途(二), 詢問使用者, 取得二選一的回覆(vbMsgBoxResult)
Sub sb327()
  'MsgBox "問題", 按鈕類型(vbMsgBoxStyle), 標題
  Dim result as vbMsgBoxResult
  ' result = MsgBox("你比較愛貓嗎??", Buttons:= vbYesNo, "大烤問") 'ERROR, 用了名稱指定引數, 後面也要月名稱
  result = MsgBox("你比較愛貓嗎??", vbYesNo, "大烤問") 'OK
  If result = vbYes Then
    Debug.Print "我比較愛cat "
  Else
    Debug.Print "我比較愛dog "
  End If

End Sub

'InputBox用途, 供使用者輸入值
'變數 = InputBox("字串", "Title", "Default Value")

Sub sb328()
  Dim result as String
  result = InputBox("Please Input the name of this product...", _ 
                    "What do you want to buy?", "Envelop")
  Range("E5").Value = result
End Sub

'InputBox用途, 供使用者選擇儲存格範圍
'Dim rng as Range
'Set Range變數 = InputBox("字串", Type:=8)

Sub sb329()
  Dim indexRange as Range, selectedRange as Range
  Dim i as Integer
  Set selectedRange = Application.InputBox("Please select range", Type:=8)

  For Each indexRange In selectedRange
    i = i+1
    indexRange.value = "第" & i & "個."
  Next

End Sub

Sub sb330()
  Dim indexRange as Range, selectedRange as Range
  Dim i as Integer
  Set selectedRange = Application.InputBox("請選出你要點的餐", Type:=8)

  For Each indexRange In selectedRange
    indexRange.Next.Value = "O"
    '給下一格的值
  Next

End Sub

'收集使用者資訊的方式
'1.Application.InputBox(輸入方塊, 自選儲存格)
'2.MsgBox(訊息方塊.)
'3.Range(寫在儲存格)
'4.CustomForm(自訂表單)

Sub sb331()

'字串處理
Range("A1").Value = "VBA"
Range("A2").Value = "Excel" & vbLf & "VBA" '換行符號
Range("A3").Value = "Excel" & Chr(10) & "VBA" '換行符號
Range("A4").Value = "Excel" & vbCr & "VBA" '回車符號(CR), 回到字頁
Range("A5").Value = "Excel" & Chr(13) & "VBA" '回車符號
Range("A6").Value = "Excel" & vbCrLf & "VBA" '(CRLF)
Range("A7").Value = "Excel" & Chr(13) & Chr(10) & "VBA" '(CRLF)

Range("A8").Value = "Excel" & vbNewLine & "VBA" 'Windows & Mac上標準的換行符號
Range("A9").Value = "Excel" & Chr(13) & Chr(10) & "VBA" '(CRLF)
Range("A10").Value = "Excel" & Chr(10) & "VBA" '(CRLF)

Range("A11").Value = "Excel" & vbTab & "VBA" '(Tab)
Range("A12").Value = "Excel" & Chr(9) & "VBA" '(Tab)

End Sub

'取得字串資訊或substr的函數
Sub sb332()
  
  Range("A13").Value = LEN("VVBBAA") '計算字串字元數
  Range("A14").Value = InStr("abcccd", "588") '搜尋目標字串的位置(由前往後找), 找不到回傳0
  Range("A15").Value = InStrRev("abcccd", "ccc") '搜尋目標字串的位置(由後往前找)

End Sub

'取字串
Sub sb333()
  Range("A16").Value = Right("VVBBAA",2) 'AA
  Range("A17").Value = Left("abcccd", 3) 'abc
  Range("A18").Value = Mid("abcccd", 4,2) '第4個(含)

End Sub
