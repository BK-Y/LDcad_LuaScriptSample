local mAni = require("mAni")
function register()
    local ani = ldc.animation("AnimationTitle") 
    fps =  25
    ani:setFPS(fps)
    ani:setLength(14)
    ani:setEvent('start','onStart')
    ani:setEvent('frame','onFrame')
end	
    
function onStart()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)
    
    mAni.hideAll(mainSF)
end

function onFrame()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)
    local cnt = ani:getFrameNr()
    local i = 0

    if(cnt < 10) then
        mAni.getRef(mainSF,"17141.dat"):setVisible(true)
    elseif(cnt < 16) then
        mainRef = mainSF:getRef("15462.dat")
        if (cnt == 10) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,-100,0)
        else
            mAni.move(mainRef,0,20,0)
        end
    elseif( cnt < 22) then
        mainRef = mainSF:getRef("4716.dat")
        if (cnt == 16) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 28) then
        mainRef = mainSF:getRef("43093.dat",1)
        if (cnt == 22) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 34) then
        mainRef = mainSF:getRef("59443.dat",1)
        if (cnt == 28) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 40) then
        mainRef = mainSF:getRef("43093.dat",2)
        if (cnt == 34) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 46) then
        mainSF:getRef("axle.ldr",1):setVisible(true)
        mAni.getRef(mainSF,"axle.ldr",1,"32123b.dat",1):setVisible(false)
        mainRef = mAni.getRef(mainSF,"axle.ldr",1,"3706.dat",1)
        if (cnt == 40) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 52) then
        mainRef = mAni.getRef(mainSF,"axle.ldr",1,"32123b.dat",1)
        if (cnt == 46) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 58) then
        mainRef = mainSF:getRef("16615.dat")
        if (cnt == 52) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 64) then
        mainRef = mainSF:getRef("24316.dat")
        if (cnt == 58) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,-100,0)
        else
            mAni.move(mainRef,0,20,0)
        end
    elseif( cnt < 70) then
        for i = 1,2 do
            mainRef = mainSF:getRef("10928.dat",i)
            if (cnt == 64) then
                mainRef:setVisible(true)
                mAni.move(mainRef,0,100,0)
            else
                mAni.move(mainRef,0,-20,0)
            end
        end
    elseif( cnt < 76) then
        mainRef = mainSF:getRef("33299b.dat")
        if (cnt == 70) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    elseif( cnt < 82) then
        mainRef = mainSF:getRef("15555.dat")
        if (cnt == 76) then
            mainRef:setVisible(true)
            mAni.move(mainRef,0,100,0)
        else
            mAni.move(mainRef,0,-20,0)
        end
    else
        local table = {"Group 1","Group 2"}
        local speed = 32 
        --方向控制
        if(cnt<150 )then 
            speed = 32
        elseif((cnt-150)%170<85) then
            speed = -32 
        else 
            speed = 32
        end
        --核心运动部分
        --按组group组织的转动部分
        for i= 1, 2 do
            local grp = mainSF:getGroup(table[i])
            local mat = grp:getOri()
            mat:mulRotateBA((i-1.5)*speed,mAni.ori_x)
            grp:setOri(mat)
        end
        --平动部分
        mainRef = mainSF:getRef("axle.ldr")
        mAni.move(mainRef,0,-speed/92,0)

    end
end
    
register()