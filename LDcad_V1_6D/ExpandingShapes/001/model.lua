local mAni = require ("mAni")

function register()
    local ani = ldc.animation("AnimationTitle") 
    fps =  25
    ani:setFPS(fps)
    ani:setLength(15)
    ani:setEvent('start','onStart')
    ani:setEvent('frame','onFrame')
end	
    
function onStart()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)
    mAni.hideAll(mainSF)
    --mAni.hideAll(mAni.getRef(mainSF,'arm.ldr'):getSubfile())

    --显示底盘部分
    for i = 1, 6 do
        mAni.getRef(mainSF,i):setVisible(true)
    end
end

function run(subfile,ang)
    local oPos = ldc.vector(0,0,0) 
    local tPos = ldc.vector(0,0,0) 
    local refPos = ldc.vector(0,0,0)    --在参考坐标系里的位置
    local refXYZ = ldc.vector(0,0,0)    --参考坐标系原点
    local i
    for i = 1, 4 do
        refXYZ = mAni.getRef(subfile,"arm.ldr",i):getPos()
        oPos=mAni.getRef(subfile,"arm.ldr",i,1):getPos()
        -- print(i,'\n---------------------------------------')
        -- print(oPos)
        oPos:add(refXYZ)
        -- print('\t',oPos)
        tPos=mAni.getRef(subfile,"32526.dat",i):getPos()
        mAni.getRef(subfile,"32526.dat",i):setPos(mAni.transRotateZ(oPos,tPos,-ang))
    end
    mAni.refRotate(subfile,'Gear.ldr',1,4,ang,mAni.ori_z)
    mAni.refRotate(subfile,'arm.ldr',1,4,-ang,mAni.ori_z)
    mAni.refRotate(subfile,'4019.dat',1,4,-ang,mAni.ori_z)

end
    
function onFrame()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef('Gear.ldr',1)
    local subRef = mainRef
    local subSF = mainSF
    --Variables for camera
    local cam = ldc.camera()
	local camPos = ldc.vector()
	local camOri = ldc.vector()
	local camDist = 750

    local mat = mainRef:getPosOri()
    local vec = ldc.vector(0,0,0)
    local i = 0
    local cnt = ani:getFrameNr()
    

    if (cnt< 25) then
        --Camera Setting
        camPos:set(0,50,-70)
        camOri:set(0,135,0)
        camDist= 550
        cam:setThirdPerson(camPos,camDist,camOri:get())
        cam:apply(0)
    elseif(cnt < 35) then 
        for i = 1, 4 do
            mainRef = mAni.getRef(mainSF,'Gear.ldr',i)
            vec = mainRef:getPos()
            if(cnt == 25 ) then
                mainRef:setVisible(true)
                vec:setZ(vec:getZ()+54)
            else
                vec:setZ(vec:getZ()-6)
            end
            mainRef:setPos(vec)
        end
    elseif(cnt < 45) then
        for i = 1,4 do
            mainRef = mAni.getRef(mainSF,'arm.ldr',i)
            vec = mainRef:getPos()
            if(cnt == 35) then
                mainRef:setVisible(true)
                vec:setZ(vec:getZ()-45)
            else
                vec:setZ(vec:getZ()+5)
            end
            mainRef:setPos(vec)
        end
    elseif(cnt < 55) then
        for i = 1,4 do
            mainRef = mAni.getRef(mainSF,'4019.dat',i)
            vec = mainRef:getPos()
            if(cnt == 45) then
                mainRef:setVisible(true)
                vec:setZ(vec:getZ()+45)
            else
                vec:setZ(vec:getZ()-5)
            end
            mainRef:setPos(vec)
        end
    else
        --camera setting
        if (cnt <125 ) then 
        elseif(cnt<135) then
            camPos:set(0,50,-80)
            camOri:set(0,125-20*(cnt-125),0)
            camDist= 550
            cam:setThirdPerson(camPos,camDist,camOri:get())
            cam:apply(0)
        elseif(cnt<145) then --show 3 x 5 beam, id： 32526.dat
            for i = 1, 4 do
                mainRef = mAni.getRef(mainSF,"32526.dat",i)
                vec = mainRef:getPos()
                if(cnt == 135) then
                    mainRef:setVisible(true)
                    vec:setZ(vec:getZ()-54)
                else
                    vec:setZ(vec:getZ()+6)
                end
                mainRef:setPos(vec)
            end
        elseif(cnt<170) then
        elseif(cnt<180) then
            camPos:set(0,50-2*(cnt-170),-80-8*(cnt-170))
            camOri:set(0,-55+5*(cnt-170),0)
            camDist= 550
            cam:setThirdPerson(camPos,camDist,camOri:get())
            cam:apply(0)
        end
        --rotating 
        if(cnt < 115) then
            run(mainSF,2)
        elseif((cnt-115)%240 <120)then 
            run(mainSF,-2)
        else
            run(mainSF,2)
        end
    end
end
    
register()