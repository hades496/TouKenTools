TOTALPOS = 17
WAITETIME = 10000
DELTAX = 0
DELTAY = 0
HWND = 0
age = 0 					//出阵时代
stage = 0 					// 出阵战场
CheckPointX = 0 			//检查点坐标
CheckPointY = 0
TotalFight = 0 				//累计战斗次数 
TotalTouKen = 0 			//累计捞刀
TempClickX = 0 				//上次点击坐标
TempClickY = 0
SizeX = 0 					//窗口大小 
SizeY = 0

CheckPointName = array("本丸","出阵准备","地图选择","出阵确认","大地图","阵型选择","战斗结算","出阵前刀装缺失","刀装","大阪城重复通关","新刀发现","新刀发现","大阪城首次通关","新刀发现","新刀发现","远征结束","远征界面")

FileRoot = main.FileRootBox.Path


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
TroopsChooseY = 500
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

ExTeamX = 230 //远征队伍按钮
ExTeamY = array(array(66, 88, 110), array(88, 66, 110), array(88, 110, 66))
ExReturnX = 735 
ExReturnY = 65


ExCount = array(0, 0, 0)
ExSuccessCount = array(0, 0, 0)


//------------------------------远征UI参数------------------------------//


//------------------------------编队UI参数------------------------------//
EquipReturnX = 326 //更换刀装后返回
EquipReturnY = 552
EquipButtonX = array(745, 745, 745, 745, 745, 745) 	//六把刀的按钮
EquipButtonY = array(131, 208, 285, 362, 439, 516)
AddButtonX = array(540, 540, 540)					//添加刀装按钮
AddButtonY = array(186, 224, 262)
EquipChangeX = array(317, 317, 317, 317, 317, 317) 	//六个刀装按钮
EquipChangeY = array(489, 411, 333, 255, 177, 99)
//------------------------------编队UI参数------------------------------//

Sub Init//初始化设置
	PutToList "开始初始化"
	Call Plugin.RegDll.Reg(FileRoot&"\dm.dll")//调用大漠插件，在按键精灵中使用 
	Set dm = createobject("dm.dmsoft")//用大漠插件创建一个对象dm 
	dm_ret = dm.SetPath(FileRoot)// 设置全局路径，以后你找图用的图片都默认是test目录里的图片了，否则你要用绝对路径d:\test\1.bmp来该表示图片  
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
	PutToList "窗口大小："&Cstr(SizeX)&"*"&Cstr(SizeY)
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

Sub ABClick(intX, intY)
	dm.MoveTo intX, intY
	dm.LeftClick 
	Delay 1000
End Sub


Function GetNowPos//获取当前状态
	PutToList "正在获取当前状态..."
	GetNowPos = 0
	intX = - 1 
	intY = - 1 
	i = 0
	While intX < 0 and intY < 0
		For i = 0 To TOTALPOS - 1
			dm.FindPic 0, 0, SizeX, SizeY, "CheckPoint" & Cstr(i) & ".bmp", 000000, 0.9, dir, intX, intY
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

Function FindAndClick(image, offsetX, offsetY, left, top, right, down)//寻找并点击image : string
	intX = - 1 
	intY = - 1 
	PutToList "开始查找"&image
	//FindPic 0, 0, 1920, 1080, "Attachment:\" & image, 0.9, intX, intY
	dm.FindPic left, top, right, down, image, 000000, 0.9, dir, intX, intY
	If intX >= 0 and intY >= 0 Then 
		Delay 1000
		PutToList "恭喜，已找到" & image
		//dm.MoveTo intX - DELTAX, intY - DELTAY
		dm.MoveTo intX + offsetX, intY + offsetY
		dm.LeftClick
		//Plugin.Bkgnd.LeftClick HWND, intX - DELTAX , intY - DELTAY
		FindAndClick = 1
	Else 
		PutToList "抱歉，没有找到"&image
		FindAndClick = 0
	End If
End Function

Sub GoExpedition(ExAge, ExStage, ExTeam)
	ABClick ExAgeX(ExAge), ExAgeY(ExAge)
	ABClick ExStageX(ExStage), ExStageY(ExStage)
	ABClick ExGoX, ExGoY
	ABClick ExTeamX, ExTeamY(0)(0)
	Delay 1000
	For i = 2 To 4
		If dm.FindPic(0, 0, SizeX, SizeY, "GoExTeam" & Cstr(i) & ".bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
			ABClick ExTeamX, ExTeamY(i-2)(ExTeam)
			Exit For
		End If
	Next
	ABClick ExGoX, ExGoY	
End Sub


Function PictureCheck(image)//确认某图片是否存在
	If dm.FindPic(0, 0, SizeX, SizeY, image, 000000, 0.9, dir, intX, intY) <> - 1  Then 
		PictureCheck = 1
	Else 
		PictureCheck = 0
	End If
End Function


//------------------------------主程序入口------------------------------//
Init //初始化设置
nowStep = 0
nowPos = -1
While True
	tempPos = GetNowPos()//获取当前状态
	//If tempPos = nowPos and nowPos <> 6 and nowPos <> 4 Then 
	If false Then 
		Delay 1000
	Else 
		nowPos = tempPos
		Select Case nowPos
			Case 0 //处在本丸
				nowStep = 0				
				ABClick BianDuiX, BianDuiY
			Case 1//处在出阵图
				TracePrint "main.InExpedition2.Value = " & Cstr(main.InExpedition2.Value)
				TracePrint "main.ExTeam2.Value = " & Cstr(main.ExTeam2.Value)
				//ExitScript
				If main.InExpedition2.Value = 0 and main.ExTeam2.Value = 1 Then 
					ABClick ExpeditionX, ExpeditionY
				Else if main.InExpedition3.Value = 0 and main.ExTeam3.Value = 1 then 
					ABClick ExpeditionX, ExpeditionY
				else if main.InExpedition4.Value = 0 and main.ExTeam4.Value = 1 Then 
					ABClick ExpeditionX, ExpeditionY
				Else
					ABClick ChuZhenPicX, ChuZhenPicY
				End If
				End If
				End If
				
				
			Case 2//处在时代选择
				If firstFlag = 0 Then 
					firstFlag = 1
					age = main.AgeList.ListIndex //获取时代
					PutToList "获取到时代"
					stage = main.StageList.ListIndex//获取战场
					PutToList "获取到战场"
					For i = 1 To 4
					 	ABClick LeftArrowX, LeftArrowY
					Next
					PerPage = 4
					If main.EventCheck.Value  Then 
						PerPage = 2
					End If
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
			Case 3 //处在出阵确认
				ABClick LeaveX,LeaveY
			Case 4 //处在大地图
				ABClick 300, 300
			Case 5//处在阵型选择
				formation = main.FormationList.ListIndex//获取阵型
				PutToList "获取到默认阵型"
				If formation = 6 Then 
					i = 0
					For i = 0 To 5
						PutToList dm.GetColor(FormationX(i), FormationY(i))
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
			Case 6//处在结算界面
				targetStep = main.StepList.ListIndex//获取前进次数
				//PutToList "获取到前进次数"
				If main.PreBossCheck Then 
					If PictureCheck("ProBoss" & Cstr(age) & "-" & Cstr(Stage) & ".bmp") Then 
						PutToList "接近王点，返回本丸"
						ABClick FightReturnX, FightReturnY
					End If	
				Else				
					If nowStep = targetStep and targetStep>0 Then 
						PutToList "返回本丸"
						ABClick FightReturnX, FightReturnY
					Else 
						PutToList "继续行军"
						ABClick FightContinueX, FightContinueY
					End If
				End If
			Case 8//补充刀装
				Delay 2000
				For i = 0 To 5
					//TracePrint dm.GetColor(EquipButtonX(i), EquipButtonY(i))
					If dm.CmpColor(EquipButtonX(i), EquipButtonY(i), "D60000", 0.90) = 0 Then 
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
				ABClick ChuZhenX, ChuZhenY
			Case 10,11,13,14 //发现刀剑
				ABClick 300, 300
				Delay 2000
				TotalTouKen = TotalTouKen + 1
				PutToList "发现刀剑"
				main.TouKenNum.Caption = Cstr(TotalTouKen) & "把"
				ABClick 300, 300
			Case 9//千两箱重复通关
				If main.OusakaLoop.Value Then 
					Click 80, - 160 //继续	
				Else 
					Click 300, - 160 //返回
				End If
			Case 12//千两箱首次通关
				If main.OusakaLoop.Value Then 
					Click 80, - 160 //继续	
				Else 
					Click 300, - 160 //返回
				End If
			Case 15//远征结束
				Delay 3000
				If dm.FindPic(0 ,0 ,SizeX, SizeY, "ExTeam2.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
					main.InExpedition2.Value = 0
					If dm.FindPic(0, 0, SizeX, SizeY, "ExSuccess.bmp|ExSuperSuccess.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
						ExSuccessCount(0) = ExSuccessCount(0) + 1
					End If
					ExCount(0) = ExCount(0) + 1
					main.ExCount2.Caption = Cstr(ExSuccessCount(0))&"/"&Cstr(ExCount(0))
					ABClick 300, 300
				End If
				If dm.FindPic(0 ,0 ,SizeX, SizeY, "ExTeam3.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
					main.InExpedition3.Value = 0
					If dm.FindPic(0, 0, SizeX, SizeY, "ExSuccess.bmp|ExSuperSuccess.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
						ExSuccessCount(1) = ExSuccessCount(1) + 1
					End If
					ExCount(1) = ExCount(1) + 1
					main.ExCount3.Caption = Cstr(ExSuccessCount(1))&"/"&Cstr(ExCount(1))
					ABClick 300, 300
				End If
				If dm.FindPic(0 ,0 ,SizeX, SizeY, "ExTeam4.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
					main.InExpedition4.Value = 0
					If dm.FindPic(0, 0, SizeX, SizeY, "ExSuccess.bmp|ExSuperSuccess.bmp", 000000, 0.9, dir, intX, intY) <> - 1  Then 
						ExSuccessCount(2) = ExSuccessCount(2) + 1
					End If
					ExCount(2) = ExCount(2) + 1
					main.ExCount4.Caption = Cstr(ExSuccessCount(2))&"/"&Cstr(ExCount(2))
					ABClick 300, 300
				End If
			Case 16//开始远征
				If main.InExpedition2.Value = 0 and main.ExTeam2.Value = 1 Then 
					GoExpedition main.ExAge2.ListIndex, main.ExStage2.ListIndex, 0
					
					main.InExpedition2.Value = 1
				Else If main.InExpedition3.Value = 0 and main.ExTeam3.Value = 1 Then 
					GoExpedition main.ExAge3.ListIndex, main.ExStage3.ListIndex, 1
	
					main.InExpedition3.Value = 1
				Else If main.InExpedition4.Value = 0 and main.ExTeam4.Value = 1 Then 
					GoExpedition main.ExAge4.ListIndex, main.ExStage4.ListIndex, 2

					main.InExpedition4.Value = 1
				End If
				End If
				End If

				ABClick ExReturnX, ExReturnY
				
		End Select
	End If
Wend
//------------------------------主程序结束------------------------------//


Sub PutToList(str)
	str = Cstr(Now) & " " & str
	If main.LogList.ListCount > 7 Then 
		main.LogList.RemoveItem 0
	End If
	main.LogList.AddItem str
	TracePrint str
	Call Plugin.Bkgnd.KeyPress(main.LogList.Hwnd, 40)
End Sub

Event main.PreBossCheck.Click
	If main.PreBossCheck.Value Then 
		main.PreBossCheck.Value = 0
		main.StepList.Enabled = 1
	Else 
		main.PreBossCheck.Value = 1
		main.StepList.Enabled = 0	
	End If
	
End Event
