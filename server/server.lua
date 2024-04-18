local QBCore = exports["qb-core"]:GetCoreObject()

lib.callback.register("jerico-peds:server:getPedsByCitizenId", function(source, data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Config.Peds[Player.PlayerData.citizenid] then
    return Config.Peds[Player.PlayerData.citizenid]
  end
  return false
end)
