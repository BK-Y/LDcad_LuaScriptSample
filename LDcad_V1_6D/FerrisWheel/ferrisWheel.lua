require("math")

function register()
    local ani = ldc.animation("Running")
    fps = 25
    ani:setFPS(fps)
    ani:setLength(720*0.016)
    ani:setEvent('start','onStart')
    ani:setEvent('frame','onFrame')
end

function onStart()
    local mainSF = ldc.subfile()
    local refL_ori = mainSF:getRef('wheels.ldr')
    local refL_target = mainSF:getRef(11)
    oriPos=refL_ori:getPos();
end

--以oPos为中心，x轴正向为旋转方向,返回位置tPos旋转angDif弧度后的位置
--tPos，oPos 为ldc.vector类实例
--angDif为弧度,如果给角度，请用math模块下的math.rad()函数进行转换
--查到的资料说是右手系，但是实际操作的的时候感觉是左手系（我相信LDcad是右手系的）
function RotateAroundX(oPos,tPos,angDif) --return target position
    local tmpPos = ldc.vector()
    tmpPos:setX(tPos:getX()-oPos:getX())
    tmpPos:setY(tPos:getY()-oPos:getY())
    tmpPos:setZ(tPos:getZ()-oPos:getZ())
    local rePos=ldc.vector()
    rePos:setX(tmpPos:getX()+oPos:getX())
    rePos:setY(tmpPos:getY()*math.cos(angDif)+tmpPos:getZ()*math.sin(angDif)+oPos:getY())
    rePos:setZ(0-tmpPos:getY()*math.sin(angDif)+tmpPos:getZ()*math.cos(angDif)+oPos:getZ())
    
    return rePos
end

function onFrame()
    local ani = ldc.animation:getCurrent()
    local mainSF = ldc.subfile()
    local refL = mainSF:getRef('wheels.ldr')
    local mat = refL:getPosOri()
    local ori = ldc.vector(1,0,0)
    
    mat:setRotate((ani:getFrameNr()+1)*0.5,ori)
    refL:setOri(mat)

    local cnt
        for cnt=1,8 do
            refL = mainSF:getRef(cnt+10)
            refL:setPos(RotateAroundX(oriPos,refL:getPos(),-math.rad(0.5))) --math前面的负号：左右手系切换
            --print(refL:getPos())
        end
end

register()