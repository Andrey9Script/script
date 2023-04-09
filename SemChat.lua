AntiCheat = class("AntiCheat", Entity)

function AntiCheat:initialize(...)
    Entity.initialize(self, ...)
    self.checkSum = 0
    self.totalChecks = 0
end

function AntiCheat:update()
    self.totalChecks = self.totalChecks + 1
    local newCheckSum = self.game:getMapCheckSum()
    if newCheckSum ~= self.checkSum then
        self.game:exit("You have been disconnected for attempting to cheat!")
    end
end
