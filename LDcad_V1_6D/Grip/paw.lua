function register()
    local ani = ldc.animation("demo")
    fps = 29
    ani:setFPS(fps)
    ani:setLength(15)
    ani:setEvent("start","onStart")
    ani:setEvent("frame","onFrame")
end


function onStart()
    -- ldc objects
    local ani = ldc.animation()
    local mainSF=ldc.subfile()
    local subSF = ldc.subfile()
    local refL = mainSF:getRef(1)
    local grp = ldc.group()
    local mtx=ldc.matrix()
    -- basic rotate axle , ori_z is not needed in this case
    -- global
    WarmRotateAxle = ldc.vector(0,0,1)
    GearRotateAxle = ldc.vector(0,1,0)
    --key frame define
    keyFrm = {fps,fps*2+1,fps*2+5,fps*3+26,fps*5+4,fps*5+9,fps*5+14,fps*5+19,fps*5+24,fps*5+29,fps*6+5,fps*7+10,fps*7+15,ani:getFrameCount()}
        --0~key[1]: show the warm gear
        --key[1]~key[2]: add gear in Gear_2.ldr in 
        --key[2]~key[3]: plug axle to the gear, after this, rotate the gear
        --key[3]~ end : Rotate the gears
            --k[3]-k[4]: show rotating
            --key[4]-key[5]: show gear.ldr
            --key[5]-key[6]: show the frame part
            --k[6]-k[7]: show cross block (32184)
            --k[7]-k[8]: show trangle type 2 tech beam
            --k[8]-k[9]: show axle #2
            --k[9]-k[10]: show upper side trangle type 2 tech beam



    --tmp_variables
    local i 
    local tmp_pos = ldc.vector()

    --Set bricks' initial position/oritation
        --Gears, number ID: 24505
            --the gear was grouped into "Group 1"
            --The gear was a subfile of subfile gear.ldr
                grp:link('Group 2')
                mtx = grp:getPosOri()
                mtx:mulRotateBA(-80,GearRotateAxle)
                grp:setOri(mtx)

                grp:link('Group 3')
                local mtx=grp:getPosOri()
                mtx:mulRotateBA(80,GearRotateAxle)
                grp:setOri(mtx)
        -- tech beam(trangle type 2), part number:99776.dat
            -- The brick can be touched directly
            for i=1, 2 do
                refL = mainSF:getRef("99773.dat",i)
                tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()+3*sigma(keyFrm[8]-keyFrm[7]))
                refL:setPos(tmp_pos)
            end
            for i=3, 4 do
                refL = mainSF:getRef("99773.dat",i)
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()-3*sigma(keyFrm[10]-keyFrm[9]))
                refL:setPos(tmp_pos)
            end
        --Axle #2 (32062.dat)
            for i=1, 4 do
                refL = mainSF:getRef("32062.dat",i)
                tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()-4*sigma(keyFrm[9]-keyFrm[8]))
                refL:setPos(tmp_pos)
            end
        --position of Alxe in Gear_2.ldr
            refL=mainSF:getRef("Gear_2.ldr")
            subSF = refL:getSubfile()
            refL = subSF:getRef("3705.dat")
            vec = refL:getPos()
            vec:setY(vec:getY()-3*sigma(keyFrm[3]-keyFrm[2]))
            refL:setPos(vec)
        --position of Alxe in Gear_2.ldr
            refL=mainSF:getRef("warm_gear.ldr")
            subSF = refL:getSubfile()
            refL = subSF:getRef("3706.dat")
            vec = refL:getPos()
            vec:setX(vec:getX()+3*sigma(keyFrm[3]-keyFrm[2]))
            refL:setPos(vec)
        --cross block in warm_gear.ldr,32184.dat
            refL=mainSF:getRef("warm_gear.ldr")
            subSF = refL:getSubfile()
            refL = subSF:getRef(5)
            vec = refL:getPos()
            vec:setX(vec:getX()+5*sigma(keyFrm[7]-keyFrm[6]))
            refL:setPos(vec)

            refL=mainSF:getRef("warm_gear.ldr")
            subSF = refL:getSubfile()
            refL = subSF:getRef(6)
            vec = refL:getPos()
            vec:setX(vec:getX()-5*sigma(keyFrm[7]-keyFrm[6]))
            refL:setPos(vec)
            --liftarm (act as grip)
            for i=1, 2 do
                refL = mainSF:getRef("16616.dat",i)
                tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()-3*sigma(keyFrm[11]-keyFrm[10]))
                refL:setPos(tmp_pos)
            end
            for i=3, 4 do
                refL = mainSF:getRef("16616.dat",i)
                tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()+3*sigma(keyFrm[11]-keyFrm[10]))
                refL:setPos(tmp_pos)
            end
            --handler.ldr
            refL = mainSF:getRef("Handler.ldr")
            tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()+5*sigma(keyFrm[13]-keyFrm[12]))
            refL:setPos(tmp_pos)


    -- Set the visiblities of bricks
        -- Hide All
            local count
            mainSF = ldc.subfile()
            for count = 1, mainSF:getRefCount() do 
                mainSF:getRef(count):setVisible(false)
            end
end

function onFrame()
    local ani = ldc.animation:getCurrent()
    local mainSF = ldc.subfile()
    local subSF = ldc.subfile()
    local refL = mainSF:getRef(1)
    local grp = ldc.group()
    local matrix = ldc.matrix()
    local vec = ldc.vector()

    local frm = ani:getFrameNr()
    local i 

    --转动方向控制 config the rotating direction  of gears
    local left , right
    if(frm < 360)  then
        left = "Group 1"
        right = "Group 2"
        dir = 1
    elseif((frm + 15)%100 < 50)  then
        left = "Group 2"
        right = "Group 1"
        dir = -1
    else
        left = "Group 1"
        right = "Group 2"
        dir = 1
    end

    --Animation Parts
    if(frm <= keyFrm[1]) then
        --Show warm_gear
        mainSF:getRef("warm_gear.ldr"):setVisible(true)
        setAllRefInvisible("warm_gear.ldr")
        setRefVisible("warm_gear.ldr","4716.dat")
    elseif(frm <keyFrm[2]) then
        --show gear part number: 24505
        mainSF:getRef("Gear_2.ldr"):setVisible(true)
        setAllRefInvisible("Gear_2.ldr")
        setRefVisible("Gear_2.ldr","24505.dat")
    elseif(frm<keyFrm[3]) then
        --show axle in gears
        setRefVisible("Gear_2.ldr","3705.dat")
        --Plug the axle in Animation
        refL=mainSF:getRef("Gear_2.ldr")
        subSF = refL:getSubfile()
        refL = subSF:getRef("3705.dat")
        vec = refL:getPos()
        vec:setY(vec:getY()+3*(keyFrm[3]-frm))
        refL:setPos(vec)

        --show the axle in warm_gear.ldr
        setRefVisible("warm_gear.ldr","3706.dat")
        --plug the axle of warm gear
        refL=mainSF:getRef("warm_gear.ldr")
        subSF = refL:getSubfile()
        refL = subSF:getRef("3706.dat")
        vec = refL:getPos()
        vec:setX(vec:getX()-3*(keyFrm[3]-frm))
        refL:setPos(vec)
    else
        --rotating the system
        --Rotating will not stop until the end of the animation
        
        setRotateDirection(frm)
        --Gear_2.ldr which is in group 3
        grp:link("Group 3")
        matrix = grp:getPosOri()
        matrix:mulRotateBA(-1*dir,GearRotateAxle)
        grp:setOri(matrix)


        --gear.ldr's rotation
        grp:link("Group 2")
        matrix = grp:getPosOri()
        matrix:mulRotateBA(1*dir,GearRotateAxle)
        grp:setOri(matrix)

        --warm_gear's rotation
        --Related files are assigned to Group 1 in LDcad
        grp:link("Group 1")
        matrix = grp:getPosOri()
        matrix:mulRotateBA(-24*dir,WarmRotateAxle)
        grp:setOri(matrix)

        if(frm < keyFrm[4]) then
        elseif(frm <= keyFrm[5]) then
            mainSF:getRef("gear.ldr"):setVisible(true)
        elseif(frm<keyFrm[6]) then
            --1/2bush 1
            --get
            refL= mainSF:getRef("warm_gear.ldr")
            local subSF = refL:getSubfile()
            refL = subSF:getRef("32123a.dat",1)
            --set visible
            refL:setVisible(true)
            --animation
            local tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()-5*(keyFrm[6]-frm))
            refL:setPos(tmp_pos)

            --1/2bush 1
            --get
            refL= mainSF:getRef("warm_gear.ldr")
            local subSF = refL:getSubfile()
            refL = subSF:getRef("32123a.dat",2)
            --set visible
            refL:setVisible(true)
            --animation
            local tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()+5*(keyFrm[6]-frm))
            refL:setPos(tmp_pos)
        elseif(frm<keyFrm[7]) then
            --cross block, 32184.dat,in warm_gear.ldr subfile
            --get
            refL= mainSF:getRef("warm_gear.ldr")
            local subSF = refL:getSubfile()
            refL = subSF:getRef("32184.dat",1)
            --set visible
            refL:setVisible(true)
            --animation
            local tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()-5*(keyFrm[7]-frm))
            refL:setPos(tmp_pos)

            --1/2bush 1
            --get
            refL= mainSF:getRef("warm_gear.ldr")
            local subSF = refL:getSubfile()
            refL = subSF:getRef("32184.dat",2)
            --set visible
            refL:setVisible(true)
            --animation
            local tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()+5*(keyFrm[7]-frm))
            refL:setPos(tmp_pos)
        elseif(frm<=keyFrm[8]) then
            for i=1, 2 do
                refL = mainSF:getRef("99773.dat",i)
                refL:setVisible(true)               --setVisible
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()-3*(keyFrm[8]-frm))
                refL:setPos(tmp_pos)
            end
        elseif(frm<=keyFrm[9]) then
            for i = 1, 4 do
                refL = mainSF:getRef("32062.dat",i)
                refL:setVisible(true)
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()+4*(keyFrm[9]-frm+1))
                refL:setPos(tmp_pos)
            end
        elseif(frm<=keyFrm[10]) then
            for i=3, 4 do
                refL = mainSF:getRef("99773.dat",i)
                refL:setVisible(true)               --setVisible
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()+3*(keyFrm[10]-frm+1))
                refL:setPos(tmp_pos)
            end
        elseif(frm<keyFrm[11]) then
            for i=1, 2 do
                refL = mainSF:getRef("16616.dat",i)
                refL:setVisible(true)               --setVisible
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()+3*(1+keyFrm[11]-frm))
                refL:setPos(tmp_pos)
            end
            for i=3, 4 do
                refL = mainSF:getRef("16616.dat",i)
                refL:setVisible(true)               --setVisible
                local tmp_pos = refL:getPos()
                tmp_pos:setY(tmp_pos:getY()-3*(1+keyFrm[11]-frm))
                refL:setPos(tmp_pos)
            end
        elseif(frm<keyFrm[12]) then
        elseif(frm<keyFrm[13]) then 
            refL= mainSF:getRef("Handler.ldr")
            --set visible
            refL:setVisible(true)
            --animation
            tmp_pos = refL:getPos()
            tmp_pos:setX(tmp_pos:getX()-5*(keyFrm[13]-frm))
            refL:setPos(tmp_pos)

        end
    end
end

register()

--Calculate 1+2+3+...+n and return the result
function sigma(n)
    local i = 1
    local result =0
    for i = 1, n do
        result = result+i
    end
    return result
end

--Hide all bricks in subfile: subfile_name
--subfile_name should be a string
function setAllRefInvisible(subfile_name)
    local SF = ldc.subfile(subfile_name)
    if(SF == nil) then return nil
    else
        local count
        for count = 1, SF:getRefCount() do
            SF:getRef(count):setVisible(false)
        end
        return true
    end
end

--Set brick id in subfile:subfile_name visible
--id coule be part name or a number
function setRefVisible(subfile_name,id)
    local SF = ldc.subfile(subfile_name)
    if(SF == nil) then return nil
    elseif(SF:getRef(id) == nil) then return nil
    else SF:getRef(id):setVisible(true)
    end
end

function setRotateDirection(tmp_frm)
    --start from frm=384, there are somemistake on the animation which I have not konwn the reason yet`
    local re = (tmp_frm+20)%100
    if(tmp_frm < 180) then
        WarmRotateAxle = ldc.vector(0,0,1)
        GearRotateAxle = ldc.vector(0,1,0)
    elseif(re < 50) then
        WarmRotateAxle = ldc.vector(0,0,-1)
        GearRotateAxle = ldc.vector(0,-1,0)
    else
        WarmRotateAxle = ldc.vector(0,0,1)
        GearRotateAxle = ldc.vector(0,1,0)
    end
end