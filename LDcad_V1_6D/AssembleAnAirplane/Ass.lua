function register()
	local ani = ldc.animation("build an airplane")
	fps = 25
	frmCnt=625
	ani:setFPS(fps)
	ani:setLength(frmCnt/fps)
	ani:setEvent('start','beforeBuild')
	ani:setEvent('frame','duringBuild')
end

function beforeBuild()
	local ani = ldc.animation:getCurrent()
	local mainSf = ldc.subfile()
	local lineCnt=mainSf:getRefCount()
	local loop
	build = {}
	build.pos={}
	build.stepLen = 3	--积木单次移动步长
	--隐藏所有积木，将积木位置存储到build表里
	for loop = 1 , lineCnt do
		mainSf:getRef(loop):setVisible(false)
		build.pos[loop]=mainSf:getRef(loop):getPos()
	end
	local cam = ldc.view():getCamera()
end

function duringBuild()
	--动画部分用变量
	local ani = ldc.animation:getCurrent()
	local mainSf = ldc.subfile()
	local frameNr = ani:getFrameNr()
	local pos_offset 		--计算偏移量使用
	local tmpPos = ldc.vector()
	--视图控制部分用变量
	local cam = ldc.camera()
	local camPos = ldc.vector()
	local camOri = ldc.vector()
	local camDist = 750

	if(frameNr < 15) then		--第一个积木
		--设定相机位置
		camPos:set(-114,105,-40)
		camOri:set(120,30,-0)
		camDist= 750
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)
		--动画部分
		mainSf:getRef(1):setVisible(true)
	elseif (frameNr < 35) then	--第二三个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(34-frameNr)
		--第二个积木
		tmpPos=build.pos[2]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[2]:getZ()+pos_offset)
		mainSf:getRef(2):setPos(tmpPos)
		--第三个积木
		tmpPos=build.pos[3]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[3]:getZ()+pos_offset)
		mainSf:getRef(3):setPos(tmpPos)
		--积木可见
		mainSf:getRef(2):setVisible(true)
		mainSf:getRef(3):setVisible(true)
	elseif (frameNr<50) then	--第四五个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(49-frameNr)
		--第4个积木
		tmpPos=build.pos[4]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[4]:getZ()+pos_offset)
		mainSf:getRef(4):setPos(tmpPos)
		--第5个积木
		tmpPos=build.pos[5]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[5]:getZ()-pos_offset)
		mainSf:getRef(5):setPos(tmpPos)
		--积木可见
		mainSf:getRef(4):setVisible(true)
		mainSf:getRef(5):setVisible(true)
	elseif (frameNr<65) then	--第六七个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(64-frameNr)
		--第4个积木
		tmpPos=build.pos[6]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[6]:getZ()-pos_offset)
		mainSf:getRef(6):setPos(tmpPos)
		--第5个积木
		tmpPos=build.pos[7]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[7]:getZ()+pos_offset)
		mainSf:getRef(7):setPos(tmpPos)
		--积木可见
		mainSf:getRef(6):setVisible(true)
		mainSf:getRef(7):setVisible(true)
	elseif (frameNr<80) then	--第八九个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(79-frameNr)
		--第八个积木
		tmpPos=build.pos[8]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[8]:getZ()+pos_offset)
		mainSf:getRef(8):setPos(tmpPos)
		--第9个积木
		tmpPos=build.pos[9]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[9]:getZ()-pos_offset)
		mainSf:getRef(9):setPos(tmpPos)
		--积木可见
		mainSf:getRef(8):setVisible(true)
		mainSf:getRef(9):setVisible(true)
	elseif (frameNr<95) then	--第10-13个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(94-frameNr)
		--第10个积木
		tmpPos=build.pos[10]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[10]:getZ()+pos_offset)
		mainSf:getRef(10):setPos(tmpPos)
		--第11个积木
		tmpPos=build.pos[11]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[11]:getZ()-pos_offset)
		mainSf:getRef(11):setPos(tmpPos)
		--第12个积木
		tmpPos=build.pos[12]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[12]:getZ()+pos_offset)
		mainSf:getRef(12):setPos(tmpPos)
		--第13个积木
		tmpPos=build.pos[13]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[13]:getZ()-pos_offset)
		mainSf:getRef(13):setPos(tmpPos)
		--积木可见
		mainSf:getRef(10):setVisible(true)
		mainSf:getRef(11):setVisible(true)
		mainSf:getRef(12):setVisible(true)
		mainSf:getRef(13):setVisible(true)
	elseif (frameNr < 110) then	--第14,15个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(109-frameNr)
		--第14个积木
		tmpPos=build.pos[14]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[14]:getZ()+pos_offset)
		mainSf:getRef(14):setPos(tmpPos)
		--第15个积木
		tmpPos=build.pos[15]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[15]:getZ()+pos_offset)
		mainSf:getRef(15):setPos(tmpPos)
		--积木可见
		mainSf:getRef(14):setVisible(true)
		mainSf:getRef(15):setVisible(true)
	elseif (frameNr < 125) then	--第16个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(124-frameNr)
		--第16个积木
		tmpPos=build.pos[16]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[16]:getZ()-pos_offset)
		mainSf:getRef(16):setPos(tmpPos)
		--积木可见
		mainSf:getRef(16):setVisible(true)
	elseif (frameNr<140) then	--第17-20个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(139-frameNr)
		--第17个积木
		tmpPos=build.pos[17]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[17]:getZ()+pos_offset)
		mainSf:getRef(17):setPos(tmpPos)
		--第18个积木
		tmpPos=build.pos[18]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[18]:getZ()+pos_offset)
		mainSf:getRef(18):setPos(tmpPos)
		--第19个积木
		tmpPos=build.pos[19]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[19]:getZ()+pos_offset)
		mainSf:getRef(19):setPos(tmpPos)
		--第20个积木
		tmpPos=build.pos[20]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[20]:getZ()+pos_offset)
		mainSf:getRef(20):setPos(tmpPos)
		--积木可见
		mainSf:getRef(17):setVisible(true)
		mainSf:getRef(18):setVisible(true)
		mainSf:getRef(19):setVisible(true)
		mainSf:getRef(20):setVisible(true)
	elseif (frameNr<155) then	--第21,22个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(154-frameNr)
		--第21个积木
		tmpPos=build.pos[21]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[21]:getZ()+pos_offset)
		mainSf:getRef(21):setPos(tmpPos)
		--第22个积木
		tmpPos=build.pos[22]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[22]:getZ()+pos_offset)
		mainSf:getRef(22):setPos(tmpPos)
		--积木可见
		mainSf:getRef(21):setVisible(true)
		mainSf:getRef(22):setVisible(true)
	elseif (frameNr<170) then	--第23个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(169-frameNr)
		--第23个积木
		tmpPos=build.pos[23]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[23]:getZ()+pos_offset)
		mainSf:getRef(23):setPos(tmpPos)
		--积木可见
		mainSf:getRef(23):setVisible(true)
	elseif(frameNr<180) then	--视图转换,10帧的时间
		--临时变量
		local pos_y,pos_z,ori_x,ori_y
		pos_offset = frameNr-171
		camPos:set(-114,105,-40)
		camOri:set(120,30,-0)

		--如何变化
		pos_y=camPos:getY()-6.5*pos_offset	--105->25
		pos_z=camPos:getZ()+5.5*pos_offset	--(-40) ->20
		ori_x=camOri:getX()-3*pos_offset---120->100
		ori_y=camOri:getY()-3*pos_offset	--(30-0)/10
		camDist= camDist + 5	--750->800
		--位置设定
		camPos:set(-114,pos_y,pos_z)
		camOri:set(ori_x,ori_y,0)
		
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)
	elseif (frameNr<195) then	--第24,25个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(194-frameNr)
		--第24个积木
		tmpPos=build.pos[24]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[24]:getZ()+pos_offset)
		mainSf:getRef(24):setPos(tmpPos)
		--第25个积木
		tmpPos=build.pos[25]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[25]:getZ()+pos_offset)
		mainSf:getRef(25):setPos(tmpPos)
		--积木可见
		mainSf:getRef(24):setVisible(true)
		mainSf:getRef(25):setVisible(true)
	elseif (frameNr<210) then	--第26个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(209-frameNr)
		--第26个积木
		tmpPos=build.pos[26]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[26]:getZ()-pos_offset)
		mainSf:getRef(26):setPos(tmpPos)
		--积木可见
		mainSf:getRef(26):setVisible(true)
	elseif (frameNr<218) then	--第27,28,29个积木1/4
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(225-frameNr)
		--第27个积木 1/2
		tmpPos=build.pos[27]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[27]:getZ()+pos_offset)
		mainSf:getRef(27):setPos(tmpPos)
		--积木可见
		mainSf:getRef(27):setVisible(true)
	elseif (frameNr<226) then	--第27,28,29个积木2/4
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(233-frameNr)
		--第28个积木1/2
		tmpPos=build.pos[28]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[28]:getZ()+pos_offset)
		mainSf:getRef(28):setPos(tmpPos)
		--积木可见
		mainSf:getRef(28):setVisible(true)
	elseif (frameNr<234) then	--第27,28,29个积木3/4
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(241-frameNr)
		--第29个积木1/2
		tmpPos=build.pos[29]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[29]:getZ()+pos_offset)
		mainSf:getRef(29):setPos(tmpPos)
		--积木可见
		mainSf:getRef(29):setVisible(true)
	elseif (frameNr<240) then
	elseif (frameNr<248) then	--第27,28,29个积木4/4
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(247-frameNr)
		--第27个积木2/2
		tmpPos=build.pos[27]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[27]:getZ()+pos_offset)
		mainSf:getRef(27):setPos(tmpPos)
		--第28个积木2/2
		tmpPos=build.pos[28]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[28]:getZ()+pos_offset)
		mainSf:getRef(28):setPos(tmpPos)
		--第29个积木2/2
		tmpPos=build.pos[29]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[29]:getZ()+pos_offset)
		mainSf:getRef(29):setPos(tmpPos)
	elseif (frameNr<250) then
	elseif (frameNr<265) then	--第30个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(264-frameNr)
		--第30个积木
		tmpPos=build.pos[30]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[30]:getZ()+pos_offset)
		mainSf:getRef(30):setPos(tmpPos)
		--积木可见
		mainSf:getRef(30):setVisible(true)
	elseif (frameNr<270) then
	elseif(frameNr<280) then --视图切换 10帧
		--临时变量
		local pos_x,pos_y,pos_z
		local ori_x,ori_y,ori_z
		pos_offset = frameNr-270
		camPos:set(-114,53,4)
		camOri:set(96,6,0)
		--坐标变化
		pos_x=camPos:getX()+4.5*pos_offset	--(-114)->(-90)
		pos_y=camPos:getY()-4.8*pos_offset	--53->5
		pos_z=camPos:getZ()+3.6*pos_offset	--(4) ->40

		ori_x=camOri:getX()+11.4*pos_offset -- 96->200
		ori_y=camOri:getY()+1.4*pos_offset	-- 6->20
		ori_z=camOri:getZ()-1*pos_offset	-- 0->-10
		camDist= camDist -15	--750->800
		--位置设定
		camPos:set(pos_x,pos_y,pos_z)
		camOri:set(ori_x,ori_y,ori_z)
		--	camPos:set(-90,5,40)
		--	camOri:set(200,20,-10)
		--	print(camPos:get())
		--	print(camOri:get())
		--应用
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)
	elseif (frameNr<285) then
	elseif (frameNr<300) then	--第32个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(299-frameNr)
		--第31个积木
		tmpPos=build.pos[31]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[31]:getZ()+pos_offset)
		mainSf:getRef(31):setPos(tmpPos)
		--第32个积木
		tmpPos=build.pos[32]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[32]:getZ()+pos_offset)
		mainSf:getRef(32):setPos(tmpPos)
		--积木可见
		mainSf:getRef(31):setVisible(true)
		mainSf:getRef(32):setVisible(true)
	elseif (frameNr<315) then	--第33个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(314-frameNr)
		--第33个积木
		tmpPos=build.pos[33]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[33]:getZ()-pos_offset)
		mainSf:getRef(33):setPos(tmpPos)
		--积木可见
		mainSf:getRef(33):setVisible(true)
	elseif (frameNr<330) then	--第34-37个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(329-frameNr)
		--第34个积木
		tmpPos=build.pos[34]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[34]:getZ()+pos_offset)
		mainSf:getRef(34):setPos(tmpPos)
		--第35个积木
		tmpPos=build.pos[35]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[35]:getZ()+pos_offset)
		mainSf:getRef(35):setPos(tmpPos)
		--第36个积木
		tmpPos=build.pos[36]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[36]:getZ()+pos_offset)
		mainSf:getRef(36):setPos(tmpPos)
		--第37个积木
		tmpPos=build.pos[37]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[37]:getZ()+pos_offset)
		mainSf:getRef(37):setPos(tmpPos)
		--积木可见
		mainSf:getRef(34):setVisible(true)
		mainSf:getRef(35):setVisible(true)
		mainSf:getRef(36):setVisible(true)
		mainSf:getRef(37):setVisible(true)
	elseif (frameNr<345) then	--第38,39个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(344-frameNr)
		--第38个积木
		tmpPos=build.pos[38]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[38]:getZ()+pos_offset)
		mainSf:getRef(38):setPos(tmpPos)
		--第39个积木
		tmpPos=build.pos[39]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[39]:getZ()+pos_offset)
		mainSf:getRef(39):setPos(tmpPos)
		--积木可见
		mainSf:getRef(38):setVisible(true)
		mainSf:getRef(39):setVisible(true)
	elseif (frameNr<360) then	--第40个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(359-frameNr)
		--第40个积木
		tmpPos=build.pos[40]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[40]:getZ()+pos_offset)
		mainSf:getRef(40):setPos(tmpPos)
		--积木可见
		mainSf:getRef(40):setVisible(true)
	elseif (frameNr<365) then
	elseif(frameNr<375) then --视图切换 10帧
		--临时变量
		local pos_x,pos_y,pos_z
		local ori_x,ori_y,ori_z
		pos_offset = frameNr-365
		camPos:set(-73.5,9.8,36.4)
		camOri:set(198.6,18.6,-9.0)
		--坐标变化
		pos_x=camPos:getX()-8*pos_offset	--(-114)->(-90)
		pos_y=camPos:getY()+4.8*pos_offset	--53->5
		pos_z=camPos:getZ()+0.5*pos_offset	--(4) ->40

		ori_x=camOri:getX()+3*pos_offset -- 96->200
		ori_y=camOri:getY()-4*pos_offset	-- 6->20
		ori_z=camOri:getZ()-0.5*pos_offset	-- 0->-10
		camDist= camDist - 30*pos_offset	--750->800
		--位置设定
		camPos:set(pos_x,pos_y,pos_z)
		camOri:set(ori_x,ori_y,ori_z)

		--	camPos:set(-160,50,40)
		--	camOri:set(230,-23,-15)
		--	print(camPos:get())
		--	print(camOri:get())
		--	print(camDist)
		--	camDist=550
		--应用
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)
	elseif (frameNr<400) then	--第41个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(399-frameNr)
		--第41个积木
		tmpPos=build.pos[41]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[41]:getZ()+pos_offset)
		mainSf:getRef(41):setPos(tmpPos)
		--第42个积木
		tmpPos=build.pos[42]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[42]:getZ()+pos_offset)
		mainSf:getRef(42):setPos(tmpPos)
		--积木可见
		mainSf:getRef(41):setVisible(true)
		mainSf:getRef(42):setVisible(true)
	elseif (frameNr<415) then	--第43个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(414-frameNr)
		--第43个积木 
		tmpPos=build.pos[43]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[43]:getZ()-pos_offset)
		mainSf:getRef(43):setPos(tmpPos)
		--积木可见
		mainSf:getRef(43):setVisible(true)
	elseif (frameNr<423) then	--第44,45个积木1/3
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(430-frameNr)
		--第43个积木 1/2
		tmpPos=build.pos[44]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[44]:getZ()+pos_offset)
		mainSf:getRef(44):setPos(tmpPos)
		--积木可见
		mainSf:getRef(44):setVisible(true)
	elseif (frameNr<431) then	--第44,45个积木2/3
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(438-frameNr)
		--第45个积木 1/2
		tmpPos=build.pos[45]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[45]:getZ()+pos_offset)
		mainSf:getRef(45):setPos(tmpPos)
		--积木可见
		mainSf:getRef(45):setVisible(true)
	elseif (frameNr<437) then	
	elseif (frameNr<445) then	--第44,45个积木3/3
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(444-frameNr)
		--第44个积木 2/2
		tmpPos=build.pos[44]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[44]:getZ()+pos_offset)
		mainSf:getRef(44):setPos(tmpPos)
		--第45个积木 2/2
		tmpPos=build.pos[45]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[45]:getZ()+pos_offset)
		mainSf:getRef(45):setPos(tmpPos)
	elseif (frameNr<460) then	--第46个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(459-frameNr)
		--第46个积木 
		tmpPos=build.pos[46]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[46]:getZ()+pos_offset)
		mainSf:getRef(46):setPos(tmpPos)
		--积木可见
		mainSf:getRef(46):setVisible(true)
	elseif (frameNr<475) then	--第47,48个积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(474-frameNr)
		--第47个积木 
		tmpPos=build.pos[47]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[47]:getZ()-pos_offset)
		mainSf:getRef(47):setPos(tmpPos)
		--第48个积木 
		tmpPos=build.pos[48]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[48]:getZ()+pos_offset)
		mainSf:getRef(48):setPos(tmpPos)
		--积木可见
		mainSf:getRef(47):setVisible(true)
		mainSf:getRef(48):setVisible(true)
	elseif (frameNr<500) then	--第49,50积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(499-frameNr)
		--第49个积木 
		tmpPos=build.pos[49]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[49]:getZ()+pos_offset)
		mainSf:getRef(49):setPos(tmpPos)
		--第50个积木 
		tmpPos=build.pos[50]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[50]:getZ()-pos_offset)
		mainSf:getRef(50):setPos(tmpPos)
		--积木可见
		mainSf:getRef(49):setVisible(true)
		mainSf:getRef(50):setVisible(true)
	elseif (frameNr<505) then
	elseif(frameNr<515) then --视图切换 10帧
		--临时变量
		local pos_x,pos_y,pos_z
		local ori_x,ori_y,ori_z
		pos_offset = frameNr-505
		camPos:set(-145.5,53.0,40.9)
		camOri:set(225.6,-17.4,-13.5)
		--坐标变化
		pos_x=camPos:getX()-15*pos_offset	--(-114)->(-90)
		pos_y=camPos:getY()+2*pos_offset	--53->5
		pos_z=camPos:getZ()-12*pos_offset	--(4) ->40

		ori_x=camOri:getX()-0.5*pos_offset -- 96->200
		ori_y=camOri:getY()+4*pos_offset	-- 6->20
		ori_z=camOri:getZ()+1*pos_offset	-- 0->-10
		camDist= camDist - 10*pos_offset	--750->800
		--位置设定
		camPos:set(pos_x,pos_y,pos_z)
		camOri:set(ori_x,ori_y,ori_z)

		--	camPos:set(-450,70,-80)
		--	camOri:set(160,23,-0)
		--	camDist=600
		--应用
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)
	elseif (frameNr<520) then
	elseif (frameNr<535) then	--第51,52积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(534-frameNr)
		--第51个积木 
		tmpPos=build.pos[51]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[51]:getZ()+pos_offset)
		mainSf:getRef(51):setPos(tmpPos)
		--第52个积木 
		tmpPos=build.pos[52]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[52]:getZ()+pos_offset)
		mainSf:getRef(52):setPos(tmpPos)
		--积木可见
		mainSf:getRef(51):setVisible(true)
		mainSf:getRef(52):setVisible(true)
	elseif (frameNr<550) then	--第53,54积木
		--准备工作
		build.stepLen=5	
		pos_offset = build.stepLen*(549-frameNr)
		--第53个积木 
		tmpPos=build.pos[53]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[53]:getZ()+pos_offset)
		mainSf:getRef(53):setPos(tmpPos)
		--第54个积木 
		tmpPos=build.pos[54]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[54]:getZ()-pos_offset)
		mainSf:getRef(54):setPos(tmpPos)
		--积木可见
		mainSf:getRef(53):setVisible(true)
		mainSf:getRef(54):setVisible(true)
	elseif (frameNr<565) then	--第55积木
		--准备工作
		build.stepLen=7	
		pos_offset = build.stepLen*(564-frameNr)
		--第55个积木 
		tmpPos=build.pos[55]:clone()
		local tmp_z = tmpPos:getZ()
		tmpPos:setZ(build.pos[55]:getZ()+pos_offset)
		mainSf:getRef(55):setPos(tmpPos)
		--积木可见
		mainSf:getRef(55):setVisible(true)
	elseif (frameNr<570) then
	elseif(frameNr<580) then --视图切换 10帧
		--临时变量
		local pos_x,pos_y,pos_z
		local ori_x,ori_y,ori_z
		pos_offset = frameNr-570
		camPos:set(-415.5,89.0,-175.1)
		camOri:set(216.6,54.6,4.5)
		--坐标变化
		pos_x=camPos:getX()+29*pos_offset	--(-114)->(-90)
		pos_y=camPos:getY()-pos_offset	--53->5
		pos_z=camPos:getZ()+9.5*pos_offset	--(4) ->40

		ori_x=camOri:getX()-6.5*pos_offset -- 96->200
		ori_y=camOri:getY()-2.3*pos_offset	-- 6->20
		ori_z=camOri:getZ()-0.45*pos_offset	-- 0->-10
		camDist= camDist + 40*pos_offset	--750->800

		--位置设定
		camPos:set(pos_x,pos_y,pos_z)
		camOri:set(ori_x,ori_y,ori_z)

		--	camPos:set(-135,70,-80)
		--	camOri:set(150,23,-0)
		--	camDist=1015
		--应用
		cam:setThirdPerson(camPos,camDist,camOri:get())
		cam:apply(0)

	
	end
end

register()