//-------------------------------全局参数-------------------------------//
TOTALPOS = 17
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
dir = 0
CheckPointName = array("本丸","出阵准备","地图选择","出阵确认","大地图","阵型选择","战斗结算","出阵前刀装缺失","刀装","大阪城重复通关","新刀发现","新刀发现","大阪城首次通关","新刀发现","新刀发现","远征结束","远征界面")
//-------------------------------全局参数-------------------------------//


//------------------------------出阵UI参数------------------------------//
firstFlag = 0//首次出阵标记
AgePointX = array(210 , 320, 430, 540) //出阵时代按钮坐标
AgePointY = array(175, 175, 175, 175)
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
ExpeditionX = 270 			//远征标志
ExpeditionY = 400
LeftArrowX = 143			//时代选择左箭头
LeftArrowY = 175
RightArrowX = 377//时代选择右箭头 
RightArrowY = 177
NormalRightArrowX = 600
NormalRightArrowY = 175

TroopsChooseX = 700 		//部队选择
TroopsChooseY = 520
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
ExAgeX = array(200, 300, 400, 500) //远征时代按钮坐标
ExAgeY = array(190, 190, 190, 190)
ExStageX = array(200, 200, 200, 200) //远征战场按钮坐标
ExStageY = array(290, 320, 350, 380)
ExGoX = 680//远征确认按钮
ExGoY = 520

ExTeamX = array(735, 735, 735) //远征队伍按钮
ExTeamY = array(240, 370, 500)
ExReturnX = 735 
ExReturnY = 65


ExCount = array(0, 0, 0)
ExSuccessCount = array(0, 0, 0)



//------------------------------远征UI参数------------------------------//

//------------------------------编队UI参数------------------------------//
EquipReturnX = 326
EquipReturnY = 552

EquipBlankX = array(500, 535, 570)
EquipBlankY = array(135, 212, 289, 366, 443, 520)

EquipButtonX = array(745, 745, 745, 745, 745, 745)
EquipButtonY = array(131, 208, 285, 362, 439, 516)
AddButtonX = array(540, 540, 540)
AddButtonY = array(186, 224, 262)
EquipChangeX = array(317, 317, 317, 317, 317, 317) 
EquipChangeY = array(489, 411, 333, 255, 177, 99)

CaptainX = 300
CaptainY = 110


//------------------------------主程序------------------------------//
Init //初始化设置
nowStep = 0
nowPos = -1
While True
	tempPos = GetNowPos()//获取当前状态
	//If tempPos = nowPos and nowPos <> 6 and nowPos <> 4 and nowPos <> 1 Then 
	If false Then 
		Delay 1000
	Else 
		nowPos = tempPos
		Select Case nowPos
			Case 0 //处在本丸
				本丸
			Case 1//处在出阵图
				出阵准备
			Case 2//处在时代选择
				出阵时代选择
			Case 3 //处在出阵确认
				出阵确认
			Case 4 //处在大地图
				地图前行
			Case 5//处在阵型选择
				阵型选择
			Case 6//处在结算界面
				战斗结算
			Case 8//补充刀装
				编队配置
			Case 10,11,13,14 //发现刀剑
				新刀发现
			Case 9//千两箱重复通关
				千两箱重复通关
			Case 12//千两箱首次通关
				千两箱首次通关
			Case 15//远征结束
				远征结算
			Case 16//开始远征
				远征开始
		End Select
	End If
Wend

//------------------------------出阵逻辑------------------------------//
Sub 本丸
	nowStep = 0				
	ABClick BianDuiX, BianDuiY
End Sub

Sub 出阵准备
	If main.InExpedition2.Value = 0 and main.ExTeam2.Value = 1 or main.InExpedition3.Value = 0 and main.ExTeam3.Value = 1 or main.InExpedition4.Value = 0 and main.ExTeam4.Value = 1 Then 
		ABClick ExpeditionX, ExpeditionY
	Else
		ABClick ChuZhenPicX, ChuZhenPicY
	End If
End Sub

Sub 出阵时代选择
	If firstFlag = 0 Then 
		firstFlag = 1
		age = main.AgeList.ListIndex //获取时代
		PutToList "获取到时代"
		stage = main.StageList.ListIndex//获取战场
		PutToList "获取到战场"
		PerPage = 4
		If main.EventCheck.Value  Then 
			PerPage = 2
		End If
		For i = 1 To 8 / PerPage - 1
			ABClick LeftArrowX, LeftArrowY
		Next
		For i = 1 To age / Perpage
			If main.EventCheck.Value Then  
				ABClick RightArrowX, RightArrowY
			Else 
				ABClick NormalRightArrowX, NormalRightArrowY
			End If
		Next
		PutToList "点击时代"
		ABClick AgePointX(age Mod PerPage), AgePointY(age Mod PerPage)
		PutToList "点击地区"
		ABClick StagePointX(stage), StagePointY(stage)					
	End If
	PutToList "点击部队选择"
	ABClick TroopsChooseX, TroopsChooseY
End Sub

Sub 出阵确认
	ABClick LeaveX,LeaveY
End Sub

Sub 地图前行
	ABClick 300, 300
	Delay 5000
End Sub

Sub 阵型选择
	formation = main.FormationList.ListIndex//获取阵型
	PutToList "获取到默认阵型"
	If formation = 6 Then 
		i = 0
		For i = 0 To 5
			If dm.CmpColor(FormationX(i), FormationY(i), "C50202-111111", 0.90) = 0 Then 
				ABClick FormationX(i), FormationY(i)
				Exit For
			End If
		Next
		If i > 5 Then 
			ABClick FormationX(1), FormationY(1)
		End If
	Else
		ABClick FormationX(formation), FormationY(formation)
	End If	
	nowStep = nowStep + 1
	TotalFight = TotalFight + 1
	main.TotalFight.Caption = Cstr(TotalFight) & "次"
	Delay 10000
End Sub

Sub 战斗结算
	If PictureCheck("SeriousInjury.bmp") Then 
		PutToList "重伤回城"
		ABClick FightReturnX, FightReturnY
	End If
			
	If main.PreBossCheck.value Then //不打王点
		If PictureCheck("PreBoss" & Cstr(main.AgeList.ListIndex + 1) & "-" & Cstr(main.StageList.ListIndex + 1) & ".bmp") Then 
			PutToList "接近王点，返回本丸"
			ABClick FightReturnX, FightReturnY
		Else 
			PutToList "未抵达王点，继续行军"
			ABClick FightContinueX, FightContinueY
		End If
	Else //步数检查
		targetStep = main.StepList.ListIndex//获取前进次数
		//PutToList "获取到前进次数"
		If nowStep = targetStep and targetStep>0 Then 
			PutToList "返回本丸"
			ABClick FightReturnX, FightReturnY
		Else 
			PutToList "继续行军"
			ABClick FightContinueX, FightContinueY
		End If
	End If
End Sub

Sub 新刀发现
	TotalTouKen = TotalTouKen + 1
	PutToList "发现刀剑"
	main.TouKenNum.Caption = Cstr(TotalTouKen) & "把"
	ABClick 300, 300
	Delay 500
	ABClick 300, 300
	Delay 500
	ABClick 300, 300
End Sub

Event main.PreBossCheck.Click //是否判断王点
	If main.PreBossCheck.Value Then 
		main.StepList.Enabled = 0
	Else 
		main.StepList.Enabled = 1
	End If
End Event

Sub 千两箱重复通关
	If main.OusakaLoop.Value Then 
		Click 80, - 160 //继续	
	Else 
		Click 300, - 160 //返回
	End If
End Sub

Sub 千两箱首次通关
	If main.OusakaLoop.Value Then 
		Click 80, - 160 //继续	
	Else 
		Click 300, - 160 //返回
	End If	
End Sub


//------------------------------编队逻辑------------------------------//
Sub 编队配置
	Delay 2000
	//补充刀装
	For i = 0 To 5
		For j = 0 To 2
			If dm.CmpColor(EquipBlankX(j), EquipBlankY(i), "FFFFFF", 0.90) = 0 Then 
				Exit For
			End If
		Next
		If (j < 3) Then 
			ABClick EquipButtonX(i), EquipButtonY(i)
			For j = 0 To 2
				If dm.CmpColor(AddButtonX(j), AddButtonY(j), "FFFFFF", 0.90) = 0 Then 
					ABClick AddButtonX(j), AddButtonY(j)
					For k = 0 To 5
						If dm.CmpColor(EquipChangeX(k), EquipChangeY(k), "F3F3F3", 0.90) = 0 Then 
							Exit For
						End If
					Next
					If k > 5 Then 
						PutToList "刀装已用完！"
						ExitScript
					End If
					ABClick EquipChangeX(k), EquipChangeY(k)
					ABClick EquipChangeX(k), EquipChangeY(k)
					Delay 2000
				End If
			Next
			ABClick EquipReturnX, EquipReturnY
			Delay 2000
		End If
	Next
	Delay 2000
	//调整队长
	CaptainAdjust			
	ABClick ChuZhenX, ChuZhenY
End Sub

Sub CaptainAdjust  //调整队长
	intX = - 1 
	intY = - 1 
	If dm.FindPic(0, 0, SizeX, SizeY, "CryFace.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
		dm.MoveTo intX, intY
		Delay 50
		dm.LeftDown 
		Delay 50
		While intY <> CaptainY
			intY = intY - 1
			dm.MoveTo intX, intY
			Delay 3
		Wend
		dm.LeftUp 
		Exit Sub
	End If
	If dm.FindPic(0, 0, SizeX, SizeY, "WorryFace.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
		dm.MoveTo intX, intY
		Delay 50
		dm.LeftDown 
		Delay 50
		While intY <> CaptainY
			intY = intY - 1
			dm.MoveTo intX, intY
			Delay 3
		Wend
		dm.LeftUp 
		Exit Sub
	End If
End Sub


//------------------------------远征逻辑------------------------------//
Sub 远征结算
	If PictureCheck("ExTeam2.bmp") Then 
		main.InExpedition2.Value = 0
		If PictureCheck("ExSuccess.bmp|ExSuperSuccess.bmp") Then 
			ExSuccessCount(0) = ExSuccessCount(0) + 1
		End If
		ExCount(0) = ExCount(0) + 1
		main.ExCount2.Caption = Cstr(ExSuccessCount(0))&"/"&Cstr(ExCount(0))
		ABClick 300, 300
	End If
	If PictureCheck("ExTeam3.bmp") Then 
		main.InExpedition3.Value = 0
		If PictureCheck("ExSuccess.bmp|ExSuperSuccess.bmp") Then 
			ExSuccessCount(1) = ExSuccessCount(1) + 1
		End If
		ExCount(1) = ExCount(1) + 1
		main.ExCount3.Caption = Cstr(ExSuccessCount(1))&"/"&Cstr(ExCount(1))
		ABClick 300, 300
	End If
	If PictureCheck("ExTeam4.bmp") Then 
		main.InExpedition4.Value = 0
		If PictureCheck("ExSuccess.bmp|ExSuperSuccess.bmp") Then 
			ExSuccessCount(2) = ExSuccessCount(2) + 1
		End If
		ExCount(2) = ExCount(2) + 1
		main.ExCount4.Caption = Cstr(ExSuccessCount(2))&"/"&Cstr(ExCount(2))
		ABClick 300, 300
	End If
End Sub

Sub 远征开始
	If main.InExpedition2.Value = 0 and main.ExTeam2.Value = 1 Then 
		GoExpedition main.ExAge2.ListIndex, main.ExStage2.ListIndex, 0	
		main.InExpedition2.Value = 1
	Else 
		If main.InExpedition3.Value = 0 and main.ExTeam3.Value = 1 Then 
			GoExpedition main.ExAge3.ListIndex, main.ExStage3.ListIndex, 1
			main.InExpedition3.Value = 1
		Else 
			If main.InExpedition4.Value = 0 and main.ExTeam4.Value = 1 Then 
				GoExpedition main.ExAge4.ListIndex, main.ExStage4.ListIndex, 2
				main.InExpedition4.Value = 1
			End If
		End If
	End If
	ABClick ExReturnX, ExReturnY
End Sub

Sub GoExpedition(ExAge, ExStage, ExTeam)
	ABClick ExAgeX(ExAge), ExAgeY(ExAge)
	ABClick ExStageX(ExStage), ExStageY(ExStage)
	ABClick ExGoX, ExGoY
	ABClick ExTeamX(ExTeam), ExTeamY(ExTeam)
	ABClick ExGoX, ExGoY	
End Sub

//------------------------------初始化设定------------------------------//
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
	SizeX = XYArray(2) - XYArray(0)
	SizeY = XYArray(3) - XYArray(1)
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

Sub ABClick(intX, intY) // 左键单击（窗口内坐标）
	dm.MoveTo intX, intY
	dm.LeftClick 
	Delay 1000
End Sub


//------------------------------全局功能------------------------------//

Function PictureCheck(image)//确认某图片是否存在
	If dm.FindPic(0, 0, SizeX, SizeY, image, 000000, 0.9, dir, intX, intY) <> - 1  Then 
		PictureCheck = 1
	Else 
		PictureCheck = 0
	End If
End Function


Function GetNowPos//获取当前状态
	PutToList "正在获取当前状态..."
	GetNowPos = 0
	intX = - 1 
	intY = - 1 
	i = 0
	While intX < 0 and intY < 0
		For i = 0 To TOTALPOS - 1
			If PictureCheck("CheckPoint" & Cstr(i) & ".bmp") Then 
				Exit For
			End If
		Next
	Wend
	GetNowPos = i
	PutToList "当前处在 " & CheckPointName(i)
End Function

Sub PutToList(str)
	str = Cstr(Now) & " " & str
	/*
	If main.LogList.ListCount > 7 Then 
		main.LogList.RemoveItem 0
	End If
	*/
	main.LogList.AddItem str
	TracePrint str
	Call Plugin.Bkgnd.KeyPress(main.LogList.Hwnd, 40)
End Sub
