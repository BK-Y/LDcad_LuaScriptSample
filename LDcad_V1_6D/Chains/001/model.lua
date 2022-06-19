local mAni = require("mAni")
function register()
    local ani = ldc.animation("AnimationTitle") 
    fps =  25
    ani:setFPS(fps)
    ani:setLength(12)
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
    local map = {}
    local speed = 1
    local tmpOri = mainRef:getOri()
    if(cnt == 0) then 
        for i = 1, 5 do 
            mainSF:getRef(i):setVisible(true)
        end
        mAni.move(mainSF:getRef(1),-110,0,0)
        mAni.move(mainSF:getRef(5),110,0,0)
    elseif(cnt < 11) then
        mAni.move(mainSF:getRef(1),22-2*cnt,0,0)
        mAni.move(mainSF:getRef(5),2*cnt-22,0,0)
    else
        --Main Animation
        if(cnt == 11) then 
            mainSF:getRef("chains.ldr"):setVisible(true)--show the chains
            mainSF:getRef("24505.dat"):setVisible(true) --show the gear
        end
        if(cnt < 62) then
            speed = 2
        elseif((cnt-62)%124<62) then
            speed = -2
        else 
            speed = 2
        end
        mainRef = mainSF:getRef("chains.ldr")
        mAni.move(mainRef,0,0,0.825*speed)
        mainRef = mainSF:getGroup("Group 1")
        mAni.rotate(mainRef,-1.5*speed,mAni.ori_z)

        --assemble animation
        if(cnt < 62) then
            --单独显示轴，无需动画
        elseif(cnt < 66) then
            mainRef = mainSF:getGroup("Group 1"):getRef("3706.dat")
            if(cnt == 62) then 
                mainRef:setVisible(true)
            end
        elseif(cnt < 77) then
            for i = 1, 2 do
                mainRef = mainSF:getGroup("Group 1"):getRef("6590.dat",i)
                mAni.move(mainRef,(cnt-76)*(1.5-i)*5,0,0)
                if (cnt == 66)then
                    mainRef:setVisible(true)
                    --显示轴和中间的轴套
                    mainRef = mainSF:getRef("3706.dat")
                    mainRef:setVisible(true)
                    mainRef = mainSF:getRef("6590.dat",2)
                    mainRef:setVisible(true)
                end
                mainRef = mainSF:getRef("3673.dat",i)
                mAni.move(mainRef,(cnt-76)*(i-1.5)*2,0,0)
                if (cnt == 66)then
                    mAni.move(mainRef,110*(i-1.5),0,0)
                    mainRef:setVisible(true)
                end
                --黑销
                mainRef = mainSF:getRef("4459.dat",i)
                mAni.move(mainRef,(cnt-76)*(1.5-i)*2,0,0)
                if (cnt == 66)then
                    mAni.move(mainRef,110*(1.5-i),0,0)
                    mainRef:setVisible(true)
                end
                --前轴上的轴套
                map = {4,5}
                mainRef = mainSF:getRef("6590.dat",map[i])
                mAni.move(mainRef,(cnt-76)*(1.5-i)*2,0,0)
                if (cnt == 66)then
                    mAni.move(mainRef,110*(1.5-i),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 88) then
            for i = 1, 2 do
                mainRef = mainSF:getRef("32526.dat",i)
                mAni.move(mainRef,(cnt-87)*(1.5-i)*2,0,0)
                if (cnt == 77)then
                    mAni.move(mainRef,110*(1.5-i),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 96) then
            for i = 1, 2 do
                mainRef = mainSF:getRef("43857.dat",i)
                mAni.move(mainRef,(cnt-95)*(1.5-i)*2,0,0)
                if (cnt == 87)then
                    mAni.move(mainRef,110*(1.5-i),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 101) then
            for i = 1, 2 do
                mainRef = mainSF:getRef("43857.dat",i)
                mAni.move(mainRef,(cnt-100)*(i - 1.5)*2,0,0)
                if (cnt == 96)then
                    mAni.move(mainRef,124*(i-1.5),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 113) then
            for i = 1, 2 do
                mainRef = mainSF:getRef("32123a.dat",i)
                mAni.move(mainRef,(cnt-112)*(i - 1.5)*2,0,0)
                if (cnt == 101)then
                    mAni.move(mainRef,132*(i-1.5),0,0)
                    mainRef:setVisible(true)
                end
            end
            for i = 1, 2 do
                mainRef = mainSF:getRef("32054.dat",i)
                mAni.move(mainRef,(cnt-112)*(1.5-i)*2,0,0)
                if (cnt == 101)then
                    mAni.move(mainRef,132*(1.5-i),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 125) then
            for i = 1, 2 do
                mainRef = mainSF:getRef("rubberband.ldr",i)
                mAni.move(mainRef,(cnt-124)*(i - 1.5)*2,0,0)
                if (cnt == 113)then
                    mAni.move(mainRef,132*(i-1.5),0,0)
                    mainRef:setVisible(true)
                end
            end
        elseif(cnt < 136) then
            mainRef = mainSF:getRef("33299b.dat")
            mAni.move(mainRef,-cnt+135,0,0)
            if (cnt == 125)then
                mAni.move(mainRef,66,0,0)
                mainRef:setVisible(true)
            end
        elseif(cnt < 147) then
            mainRef = mainSF:getRef("15555.dat")
            mAni.move(mainRef,-cnt+146,0,0)
            if (cnt == 136)then
                mAni.move(mainRef,66,0,0)
                mainRef:setVisible(true)
            end
        end
        --mAni.move(mainSF:getRef("chains.ldr"))
    end
end
register()