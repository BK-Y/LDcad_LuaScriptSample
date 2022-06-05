local mAni = require ("mAni")
require ("math")
function register()
    local ani = ldc.animation("AnimationTitle") 
    fps =  25
    ani:setFPS(fps)
    ani:setLength(10)
    ani:setEvent('start','onStart')
    ani:setEvent('frame','onFrame')
end	
    
function onStart()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)
    mAni.hideAll(mainSF)
    mAni.hideAll(mAni.getRef(mainSF,2):getSubfile())
    mAni.getRef(mainSF,2):setVisible(true)
    mAni.getRef(mainSF,2,2):setVisible(true)
    mAni.getRef(mainSF,2,3):setVisible(true)
end
   
function onFrame()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)
    local subSF = ldc.subfile()
    local cnt = ani:getFrameNr()
    local loop_ref = {}
    local i = 0
    local pos = ldc.vector(0,0,0)
    local mat = mainRef:getPosOri()


    if(cnt < 11) then
        loop_ref[1] = 1
        loop_ref[2] = 4
        for i = 1, 2
        do
            mainRef=mAni.getRef(mainSF,2,loop_ref[i])
            pos = mainRef:getPos()
            if(cnt == 1) then
                pos:setY(pos:getY()+(i-1.5)*150)    --i 决定积木位置
                mainRef:setPos(pos)
                mainRef:setVisible(true)
            else
                pos:setY(pos:getY()-(i-1.5)*15)
                mainRef:setPos(pos)
            end
        end
    elseif(cnt < 22)then 
        loop_ref = {5,6,7,8}
        for i = 1, 4
        do
            mainRef=mAni.getRef(mainSF,2,loop_ref[i])
            pos = mainRef:getPos()
            if(cnt == 11) then
                pos:setY(pos:getY()+(i-2.5)/math.abs(i-2.5)*200)
                mainRef:setPos(pos)
                mainRef:setVisible(true)
            else
                pos:setY(pos:getY()-(i-2.5)/math.abs(i-2.5)*20)
                mainRef:setPos(pos)
            end
        end
    elseif(cnt < 28)then 
        mainRef=mAni.getRef(mainSF,2,9)
        pos = mainRef:getPos()
        if(cnt == 22) then
            pos:setY(pos:getY()-60)
            mainRef:setPos(pos)
            mainRef:setVisible(true)
        else
            pos:setY(pos:getY()+12)
            mainRef:setPos(pos)
        end
    elseif(cnt < 46)then
        mainRef=mAni.getRef(mainSF,2,10)
        subSF = mainRef:getSubfile()
        if(cnt == 28) then
            --设置积木可见
            mainRef:setVisible(true)
            --初始位置
            --整体位置
            pos = mainRef:getPos()
            pos:setZ(pos:getZ()+60)
            pos:setY(pos:getY()+60)
            mainRef:setPos(pos)
            --两根销的初始位置
            for i = 1, 2 do
                mainRef = mAni.getRef(subSF,i)
                pos = mainRef:getPos()
                pos:setY(pos:getY()+(i-1.5)*180)
                mainRef:setPos(pos)
            end
        elseif(cnt < 34) then
            for i = 1, 2 do
                mainRef = mAni.getRef(subSF,i)
                pos = mainRef:getPos()
                pos:setY(pos:getY()-(i-1.5)*20)
                mainRef:setPos(pos)
            end
        elseif(cnt < 40) then
            pos = mainRef:getPos()
            pos:setZ(pos:getZ()-10)
            mainRef:setPos(pos)
        else
            pos = mainRef:getPos()
            pos:setY(pos:getY()-10)
            mainRef:setPos(pos)
        end
    elseif(cnt <67)then
        mainRef=mAni.getRef(mainSF,3)
        subSF = mainRef:getSubfile()
        if(cnt == 46) then
            mainRef:setVisible(true)
            --设置位置
            pos = mainRef:getPos()
            pos:setY(pos:getY()+80)
            mainRef:setPos(pos)
            --设置轴上部件的位置
            for i = 2,4 do
                mainRef=subSF:getRef(i)
                pos = mainRef:getPos()
                pos:setY(pos:getY()+140)
                mainRef:setPos(pos)
            end
            for i = 5,6 do
                mAni.getRef(subSF,i):setVisible(false)
            end
        elseif(cnt<52) then
            mainRef = subSF:getRef(2)
            pos = mainRef:getPos()
            pos:setY(pos:getY()-28)
            mainRef:setPos(pos)
        elseif(cnt<57) then
            mainRef = subSF:getRef(3)
            pos = mainRef:getPos()
            pos:setY(pos:getY()-28)
            mainRef:setPos(pos)
        elseif(cnt<62) then
            mainRef = subSF:getRef(4)
            pos = mainRef:getPos()
            pos:setY(pos:getY()-28)
            mainRef:setPos(pos)
        else 
            pos = mainRef:getPos()
            pos:setY(pos:getY()-16)
            mainRef:setPos(pos)
        end
    elseif(cnt < 83)then
        mainRef=mAni.getRef(mainSF,1)
        mainRef:setVisible(true)
        subSF = mainRef:getSubfile()
        if(cnt == 67) then
            mAni.hideAll(subSF)
            pos = mainRef:getPos()
            pos:setY(pos:getY()+120)
            mainRef:setPos(pos)
        elseif (cnt < 73) then
            mainRef = subSF:getRef(1)
            mainRef:setVisible(true)
            pos = mainRef:getPos()
            pos:setY(pos:getY()-24)
            mainRef:setPos(pos)
        elseif(cnt < 78) then
            for i = 2,3 do
                mainRef = subSF:getRef(i)
                mainRef:setVisible(true)
                pos = mainRef:getPos()
                pos:setY(pos:getY()-24)
                mainRef:setPos(pos)
            end
        else 
            mainRef = subSF:getRef(4)
            mainRef:setVisible(true)
            pos = mainRef:getPos()
            pos:setY(pos:getY()-24)
            mainRef:setPos(pos)
        end
    elseif(cnt < 88) then
        mainRef=mAni.getRef(mainSF,2,11)
        mainRef:setVisible(true)
        if(cnt == 83) then
            pos = mainRef:getPos()
            pos:setY(pos:getY()+120)
            mainRef:setPos(pos)
        else
            pos = mainRef:getPos()
            pos:setY(pos:getY()-30)
            mainRef:setPos(pos)
        end
    elseif(cnt < 93) then
        mainRef=mAni.getRef(mainSF,3,5)
        mainRef:setVisible(true)
        if (cnt == 88) then
            pos = mainRef:getPos()
            pos:setY(pos:getY()+120)
            mainRef:setPos(pos)
        else
            pos = mainRef:getPos()
            pos:setY(pos:getY()-30)
            mainRef:setPos(pos)
        end
    elseif(cnt < 98) then
        mainRef=mAni.getRef(mainSF,3,6)
        mainRef:setVisible(true)
        if (cnt == 93) then
            pos = mainRef:getPos()
            pos:setY(pos:getY()+120)
            mainRef:setPos(pos)
        else
            pos = mainRef:getPos()
            pos:setY(pos:getY()-30)
            mainRef:setPos(pos)
        end
    elseif(cnt<175) then
        mainRef=mainSF:getRef(3)
        mat = mainRef:getOri()
        mat:mulRotateBA(-10,mAni.ori_y)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef(1)
        pos = mainRef:getPos()
        pos:setX(pos:getX()+1.8)
        mainRef:setPos(pos)
    else
        mainRef=mainSF:getRef(3)
        mat = mainRef:getOri()
        mat:mulRotateBA(10,mAni.ori_y)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef(1)
        pos = mainRef:getPos()
        pos:setX(pos:getX()-1.8)
        mainRef:setPos(pos)

    end
end
    
register()