function register()
    local ani = ldc.animation('Test')

    ani:setLength(4)
    ani:setEvent('frame','onFrame')
end

function onFrame()
    local ani = ldc.animation()
    local mainSF = ldc.subfile()
    local mainRef = mainSF:getRef(1)

    local vec = ldc.vector()
    vec = mainRef:getPos()
    vec:setZ(vec:getZ()+1)
    mainRef:setPos(vec)
end

register()