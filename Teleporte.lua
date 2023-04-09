Tp = class("Tp", Entity)

function Tp:initialize(...)
    Entity.initialize(self, ...)
    self.currentRoom = self.room:getId()
    self.currentRoomName = self.room:getData().name
    self.destRoom = self.properties.destRoom
end

function Tp:onInteract()
    if self.room:getId() == self.currentRoom then
        local rooms = self.game:getRooms()
        local destRoom = rooms[self.destRoom]
        self.room:removeEntity(self)
        destRoom:addEntity(self)
        self.game:setRoom(destRoom:getId())
        self.game:getPlayer():setRoom(destRoom:getId())
        self.game:getPlayer():setPosition(self.properties.destX, self.properties.destY)
    end
end
