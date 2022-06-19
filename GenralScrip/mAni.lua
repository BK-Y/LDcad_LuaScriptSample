--This moulde offers some useful animation tool,
require('math')

local moudle={}

--tmp variables used in this moudle
local i = 0
local v = 0
local max = 0

--Basic ldc.vector for rotate axle
moudle.ori_x = ldc.vector(1,0,0)
moudle.ori_y = ldc.vector(0,1,0)
moudle.ori_z = ldc.vector(0,0,1)

--This function is used to test the configuration of this moudle.
--测试用函数
moudle.test = function()
    print("Hello, moudle.test")
end

--This function is used to rotate target refline in subfile around axle.
--para: subfile: the file that target refline located
--      target:  target name in string
--      from : start position of subfile
--      to:    end position of subfile
--      angle: 
--      axle:
moudle.refRotate = function(subfile,target,from, to,angle,axle)
    local ref = subfile:getRef(1)
    local mat = ref:getPosOri()
    if (ref == nil) then
        error("Error when call function: mAni.refRotate:\n")
        error("the subfile you provide is nil")
        return nil
    end
    for i=from, to do
        ref = subfile:getRef(target,i)
        if(ref ~= nil) then 
            mat = ref:getOri()
            if(mat ~= nil) then
            mat:mulRotateBA(angle,axle)
            ref:setOri(mat)
            else 
                print("error2")
            end
        else
            print "error1"
        end
    end
end

--Hide all bricks in subfile
moudle.hideAll = function(subfile)
    local ref = subfile:getRef(1)
    if (ref == nil) then
        print("Error when call function: mAni.refRotate:\n")
        print("the subfile you provide is nil")
        return nil
    end
    local d = subfile:getRefCount()
    for i = 1, d do
        ref = subfile:getRef(i)
        ref:setVisible(false)
    end
end

--get target in subfile 
--para:
--     subfile:目标文件（也可以是子文件）
--      visiblity:可见性，false不可见，true可见
--      ...:积木位置描述
--              缺省：改变subfile里的第一行的可见性
--              只提供一个：可以是字符串或者数字，只改变该条目对应的行
--              多个参数：字符串后面接数字的：该字符串str和该数字num将被视作一组,查找第num个str
--              多个参数：连续数字 数字将被视为索引项目，如果数字后面还是数字，前面的数字将被视作子文件，然后在子文件中继续以后数字为索引查找
moudle.getRef = function(subfile,...)
    local arg = {}
    local tmpSF = subfile
    local tmpRef = tmpSF:getRef(1)

    for i, v in ipairs ({...}) do
        arg[i] = v
        max = i
    end

    --如果没有提供具体的目标，则设定subfile内的第一行的可见性
    if (max == 0) then
        return subfile:getRef(1)
    end
    local lock = 0
    --获取目标行
    tmpSF = subfile
    for i = 1,max do
        if(lock == 0)then  --当内部的条件满足时，跳过当前循环
            if(type(arg[i])=='string') then 
                if(type(arg[i+1]) == 'number') then
                    lock = 1    --下一个循环需要跳过
                    tmpRef = tmpSF:getRef(arg[i],arg[i+1])
                    if(i<max-1) then --接下来还有,当前tmpRef代表的行为子文件，而且要求设置子文件内部的行，需要设置tmpSF指向该子文件
                        tmpSF = tmpRef:getSubfile()
                    end
                else 
                    tmpRef = tmpSF:getRef(arg[i])
                    if(i<max) then --接下来还有,当前tmpRef代表的行为子文件，而且要求设置子文件内部的行，需要设置tmpSF指向该子文件
                        tmpSF = tmpRef:getSubfile()
                    end
                end
            else
                tmpRef = tmpSF:getRef(arg[i])
                if(i<max) then --接下来还有,当前tmpRef代表的行为子文件，而且要求设置子文件内部的行，需要设置tmpSF指向该子文件
                    tmpSF = tmpRef:getSubfile()
                end
            end
        else 
            lock = 0
        end
    end
    return tmpRef
end

--function: 平移旋转
--          以oPos为中心，x轴正向为旋转方向,返回位置tPos旋转angDif弧度后的位置
--返回值：   移动后的位置，ldc.vector类型
--tPos，oPos 为ldc.vector类实例
--angDif为弧度,如果给角度，请用math模块下的math.rad()函数进行转换
--查到的资料说是右手系，但是实际操作的的时候感觉是左手系（我相信LDcad是右手系的）
moudle.transRotateX = function(oPos,tPos,angDif)
    local tmpPos = ldc.vector()
    radAng = math.rad(angDif)
    tmpPos:setX(tPos:getX()-oPos:getX())
    tmpPos:setY(tPos:getY()-oPos:getY())
    tmpPos:setZ(tPos:getZ()-oPos:getZ())
    local rePos=ldc.vector()
    rePos:setX(tmpPos:getX()+oPos:getX())
    rePos:setY(tmpPos:getY()*math.cos(radAng)+tmpPos:getZ()*math.sin(radAng)+oPos:getY())
    rePos:setZ(0-tmpPos:getY()*math.sin(radAng)+tmpPos:getZ()*math.cos(radAng)+oPos:getZ())
    
    return rePos
end
--function: 平移旋转
--          以oPos为中心，x轴正向为旋转方向,返回位置tPos旋转angDif弧度后的位置
--返回值：   移动后的位置，ldc.vector类型
--tPos，oPos 为ldc.vector类实例
--angDif为弧度,如果给角度，请用math模块下的math.rad()函数进行转换
--查到的资料说是右手系，但是实际操作的的时候感觉是左手系（我相信LDcad是右手系的）
moudle.transRotateY = function(oPos,tPos,angDif)
    local tmpPos = ldc.vector()
    radAng = math.rad(angDif)
    tmpPos:setX(tPos:getX()-oPos:getX())
    tmpPos:setY(tPos:getY()-oPos:getY())
    tmpPos:setZ(tPos:getZ()-oPos:getZ())
    local rePos=ldc.vector()
    rePos:setX(tmpPos:getX()*math.cos(radAng)+tmpPos:getZ()*math.sin(radAng)+oPos:getX())
    rePos:setY(tmpPos:getY()+oPos:getY())
    rePos:setZ(-tmpPos:getX()*math.sin(radAng)+tmpPos:getZ()*math.cos(radAng)+oPos:getZ())
    
    return rePos
end
--function: 平移旋转
--          以oPos为中心，x轴正向为旋转方向,返回位置tPos旋转angDif弧度后的位置
--返回值：   移动后的位置，ldc.vector类型
--tPos，oPos 为ldc.vector类实例
--angDif为弧度,如果给角度，请用math模块下的math.rad()函数进行转换
--查到的资料说是右手系，但是实际操作的的时候感觉是左手系（我相信LDcad是右手系的）
moudle.transRotateZ = function(oPos,tPos,angDif)
    local tmpPos = ldc.vector()
    radAng = math.rad(angDif)
    tmpPos:setX(tPos:getX()-oPos:getX())
    tmpPos:setY(tPos:getY()-oPos:getY())
    tmpPos:setZ(tPos:getZ()-oPos:getZ())
    local rePos=ldc.vector()
    rePos:setX(tmpPos:getX()*math.cos(radAng)-tmpPos:getY()*math.sin(radAng)+oPos:getX())
    rePos:setY(tmpPos:getX()*math.sin(radAng)+tmpPos:getY()*math.cos(radAng)+oPos:getY())
    rePos:setZ(tmpPos:getZ()+oPos:getZ())
    
    return rePos
end

moudle.move = function(refLine,off_x,off_y,off_z)
    if (off_x == nil) then off_x = 0 end
    if (off_y == nil) then off_y = 0 end
    if (off_z == nil) then off_z = 0 end
    local tmpPos = refLine:getPos()
    tmpPos:add(off_x,off_y,off_z)
    refLine:setPos(tmpPos)
end
moudle.rotate = function(refLine,angle,axle)
    if(type(angle) ~= "number") then angle = 1 end
    local tmpOri = refLine:getOri()
    tmpOri:mulRotateBA(angle,axle)
    refLine:setOri(tmpOri)
end

return moudle