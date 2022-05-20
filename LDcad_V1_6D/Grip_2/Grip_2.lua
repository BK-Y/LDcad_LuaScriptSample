function register()
    local ani = ldc.animation("Grip") 
    fps =  25
    ani:setFPS(fps)
    ani:setLength(8.96)
    ani:setEvent('start','onStart')
    ani:setEvent('frame','onFrame')
end	
    
function onStart()
    --Global Varible
    axle_x = ldc.vector(1,0,0)
    axle_y = ldc.vector(0,1,0)
    axle_z = ldc.vector(0,0,1)

    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)

    -- Hide All
    local i = 1
    for i = 1, mainSF:getRefCount() 
    do
        mainRef = mainSF:getRef(i)
        mainRef:setVisible(false)
    end
    --Initial angle
    mainRef= mainSF:getRef("controller.ldr")
    local mat = mainRef:getOri()
    mat:mulRotateBA(-90,axle_y)
    mainRef:setOri(mat)

    mainRef = mainSF:getRef("clip.ldr",1)
    mat = mainRef:getOri()
    mat:mulRotateBA(-90,axle_z)
    mainRef:setOri(mat)

    mainRef = mainSF:getRef("clip.ldr",2)
    mat = mainRef:getOri()
    mat:mulRotateAB(90,axle_z)
    mainRef:setOri(mat)
end
    
function onFrame()
    local ani=ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef("controller.ldr")
    local tmpSF = ldc.subfile()
    local tmpRef = mainSF:getRef(1)
    local i

    local curFrame  =ani:getFrameNr()
    
    if(ani:getFrameNr()<25) then
        --set double bevel gear with 12 teeth visible
        tmpRef = mainSF:getRef("controller.ldr")
        tmpRef:setVisible(true)
        tmpSF = tmpRef:getSubfile()
        tmpRef = tmpSF:getRef(1)
        tmpRef:setVisible(false)
        
        --set bevel gear visible
        mainRef = mainSF:getRef('clip.ldr',2)
        mainRef:setVisible(true)
        tmpSF = mainRef:getSubfile()
        for i = 2, tmpSF:getRefCount()
        do
            tmpSF:getRef(i):setVisible(false)
        end
    elseif(ani:getFrameNr()<50) then
        --set connector visible
        mainRef = mainSF:getRef('87408.dat')
        mainRef:setVisible(true)
        --set axle animation
        tmpRef = mainSF:getRef("controller.ldr")
        tmpSF = tmpRef:getSubfile()
        tmpRef = tmpSF:getRef(1)
        tmpRef:setVisible(true)

        mainRef = mainSF:getRef('clip.ldr',2)
        tmpSF = mainRef:getSubfile()
        tmpRef = tmpSF:getRef('32062.dat')
        tmpRef:setVisible(true)
    elseif(ani:getFrameNr()<75) then
        --set another bevel gear visible
        mainRef = mainSF:getRef('clip.ldr',1)
        mainRef:setVisible(true)
        tmpSF = mainRef:getSubfile()
        for i = 3, tmpSF:getRefCount()
        do
            tmpSF:getRef(i):setVisible(false)
        end
    elseif(ani:getFrameNr()<100) then
        --set paul visible
        for i = 1, 2 do
            mainRef = mainSF:getRef('clip.ldr',1)
            tmpSF = mainRef:getSubfile()
            tmpSF:getRef(3):setVisible(true)
        end
    else 
        mainRef = mainSF:getRef('clip.ldr',1)
        tmpSF = mainRef:getSubfile()
        for i = 1, tmpSF:getRefCount()
        do
            tmpSF:getRef(i):setVisible(true)
        end
        mainRef = mainSF:getRef('clip.ldr',2)
        tmpSF = mainRef:getSubfile()
        for i = 1, tmpSF:getRefCount()
        do
            tmpSF:getRef(i):setVisible(true)
        end


    end
    if (ani:getFrameNr()<125) then
        mainRef= mainSF:getRef("controller.ldr")
        local mat = mainRef:getOri()
        mat:mulRotateBA(1,axle_y)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef("clip.ldr",1)
        mat = mainRef:getOri()
        mat:mulRotateBA(1,axle_z)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef("clip.ldr",2)
        mat = mainRef:getOri()
        mat:mulRotateAB(-1,axle_z)
        mainRef:setOri(mat)
    else
        local ang 
        if((ani:getFrameNr()-5)%60 <30) 
        then
            ang = -1
        else 
            ang = 1
        end

        mainRef= mainSF:getRef("controller.ldr")
        local mat = mainRef:getOri()
        mat:mulRotateBA(ang,axle_y)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef("clip.ldr",1)
        mat = mainRef:getOri()
        mat:mulRotateBA(ang,axle_z)
        mainRef:setOri(mat)

        mainRef = mainSF:getRef("clip.ldr",2)
        mat = mainRef:getOri()
        mat:mulRotateAB(0-ang,axle_z)
        mainRef:setOri(mat)
    end

end
    
register()