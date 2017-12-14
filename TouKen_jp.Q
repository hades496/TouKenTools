TOTALPOS = 15
WAITETIME = 10000
DELTAX = 0
DELTAY = 0
HWND = 0
age = 0 //出阵时代
stage = 0 // 出阵战场
CheckPointX = 0 //检查点坐标
CheckPointY = 0
TotalFight = 0 //累计战斗次数 
TotalTouKen = 0 //累计捞刀
TempClickX = 0 //上次点击坐标
TempClickY = 0
SizeX = 0 //窗口大小 
SizeY = 0
//------------------------------出阵UI参数------------------------------//
firstFlag = 0//首次出阵标记
AgePointX = array(205 , 320 ) //出阵时代按钮坐标
AgePointY = array(175, 180)
StagePointX = array(250 , 500, 250 , 500)//出阵战场按钮坐标
StagePointY = array(315, 315, 415, 415)
ExGoY = 460
BenWanX = 910				//主界面本丸按钮
BenWanY = 70
ChuZhenX = 910			 	//主界面出阵按钮
ChuZhenY = 110
BianDuiX = 910 				//主界面编队按钮
BianDuiY = 150
ChuZhenPicX = 460			//出阵标志
ChuZhenPicY = 190
LeftArrowX = 143			//时代选择左箭头
LeftArrowY = 175
RightArrowX = 377			//时代选择右箭头 
RightArrowY = 177
TroopsChooseX = 700 		//部队选择
TroopsChooseY = 485
LeaveX = 625 				//立刻出阵
LeaveY = 500
FormationX = array(109, 372, 633, 109, 372, 633)//阵型按钮坐标 
FormationY = array(95, 95, 95, 281, 281, 281)
FightContinueX = 595		//继续行军
FightContinueY = 425
FightReturnX = 815			//返回本丸
FightReturnY = 425
//------------------------------出阵UI参数------------------------------//

//------------------------------远征UI参数------------------------------//
ExAgePointX = array(175, 275, 375, 475) //远征时代按钮坐标
ExAgePointY = array(125, 125, 125, 125)
ExStagePointX = array(200, 200, 200, 200) //远征战场按钮坐标
ExStagePointY = array(225, 255, 285, 315)
ExGoX = 660//远征确认按钮
//------------------------------远征UI参数------------------------------//

//------------------------------编队UI参数------------------------------//
EquipReturnX = 326
EquipReturnY = 552
EquipButtonX = array(745, 745, 745, 745, 745, 745)
EquipButtonY = array(131, 208, 285, 362, 439, 516)
AddButtonX = array(540, 540, 540)
AddButtonY = array(186, 224, 262)
EquipChangeX = array(317, 317, 317, 317, 317, 317) 
EquipChangeY = array(489, 411, 333, 255, 177, 99)
//------------------------------编队UI参数------------------------------//



Sub Init//初始化设置
	PutToList "开始初始化"
	Call Plugin.RegDll.Reg("F:\TouKenTool\image_jp\dm.dll")//调用大漠插件，在按键精灵中使用 
	Set dm = createobject("dm.dmsoft")//用大漠插件创建一个对象dm 
	dm_ret = dm.SetPath("F:\TouKenTool\image_jp")// 设置全局路径，以后你找图用的图片都默认是test目录里的图片了，否则你要用绝对路径d:\test\1.bmp来该表示图片  
	dm_ret = dm.LoadPic("*.bmp")// 字面意思是加载test目录下的所有图片  
	//Hwnd = dm.GetPointWindow(zbx,zby)//用大漠软件获取给定坐标(zbx,zby)的窗口句柄,保存在Hwnd里  
	HWND = Plugin.Window.MousePoint()'得到鼠标所在位置的窗口句柄
	PutToList "获取到游戏窗口"&Cstr(HWND)
	Call Plugin.Window.Move(HWND, 0, 0)  // 把窗口移到屏幕的(0，0)，即左上角  
	dm_ret = dm.BindWindow(HWND,"gdi","windows","windows",0) //这句用来绑定辅助操作的对象窗口
	If dm_ret = 1 Then 
		PutToList "成功绑定大漠插件"
	Else 
		PutToList "绑定大漠插件失败，脚本退出"
		EndScript
	End If

	s = Plugin.Window.GetClientRect(HWND)//获取窗口坐标
	PutToList "获取到窗口坐标"
	XYArray = Split(s, "|", - 1 , 1)//窗口点击偏移
	DELTAX = XYArray(0)
	DELTAY = XYarray(1)
	PutToList Cstr(XYarray(0))&" "&Cstr(XYarray(1))&" "&Cstr(XYarray(2))&" "&Cstr(XYarray(3))
	PutToList "获取到全局偏移"
	age = main.AgeList.ListIndex //获取时代
	PutToList "获取到时代"
	stage = main.StageList.ListIndex//获取战场
	PutToList "获取到战场"
	targetStep = main.StepList.ListIndex//获取前进次数
	PutToList "获取到前进次数"
	formation = main.FormationList.ListIndex//获取阵型
	PutToList "获取到默认阵型"
	PutToList "初始化完毕"
End Sub



Function GetNowPos//获取当前状态
	PutToList "正在获取当前状态..."
	GetNowPos = 0
	intX = - 1 
	intY = - 1 
	i = 0
	While intX < 0 and intY < 0
		For i = 0 To TOTALPOS - 1
			dm.FindPic 0, 0, 1920, 1080, "CheckPoint" & Cstr(i) & ".bmp", 000000, 0.9, dir, intX, intY
			//FindPic 0, 0, 1024, 768, "Attachment:\CheckPoint" & Cstr(i) & ".bmp", 0.9, intX, intY
			If intX >= 0 and intY >= 0 Then 
				//CheckPointX = intX - DELTAX
				//CheckPointY = intY - DELTAY
				CheckPointX = intX
				CheckPointY = intY
				Exit For
			End If
		Next
		If intX < 0 and intY < 0 Then //点击空白处
			//ReClick
		End If
		//Delay 1000
	Wend
	GetNowPos = i
	PutToList "当前处在 " & CheckPointName(i)
	//PutToList "检查点坐标(" & Cstr(CheckPointX) & "," & Cstr(CheckPointY) & ")"
End Function

Function FindAndClick(image) //寻找并点击image : string
	intX = - 1 
	intY = - 1 
	PutToList "开始查找"&image
	//FindPic 0, 0, 1920, 1080, "Attachment:\" & image, 0.9, intX, intY
	dm.FindPic 0, 0, 1920, 1080, image, 000000, 0.9, dir, intX, intY
	If intX >= 0 and intY >= 0 Then 
		Delay 1000
		PutToList "恭喜，已找到" & image
		//dm.MoveTo intX - DELTAX, intY - DELTAY
		dm.MoveTo intX, intY
		dm.LeftClick
		//Plugin.Bkgnd.LeftClick HWND, intX - DELTAX , intY - DELTAY
		FindAndClick = 1
	Else 
		PutToList "抱歉，没有找到"&image
		FindAndClick = 0
	End If
End Function


Init //初始化设置
nowStep = 0
While True
	tempStep = GetNowPos()//获取当前状态
	If tempStep = nowPos and nowPos <> 6 Then 
		Delay 1000
	Else 
		nowPos = tempStep
		Select Case nowPos
			Case 0 //处在本丸
				nowStep = 0
				Click 882, 59
			Case 1 //处在出阵图
				Click 0 , 0
			Case 2//处在时代选择
				If firstFlag = 0 Then 
					firstFlag = 1
					age = main.AgeList.ListIndex //获取时代
					PutToList "获取到时代"
					stage = main.StageList.ListIndex//获取战场
					PutToList "获取到战场"
					While FindAndClick("LeftArrow.bmp")
					Wend
					For i = 1 To age/2
						FindAndClick ("RightArrow.bmp")
					Next
					PutToList "点击时代"
					Click AgePointX(age Mod 2), AgePointY(age Mod 2)
					PutToList "点击地区"
					Click StagePointX(stage), StagePointY(stage)					
				End If
				PutToList "点击出阵"
				Click 300, 460
			Case 3 //处在出阵确认
				Click 244, 445
			Case 4 //处在大地图
				Click 0, 0
			Case 5//处在阵型选择
				formation = main.FormationList.ListIndex//获取阵型				
				PutToList "获取到默认阵型"
				If formation = 6 Then 
					Delay 3000
					If FindAndClick("BestFormation.bmp") = 0
						Click FormationX(1), FormationY(1)
					End If
				Else
					Click FormationX(formation), FormationY(formation)
				End If
				
				nowStep = nowStep + 1
				TotalFight = TotalFight + 1
				main.TotalFight.Caption = Cstr(TotalFight) & "次"
				//PutToList "已经前进了" & Cstr(nowStep) & "次"
				//PutToList "已经战斗了" & Cstr(TotalFight) & "次"
				Delay 10000
			Case 6//处在结算界面
				targetStep = main.StepList.ListIndex//获取前进次数
				PutToList "获取到前进次数"
				If nowStep = targetStep and targetStep>0 Then 
					PutToList "返回本丸"
					nowStep = 0
					Click 400, 330
					Click 400, 400
				Else 
					PutToList "继续行军"
					Click 180, 330
					Click 180, 400
				End If
			Case 7 //出阵前刀装缺失
				Click 0, 0
			Case 8//补充刀装
				Delay 2000
				While FindAndClick("equipment.bmp")
					Delay 2000
					For Si = 0 To 2
						While FindAndClick(SpaceBlank(Si))
							For i = 0 To 5
								Delay 2000
								If FindAndClick(EquipList(i)) Then
									Exit For
								End If
							Next
							Delay 2000
							FindAndClick ("ChangeEquip.bmp")
							Delay 2000
						Wend
					Next
					Delay 2000
					FindAndClick ("ReturnButton.bmp")
					Delay 2000
				Wend
				Delay 2000
				FindAndClick ("Gohome.bmp")
			Case 9//千两箱重复通关
				If main.OusakaLoop.Value Then 
					Click 80, - 160 //继续	
				Else 
					Click 300, - 160 //返回
				End If
			Case 10,11,13,14 //发现刀剑
				Click 0, 0
				TotalTouKen = TotalTouKen + 1
				PutToList "发现刀剑"
				main.TouKenNum.Caption = Cstr(TotalTouKen) & "把"
			Case 12//千两箱首次通关
				If main.OusakaLoop.Value Then 
					Click 80, - 160 //继续	
				Else 
					Click 300, - 160 //返回
				End If
		End Select
	End If
Wend


Sub PutToList(str)
	str = Cstr(Now) & " " & str
	If main.LogList.ListCount > 7 Then 
		main.LogList.RemoveItem 0
	End If
	main.LogList.AddItem str
	TracePrint str
	Call Plugin.Bkgnd.KeyPress(main.LogList.Hwnd, 40)
End Sub
