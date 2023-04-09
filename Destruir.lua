Destroy = class("Destroy", Entity)

function Destroy:initialize(...)
    Entity.initialize(self, ...)
    self.currentRoom = self.room:getId()
    self.destroyed = false
end

function Destroy:update()
    if not self.destroyed and self.game:getPlayer():getPosition() == self.properties.targetPosition then
        self.room:removeEntity(self)
        self.destroyed = true
    end
end
